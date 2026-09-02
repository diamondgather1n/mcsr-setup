#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MCSR_VARIANT="NLmcsrWL.sh"
MCSR_PLATFORM="wayland"
MCSR_TIER="NL"
source "$ROOT/shared/install-common.sh"
run_install
