#!/usr/bin/env bash
set -Eeuo pipefail

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
MCSR_VARIANT=NLmcsrWL.sh
MCSR_PLATFORM=wayland
MCSR_TIER=NL
MCSR_TARGET_USER=mcsrtest
TEST_ROOT=$(mktemp -d /tmp/mcsr-rollback-locale.XXXXXX)
MCSR_TARGET_HOME="$TEST_ROOT/home"
mkdir -p "$MCSR_TARGET_HOME" "$TEST_ROOT/state/files" "$TEST_ROOT/bin"
trap 'rm -rf -- "$TEST_ROOT"' EXIT

source "$ROOT/shared/install-common.sh"
ROLLBACK_STATE="$TEST_ROOT/state"
unset MCSR_STAGING LC_ALL
export LANG=en_GB.UTF-8

before_packages=(a a-1 base xorg-xwayland)
after_packages=(a a-1 a-plus a1 aa base xorg-xwayland zellij)
printf '%s\n' "${before_packages[@]}" | LC_ALL=C sort >"$ROLLBACK_STATE/packages.before"
printf '%s\n' "${after_packages[@]}" >"$TEST_ROOT/packages.after.raw"
: >"$ROLLBACK_STATE/files.before"

cat >"$TEST_ROOT/bin/pacman" <<'SH'
#!/usr/bin/env bash
[[ "${1-}" == -Qq ]] || exit 2
cat "$MCSR_TEST_PACKAGES_AFTER"
SH
cat >"$TEST_ROOT/bin/comm" <<'SH'
#!/usr/bin/env bash
[[ "${LC_ALL-}" == C ]] || {
    printf 'comm was not invoked with the C locale\n' >&2
    exit 65
}
exec /usr/bin/comm "$@"
SH
chmod 755 "$TEST_ROOT/bin/pacman" "$TEST_ROOT/bin/comm"
export MCSR_TEST_PACKAGES_AFTER="$TEST_ROOT/packages.after.raw"
PATH="$TEST_ROOT/bin:$PATH"

if locale -a 2>/dev/null | grep -Eiq '^en_GB\.(utf8|UTF-8)$'; then
    printf 'Rollback locale test process: en_GB.UTF-8 available.\n'
else
    printf 'en_GB.UTF-8 unavailable; regression shim will require LC_ALL=C at comm.\n'
fi

finish_rollback_state

LC_ALL=C sort -c "$ROLLBACK_STATE/packages.before"
LC_ALL=C sort -c "$ROLLBACK_STATE/packages.after"
printf '%s\n' a-plus a1 aa zellij >"$TEST_ROOT/packages.added.expected"
cmp -s "$TEST_ROOT/packages.added.expected" "$ROLLBACK_STATE/packages.added" || {
    printf 'packages.added did not contain exactly the new package set.\n' >&2
    exit 1
}
[[ -s "$ROLLBACK_STATE/packages.before" && -s "$ROLLBACK_STATE/packages.after" \
    && -s "$ROLLBACK_STATE/packages.added" ]] || {
    printf 'Rollback package-list fixture unexpectedly empty.\n' >&2
    exit 1
}

printf 'Rollback locale/package-diff regression passed.\n'
