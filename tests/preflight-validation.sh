#!/usr/bin/env bash
set -Eeuo pipefail

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
MCSR_VARIANT=NLmcsrWL.sh
MCSR_PLATFORM=wayland
MCSR_TIER=NL
source "$ROOT/shared/install-common.sh"

grep -Fxq python "$ROOT/packages/pacman-common.txt" || {
    printf 'python3 validator runtime is not supplied by the official package manifest.\n' >&2
    exit 1
}
preflight_sources
printf 'Preflight source validation passed for %s.\n' "$MCSR_VARIANT"

TEST_ROOT=$(mktemp -d /tmp/mcsr-obs-sanitizer.XXXXXX)
trap 'rm -rf -- "$TEST_ROOT"' EXIT
NO_PYTHON_BIN="$TEST_ROOT/no-python-bin"
HOST_PATH=$PATH
mkdir -p "$NO_PYTHON_BIN" "$TEST_ROOT/no-python-home"
for command in find grep awk tail cut tee touch; do
    ln -s "$(command -v "$command")" "$NO_PYTHON_BIN/$command"
done

for command in sudo systemctl git pacman; do
    printf '#!/usr/bin/bash\nexit 0\n' >"$NO_PYTHON_BIN/$command"
    chmod 755 "$NO_PYTHON_BIN/$command"
done
printf '#!/usr/bin/bash\nprintf "1024\\t%%s\\n" "$2"\n' >"$NO_PYTHON_BIN/du"
printf '#!/usr/bin/bash\nprintf "Avail\\n999999999\\n"\n' >"$NO_PYTHON_BIN/df"
printf '#!/usr/bin/bash\nprintf "mcsrtest:x:1000:1000::%%s:/bin/bash\\n" "$MCSR_TARGET_HOME"\n' \
    >"$NO_PYTHON_BIN/getent"
chmod 755 "$NO_PYTHON_BIN/du" "$NO_PYTHON_BIN/df" "$NO_PYTHON_BIN/getent"

if no_python_output=$(PATH="$NO_PYTHON_BIN" ROOT="$ROOT" \
    MCSR_POST_PACKAGE_PATH="$HOST_PATH" \
    MCSR_VARIANT=NLmcsrWL.sh MCSR_PLATFORM=wayland MCSR_TIER=NL \
    MCSR_TARGET_USER=mcsrtest MCSR_TARGET_HOME="$TEST_ROOT/no-python-home" \
    /bin/bash -c '
        set -Eeuo pipefail
        ! command -v python3 >/dev/null 2>&1 || exit 97
        ! command -v curl >/dev/null 2>&1 || exit 98
        ! command -v makepkg >/dev/null 2>&1 || exit 99
        source "$ROOT/shared/install-common.sh"
        begin_rollback_state() { :; }
        install_pacman_packages() {
            stage "official Arch packages (test boundary)"
            printf "PACKAGE_INSTALL_STAGE_REACHED\\n"
            PATH="$MCSR_POST_PACKAGE_PATH"
            export PATH
        }
        install_aur_packages() { printf "POST_PACKAGE_SANITIZER_PASSED\\n"; exit 0; }
        run_install
    ' 2>&1); then
    no_python_status=0
else
    no_python_status=$?
fi
if ((no_python_status != 0)); then
    printf 'Python-free pre-package test exited %d:\n%s\n' \
        "$no_python_status" "$no_python_output" >&2
    exit 1
fi
after_package_stage=${no_python_output#*PACKAGE_INSTALL_STAGE_REACHED}
after_obs_validation=${after_package_stage#*validate OBS profile credentials}
[[ "$after_package_stage" != "$no_python_output" \
    && "$after_obs_validation" != "$after_package_stage" \
    && "$after_obs_validation" == *"POST_PACKAGE_SANITIZER_PASSED"* ]] || {
    printf 'run_install did not reach package install then OBS validation in order.\n' >&2
    printf '%s\n' "$no_python_output" | tail -n 30 >&2
    exit 1
}
[[ "$no_python_output" != *"OBS profile sanitization"* \
    && "$no_python_output" != *"python3: command not found"* ]] || {
    printf 'Pre-package path unexpectedly invoked the Python OBS sanitizer.\n' >&2
    exit 1
}
printf 'Minimal-prerequisite run_install preflight reaches package installation without python3/curl/makepkg.\n'

expect_rejected() {
    local fixture=$1 expected_file=$2 expected_field=$3 expected_reason=$4 output status
    if output=$(validate_obs_profile_sanitization "$fixture" 2>&1); then
        status=0
    else
        status=$?
    fi
    [[ "$status" -ne 0 ]] || {
        printf 'Expected OBS sanitizer rejection: %s\n' "$expected_file" >&2
        exit 1
    }
    [[ "$output" == *"file: $expected_file"* ]] || {
        printf 'Sanitizer diagnostic omitted file (%s).\n' "$expected_file" >&2
        exit 1
    }
    [[ "$output" == *"field: $expected_field"* ]] || {
        printf 'Sanitizer diagnostic omitted field (%s).\n' "$expected_field" >&2
        exit 1
    }
    [[ "$output" == *"$expected_reason"* ]] || {
        printf 'Sanitizer diagnostic omitted reason (%s).\n' "$expected_reason" >&2
        exit 1
    }
    [[ "$output" != *DUMMY_* ]] || {
        printf 'Sanitizer diagnostic exposed a fixture value.\n' >&2
        exit 1
    }
}

mkdir -p "$TEST_ROOT/stream" "$TEST_ROOT/account" "$TEST_ROOT/token" \
    "$TEST_ROOT/malformed" "$TEST_ROOT/legitimate"
printf '{"type":"rtmp_common","settings":{"key":"DUMMY_STREAM_KEY"}}\n' \
    >"$TEST_ROOT/stream/service.json"
expect_rejected "$TEST_ROOT/stream" 'service.json' 'settings.key' 'streaming service key'

printf '[Twitch]\nAccountId=DUMMY_ACCOUNT_TOKEN\n' >"$TEST_ROOT/account/basic.ini"
expect_rejected "$TEST_ROOT/account" 'basic.ini' 'line 2:AccountId' 'account identifier field'

printf '[Twitch]\nToken=DUMMY_ACCESS_TOKEN\n' >"$TEST_ROOT/token/basic.ini"
expect_rejected "$TEST_ROOT/token" 'basic.ini' 'line 2:Token' 'credential-like field'

printf '{"settings": {\n' >"$TEST_ROOT/malformed/service.json"
expect_rejected "$TEST_ROOT/malformed" 'service.json' '<document>' 'invalid JSON'

printf '{"settings":{"device_uuid":"DUMMY_DEVICE_UUID","source_id":"DUMMY_SOURCE_ID","key":""}}\n' \
    >"$TEST_ROOT/legitimate/service.json"
validate_obs_profile_sanitization "$TEST_ROOT/legitimate"
validate_obs_profile_sanitization "$ROOT/shared/obs/profiles"

if missing_python_output=$(PATH="$NO_PYTHON_BIN" \
    validate_obs_profile_sanitization "$TEST_ROOT/legitimate" 2>&1); then
    printf 'Sanitizer unexpectedly succeeded without python3.\n' >&2
    exit 1
fi
[[ "$missing_python_output" == *"required command missing: python3"* \
    && "$missing_python_output" != *"OBS profile sanitization failed"* ]] || {
    printf 'Missing Python was not reported explicitly by the sanitizer.\n' >&2
    exit 1
}

printf 'OBS sanitizer regression cases passed.\n'
