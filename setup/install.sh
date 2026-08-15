#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

usage() {
  printf '%s\n' \
    "usage: setup/bootstrap.sh [options]" \
    "" \
    "  --profile NAME               profile to use (default: nathan)" \
    "  --dry-run                    inspect and validate without writing" \
    "  --skip-packages              skip pacman and AUR transactions" \
    "  --skip-config                skip configuration restoration" \
    "  --include-optional           install optional pacman/AUR packages" \
    "  --include-legacy-packages    install inactive i3/X11 package set" \
    "  --target-root PATH           stage files below PATH (requires --skip-packages)" \
    "  -h, --help                   show this help"
}

PROFILE_NAME="nathan"
DRY_RUN=0
SKIP_PACKAGES=0
SKIP_CONFIG=0
INCLUDE_OPTIONAL=0
INCLUDE_LEGACY_PACKAGES=0
TARGET_ROOT="/"
PACKAGE_INSTALL_PERFORMED=0
CONFIG_INSTALL_PERFORMED=0

while (( $# > 0 )); do
  case "$1" in
    --profile)
      (( $# >= 2 )) || die "--profile requires a value"
      PROFILE_NAME="$2"
      shift 2
      ;;
    --profile=*)
      PROFILE_NAME="${1#*=}"
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --skip-packages)
      SKIP_PACKAGES=1
      shift
      ;;
    --skip-config)
      SKIP_CONFIG=1
      shift
      ;;
    --include-optional)
      INCLUDE_OPTIONAL=1
      shift
      ;;
    --include-legacy-packages)
      INCLUDE_LEGACY_PACKAGES=1
      shift
      ;;
    --target-root)
      (( $# >= 2 )) || die "--target-root requires a value"
      TARGET_ROOT="$2"
      shift 2
      ;;
    --target-root=*)
      TARGET_ROOT="${1#*=}"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage >&2
      die "unknown option: $1"
      ;;
  esac
done

[[ "$PROFILE_NAME" =~ ^[a-z0-9_-]+$ ]] || die "invalid profile name: $PROFILE_NAME"
PROFILE_DIR="$SETUP_DIR/profiles/$PROFILE_NAME"
[[ -d "$PROFILE_DIR" ]] || die "profile does not exist: $PROFILE_NAME"
source "$PROFILE_DIR/profile.conf"
TARGET_USER="$PROFILE_USER"
TARGET_HOME="$PROFILE_HOME"

source "$SETUP_DIR/stages/00-preflight.sh"
source "$SETUP_DIR/stages/10-packages.sh"
source "$SETUP_DIR/stages/20-config.sh"
source "$SETUP_DIR/stages/90-validate.sh"

trap 'setup_error "$?" "$LINENO" "$BASH_COMMAND"' ERR

log_info "repository: $REPO_ROOT"
log_info "profile: $PROFILE_NAME"
log_info "target root: $TARGET_ROOT"
(( DRY_RUN )) && log_info "mode: dry run"

stage_preflight
stage_packages
stage_config
stage_validate

log_ok "v0.1 setup run completed"
