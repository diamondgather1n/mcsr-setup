#!/usr/bin/env bash
set -Eeuo pipefail

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
TEST_ROOT=$(mktemp -d /tmp/mcsr-reset-session.XXXXXX)
trap 'rm -rf -- "$TEST_ROOT"' EXIT
TEST_USER=$(/usr/bin/id -un)
FAKE_BIN="$TEST_ROOT/bin"
mkdir -p "$FAKE_BIN"

cat >"$FAKE_BIN/id" <<'SH'
#!/usr/bin/env bash
if [[ "${1-}" == -nG ]]; then
    printf 'input openrazer\n'
else
    exec /usr/bin/id "$@"
fi
SH
cat >"$FAKE_BIN/sudo" <<'SH'
#!/usr/bin/env bash
case "${1-}" in
    systemctl|pacman|gpasswd|archlinux-java)
        command=$1
        shift
        exec "$command" "$@"
        ;;
    *)
        printf 'unexpected sudo command: %s\n' "$*" >&2
        exit 90
        ;;
esac
SH
cat >"$FAKE_BIN/systemctl" <<'SH'
#!/usr/bin/env bash
printf 'systemctl %s\n' "$*" >>"$RESET_TEST_EVENTS"
if [[ "$*" == 'is-active --quiet lightdm.service' ]]; then exit 0; fi
if [[ "${1-}" == stop && "${2-}" == lightdm.service ]]; then
    printf 'lightdm-stop-called\n' >>"$RESET_TEST_EVENTS"
fi
exit 0
SH
cat >"$FAKE_BIN/gpasswd" <<'SH'
#!/usr/bin/env bash
printf 'gpasswd %s\n' "$*" >>"$RESET_TEST_EVENTS"
[[ "${RESET_TEST_FAIL_GPASSWD:-0}" != 1 ]]
SH
cat >"$FAKE_BIN/pacman" <<'SH'
#!/usr/bin/env bash
printf 'pacman %s\n' "$*" >>"$RESET_TEST_EVENTS"
if [[ -x "$RESET_TEST_HOME/DoOvers/reset.sh" ]]; then
    printf 'reset-present-during-package-phase\n' >>"$RESET_TEST_EVENTS"
else
    printf 'reset-missing-during-package-phase\n' >>"$RESET_TEST_EVENTS"
    exit 91
fi
for tool in verify-install.sh undo-waybar.sh; do
    [[ -x "$RESET_TEST_HOME/DoOvers/$tool" ]] || exit 92
done
SH
cat >"$FAKE_BIN/archlinux-java" <<'SH'
#!/usr/bin/env bash
case "${1-}" in
    get) printf 'java-26-openjdk\n' ;;
    status) printf 'Available Java environments:\n  java-21-openjdk\n  java-26-openjdk (default)\n' ;;
    set|unset) printf 'archlinux-java %s\n' "$*" >>"$RESET_TEST_EVENTS" ;;
    *) exit 2 ;;
