#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MCSR_VARIANT="LmcsrWL.sh"
MCSR_PLATFORM="wayland"
MCSR_TIER="L"
source "$ROOT/shared/install-common.sh"
run_install
