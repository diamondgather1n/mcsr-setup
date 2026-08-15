#!/usr/bin/env bash
set -Eeuo pipefail

stage_preflight() {
  CURRENT_STAGE="preflight"

  [[ -r /etc/arch-release ]] || die "v0.1 supports Arch Linux only"
  command -v bash >/dev/null || die "bash is required"
  command -v pacman >/dev/null || die "pacman is required"
  command -v getent >/dev/null || die "getent is required"
  command -v id >/dev/null || die "id is required"

  local passwd_entry
  passwd_entry="$(getent passwd "$TARGET_USER" || true)"
  [[ -n "$passwd_entry" ]] \
    || die "target user $TARGET_USER does not exist; user creation is not implemented in v0.1"

  local actual_home
  actual_home="$(cut -d: -f6 <<<"$passwd_entry")"
  [[ "$actual_home" == "$TARGET_HOME" ]] \
    || die "target user $TARGET_USER has home $actual_home, expected $TARGET_HOME"

  if (( EUID == 0 )); then
    command -v runuser >/dev/null || die "runuser is required in root mode"
    log_ok "root mode with existing target user $TARGET_USER"
  else
    [[ "$(id -un)" == "$TARGET_USER" ]] \
      || die "run as $TARGET_USER or root"
    if (( ! DRY_RUN )) \
      && [[ "$TARGET_ROOT" == "/" ]] \
      && (( ! SKIP_PACKAGES || ! SKIP_CONFIG ))
    then
      if ! command -v sudo >/dev/null; then
        die "sudo is not installed; rerun setup/bootstrap.sh as root"
      fi
      sudo -v
      log_ok "sudo authentication available for $TARGET_USER"
    else
      log_ok "this mode does not require sudo"
    fi
  fi

  [[ "$TARGET_ROOT" == /* && "$TARGET_ROOT" != *'..'* ]] \
    || die "target root must be an absolute path without '..': $TARGET_ROOT"
  if [[ "$TARGET_ROOT" != "/" && "$SKIP_PACKAGES" -eq 0 && "$DRY_RUN" -eq 0 ]]; then
    die "package installation is only supported for target root /; use --skip-packages for staging tests"
  fi

  if [[ -e /var/lib/pacman/db.lck && "$SKIP_PACKAGES" -eq 0 && "$DRY_RUN" -eq 0 ]]; then
    die "pacman database is locked: /var/lib/pacman/db.lck"
  fi

  if (( SKIP_PACKAGES )); then
    log_ok "network is not required when the package stage is skipped"
  elif getent ahosts archlinux.org >/dev/null 2>&1; then
    log_ok "DNS resolution is available"
  elif (( DRY_RUN )); then
    log_warn "DNS resolution was unavailable; dry run continues without network"
  else
    die "working DNS/internet is required"
  fi

  log_ok "Arch preflight passed for profile $PROFILE_NAME"
}
