#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MCSR_VARIANT="LmcsrX11.sh"
MCSR_PLATFORM="x11"
MCSR_TIER="L"
source "$ROOT/shared/install-common.sh"
run_install