esac
SH
chmod 755 "$FAKE_BIN"/*

make_case() {
    local name=$1 home="$TEST_ROOT/$1/home" state_id=reset-test script
    local state="$home/DoOvers/state/$state_id"
    mkdir -p "$state/files"
    sed -e "s|@USER@|$TEST_USER|g" -e "s|@HOME@|$home|g" \
        "$ROOT/shared/templates/reset.sh.in" >"$home/DoOvers/reset.sh"
    printf '#!/usr/bin/env bash\nexit 0\n' >"$home/DoOvers/verify-install.sh"
    printf '#!/usr/bin/env bash\nexit 0\n' >"$home/DoOvers/undo-waybar.sh"
    printf 'installer-owned payload\n' >"$home/installer-payload"
    chmod 755 "$home/DoOvers/reset.sh" "$home/DoOvers/verify-install.sh" "$home/DoOvers/undo-waybar.sh"
    printf '%s\n' "$state_id" >"$home/DoOvers/state/latest"

    : >"$state/files.before"
    : >"$state/files.after"
    for script in "$home/DoOvers/reset.sh" "$home/DoOvers/verify-install.sh" \
        "$home/DoOvers/undo-waybar.sh" "$home/installer-payload"; do
        printf '%s\0user:new-file\0\0' "$script" >>"$state/files.before"
        printf '%s\0file:%s\0' "$script" "$(sha256sum -- "$script" | awk '{print $1}')" >>"$state/files.after"
    done

    printf 'foot\nkeyd\nwaybar\n' >"$state/packages.added"
    printf 'wheel\n' >"$state/groups.before"
    printf 'java-21-openjdk\n' >"$state/java.before"
    printf 'java-26-openjdk\n' >"$state/java.after"
    : >"$state/services.before"
    printf 'system\0NetworkManager.service\0enabled\0active\0' >>"$state/services.before"
    printf 'system\0keyd.service\0not-found\0inactive\0' >>"$state/services.before"
    printf 'system\0lightdm.service\0not-found\0inactive\0' >>"$state/services.before"
    printf 'user\0pipewire.socket\0not-found\0inactive\0' >>"$state/services.before"
    printf '%s\n' "$home"
}

run_reset() {
    local home=$1 event_log=$2
    RESET_TEST_HOME="$home" RESET_TEST_EVENTS="$event_log" \
        HOME="$home" PATH="$FAKE_BIN:/usr/bin:/bin" \
        bash "$home/DoOvers/reset.sh"
}

home=$(make_case success)
events="$TEST_ROOT/success.events"
: >"$events"
run_reset "$home" "$events" >"$TEST_ROOT/success.stdout" 2>&1
state="$home/DoOvers/state/reset-test"

if grep -Fxq 'systemctl stop lightdm.service' "$events"; then
    printf 'Reset attempted to stop its active LightDM session.\n' >&2
    exit 1
fi
grep -Fq 'systemctl disable lightdm.service' "$events"
grep -Fq 'systemctl enable NetworkManager.service' "$events"
grep -Fq 'systemctl disable keyd.service' "$events"
grep -Fq 'systemctl stop keyd.service' "$events"
grep -Fq 'DEFERRED stop lightdm.service' "$state/reset.log"
grep -Fq "gpasswd -d $TEST_USER input" "$events"
grep -Fq "gpasswd -d $TEST_USER openrazer" "$events"
grep -Fq 'pacman -R --noconfirm foot keyd waybar' "$events"
grep -Fq 'reset-present-during-package-phase' "$events"
grep -Fq 'archlinux-java set java-21-openjdk' "$events"
grep -Fq 'File phase summary:' "$state/reset.log"
package_line=$(grep -n 'Package removal transaction completed' "$state/reset.log" | cut -d: -f1)
summary_line=$(grep -n 'File rollback total:' "$state/reset.log" | cut -d: -f1)
[[ "$package_line" -lt "$summary_line" ]]
grep -Fq 'Reset complete.' "$state/reset.log"
[[ ! -e "$home/DoOvers/reset.sh" && ! -e "$home/DoOvers/verify-install.sh" \
    && ! -e "$home/DoOvers/undo-waybar.sh" ]] || {
    printf 'Successful reset did not remove unchanged recovery helpers at final cleanup.\n' >&2
    exit 1
}
[[ ! -e "$home/installer-payload" ]]

failed_home=$(make_case failure)
failed_events="$TEST_ROOT/failure.events"
: >"$failed_events"
if RESET_TEST_FAIL_GPASSWD=1 run_reset "$failed_home" "$failed_events" \
    >"$TEST_ROOT/failure.stdout" 2>&1; then
    printf 'Injected reset failure unexpectedly succeeded.\n' >&2
    exit 1
fi
failed_state="$failed_home/DoOvers/state/reset-test"
grep -Fq 'Stage: group membership restoration' "$failed_state/reset.log"
grep -Fq 'RESET FAILED' "$failed_state/reset.log"
grep -Fq 'Status: 1' "$failed_state/reset.log"
grep -Fq 'Command: sudo gpasswd' "$failed_state/reset.log"
[[ -x "$failed_home/DoOvers/reset.sh" ]]
! grep -Fq 'pacman -R' "$failed_events"

printf 'Session-safe reset/deferred LightDM/logging/order/failure regression passed.\n'
