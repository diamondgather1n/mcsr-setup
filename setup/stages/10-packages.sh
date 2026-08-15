#!/usr/bin/env bash
set -Eeuo pipefail

collect_selected_packages() {
  local official_name="$1"
  local aur_name="$2"
  local -n official_output="$official_name"
  local -n aur_output="$aur_name"
  local -a additions=()

  read_manifest "$SETUP_DIR/packages/pacman.txt" official_output
  read_manifest "$SETUP_DIR/packages/aur.txt" aur_output

  if (( INCLUDE_OPTIONAL )); then
    read_manifest "$SETUP_DIR/packages/optional-pacman.txt" additions
    official_output+=("${additions[@]}")
    read_manifest "$SETUP_DIR/packages/optional-aur.txt" additions
    aur_output+=("${additions[@]}")
  fi

  if (( INCLUDE_LEGACY_PACKAGES )); then
    read_manifest "$SETUP_DIR/packages/legacy-pacman.txt" additions
    official_output+=("${additions[@]}")
  fi
}

stage_packages() {
  CURRENT_STAGE="packages"

  local manifest
  for manifest in \
    "$SETUP_DIR/packages/pacman.txt" \
    "$SETUP_DIR/packages/aur.txt" \
    "$SETUP_DIR/packages/optional-pacman.txt" \
    "$SETUP_DIR/packages/optional-aur.txt" \
    "$SETUP_DIR/packages/legacy-pacman.txt"
  do
    validate_manifest "$manifest"
  done

  local -a official_packages=()
  local -a aur_packages=()
  collect_selected_packages official_packages aur_packages

  if (( SKIP_PACKAGES )); then
    log_info "package stage skipped"
    return
  fi

  if (( DRY_RUN )); then
    local package
    local unavailable=0
    for package in "${official_packages[@]}"; do
      if ! pacman -Si "$package" >/dev/null 2>&1; then
        log_warn "official package is absent from current sync databases: $package"
        unavailable=$((unavailable + 1))
      fi
    done
    (( unavailable == 0 )) \
      || die "$unavailable selected official package(s) could not be resolved"
    log_ok "${#official_packages[@]} selected official packages resolve"
    log_info "planned official packages: ${official_packages[*]}"
    log_info "planned AUR packages: ${aur_packages[*]}"
    return
  fi

  log_info "running one full Arch upgrade and official package transaction"
  run_as_root pacman -Syu --needed -- "${official_packages[@]}"
  log_ok "official package transaction completed"

  if (( ${#aur_packages[@]} == 0 )); then
    PACKAGE_INSTALL_PERFORMED=1
    return
  fi

  local aur_helper=""
  if [[ -x /usr/bin/yay ]]; then
    aur_helper=/usr/bin/yay
  elif [[ -x /usr/bin/paru ]]; then
    aur_helper=/usr/bin/paru
  else
    die "no yay or paru AUR helper is installed; automatic helper bootstrap is deferred in v0.1, so install one and rerun"
  fi

  log_info "installing AUR packages as $TARGET_USER with ${aur_helper##*/}"
  run_as_target_user "$aur_helper" -S --needed -- "${aur_packages[@]}"
  log_ok "AUR package transaction completed"
  PACKAGE_INSTALL_PERFORMED=1
}
