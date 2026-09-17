#!/usr/bin/env bash
set -Eeuo pipefail

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
MCSR_VARIANT=NLmcsrWL.sh
MCSR_PLATFORM=wayland
MCSR_TIER=NL
source "$ROOT/shared/install-common.sh"

preflight_sources
printf 'Preflight source validation passed for %s.\n' "$MCSR_VARIANT"

TEST_ROOT=$(mktemp -d /tmp/mcsr-obs-sanitizer.XXXXXX)
trap 'rm -rf -- "$TEST_ROOT"' EXIT

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

expect_preflight_rejected() {
    local fixture=$1 expected_file=$2 expected_field=$3 output status
    if output=$(ROOT="$ROOT" MCSR_VARIANT=NLmcsrWL.sh MCSR_PLATFORM=wayland MCSR_TIER=NL \
        bash -c 'source "$ROOT/shared/install-common.sh"; preflight_sources "$1"' _ "$fixture" 2>&1); then
        status=0
    else
        status=$?
    fi
    [[ "$status" -ne 0 && "$output" == *"file: $expected_file"* \
        && "$output" == *"field: $expected_field"* \
        && "$output" == *"OBS profile sanitization failed"* ]] || {
        printf 'preflight_sources did not report the bad OBS field clearly.\n' >&2
        exit 1
    }
    [[ "$output" != *DUMMY_* ]] || {
        printf 'Preflight diagnostic exposed a fixture value.\n' >&2
        exit 1
    }
}

mkdir -p "$TEST_ROOT/stream" "$TEST_ROOT/account" "$TEST_ROOT/token" \
    "$TEST_ROOT/malformed" "$TEST_ROOT/legitimate"
printf '{"type":"rtmp_common","settings":{"key":"DUMMY_STREAM_KEY"}}\n' \
    >"$TEST_ROOT/stream/service.json"
expect_rejected "$TEST_ROOT/stream" 'service.json' 'settings.key' 'streaming service key'
expect_preflight_rejected "$TEST_ROOT/stream" 'service.json' 'settings.key'

printf '[Twitch]\nAccountId=DUMMY_ACCOUNT_TOKEN\n' >"$TEST_ROOT/account/basic.ini"
expect_rejected "$TEST_ROOT/account" 'basic.ini' 'line 2:AccountId' 'account identifier field'

printf '[Twitch]\nToken=DUMMY_ACCESS_TOKEN\n' >"$TEST_ROOT/token/basic.ini"
expect_rejected "$TEST_ROOT/token" 'basic.ini' 'line 2:Token' 'credential-like field'

printf '{"settings": {\n' >"$TEST_ROOT/malformed/service.json"
expect_rejected "$TEST_ROOT/malformed" 'service.json' '<document>' 'invalid JSON'

printf '{"settings":{"device_uuid":"DUMMY_DEVICE_UUID","source_id":"DUMMY_SOURCE_ID","key":""}}\n' \
    >"$TEST_ROOT/legitimate/service.json"
validate_obs_profile_sanitization "$TEST_ROOT/legitimate"

printf 'OBS sanitizer regression cases passed.\n'
