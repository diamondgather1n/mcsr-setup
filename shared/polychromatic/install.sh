#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
[[ "${EUID}" -ne 0 ]] || { echo "Run the setup as nathan, not root." >&2; exit 1; }
command -v makepkg >/dev/null || { echo "makepkg is required." >&2; exit 1; }

build_dir="$(mktemp -d)"
trap 'rm -rf "$build_dir"' EXIT
mkdir -p "$build_dir/src"
cp -a "$ROOT/shared/polychromatic/PKGBUILD.pinned" "$build_dir/PKGBUILD"
cp -a "$ROOT/shared/polychromatic/source" "$build_dir/src/polychromatic"

(
    cd "$build_dir"
    makepkg --syncdeps --install --noconfirm
)

command -v polychromatic-cli >/dev/null || {
    echo "Polychromatic build completed without installing polychromatic-cli." >&2
    exit 1
}
