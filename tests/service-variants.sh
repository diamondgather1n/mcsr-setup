#!/usr/bin/env bash
set -Eeuo pipefail

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
TEST_ROOT=$(mktemp -d /tmp/mcsr-service-variants.XXXXXX)
trap 'rm -rf -- "$TEST_ROOT"' EXIT
BIN="$TEST_ROOT/bin"
mkdir -p "$BIN"

cat >"$BIN/systemctl" <<'SH'
#!/usr/bin/env bash
set -Eeuo pipefail
printf '%s\n' "$*" >>"$SERVICE_COMMANDS"
scope=system
if [[ "${1-}" == --user ]]; then
    scope=user
    shift
fi
action=${1-}
shift || :
while [[ "${1-}" == --* ]]; do shift; done
case "$action" in
    enable)
        for unit in "$@"; do printf '%s\n' "$unit" >>"$SERVICE_STATE/enabled.$scope"; done
        ;;
    disable)
        for unit in "$@"; do
            if [[ -f "$SERVICE_STATE/enabled.$scope" ]]; then
                grep -vxF "$unit" "$SERVICE_STATE/enabled.$scope" >"$SERVICE_STATE/enabled.$scope.tmp" || :
                mv "$SERVICE_STATE/enabled.$scope.tmp" "$SERVICE_STATE/enabled.$scope"
            fi
            printf '%s\n' "$unit" >>"$SERVICE_STATE/disabled.$scope"
        done
        ;;
    is-enabled)
        grep -Fxq "${1:?}" "$SERVICE_STATE/enabled.$scope"
        ;;
    is-active)
        [[ "${1-}" == keyd.service ]]
        ;;
    *) exit 0 ;;
esac
SH
cat >"$BIN/sudo" <<'SH'
#!/usr/bin/env bash
exec "$@"
SH
cat >"$BIN/usermod" <<'SH'
#!/usr/bin/env bash
exit 0
SH
cat >"$BIN/getent" <<'SH'
#!/usr/bin/env bash
case "${2-}" in
    openrazer|plugdev) printf '%s:x:999:\n' "$2" ;;
    *) exit 2 ;;
esac
SH
chmod 755 "$BIN"/*

run_variant() {
    local variant=$1 platform=$2 tier=$3 label=$4 state="$TEST_ROOT/$4/state"
    mkdir -p "$state" "$TEST_ROOT/$4/home"
    : >"$TEST_ROOT/$4/commands"
    PATH="$BIN:$PATH" SERVICE_STATE="$state" SERVICE_COMMANDS="$TEST_ROOT/$4/commands" \
        ROOT="$ROOT" MCSR_VARIANT="$variant" MCSR_PLATFORM="$platform" MCSR_TIER="$tier" \
        MCSR_TARGET_USER=mcsrtest MCSR_TARGET_HOME="$TEST_ROOT/$4/home" MCSR_STAGING=0 \
        bash -c 'set -Eeuo pipefail; source "$ROOT/shared/install-common.sh"; enable_system_services'
}

run_variant NLmcsrWL.sh wayland NL nl-wayland
grep -Fxq 'disable lightdm.service' "$TEST_ROOT/nl-wayland/commands"
grep -Fxq 'enable NetworkManager.service' "$TEST_ROOT/nl-wayland/commands"
! grep -Fxq 'enable NetworkManager.service lightdm.service' "$TEST_ROOT/nl-wayland/commands"
! grep -Fxq 'lightdm.service' "$TEST_ROOT/nl-wayland/state/enabled.system"
grep -Fxq 'keyd.service' "$TEST_ROOT/nl-wayland/state/enabled.system"
printf '[OK] NL Wayland boots without an enabled display manager; NetworkManager and keyd remain enabled.\n'

run_variant LmcsrWL.sh wayland L l-wayland
run_variant NLmcsrX11.sh x11 NL nl-x11
run_variant LmcsrX11.sh x11 L l-x11
for variant in l-wayland nl-x11 l-x11; do
    grep -Fxq 'enable lightdm.service' "$TEST_ROOT/$variant/commands"
    grep -Fxq 'enable NetworkManager.service' "$TEST_ROOT/$variant/commands"
    grep -Fxq 'lightdm.service' "$TEST_ROOT/$variant/state/enabled.system"
done
printf '[OK] L Wayland and both X11 variants retain their existing LightDM behavior.\n'
