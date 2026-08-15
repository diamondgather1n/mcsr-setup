#!/usr/bin/env bash
set -Eeuo pipefail

copy_user_path() {
  local source="$1"
  local destination="$2"
  local parent
  parent="$(dirname "$destination")"

  if [[ -d "$source" && ! -L "$source" ]]; then
    if [[ "$TARGET_ROOT" == "/" && "$(id -un)" != "$TARGET_USER" ]]; then
      run_as_target_user mkdir -p "$destination"
      run_as_target_user cp -dR --preserve=mode,timestamps "$source/." "$destination/"
    else
      mkdir -p "$destination"
      cp -dR --preserve=mode,timestamps "$source/." "$destination/"
    fi
  else
    if [[ "$TARGET_ROOT" == "/" && "$(id -un)" != "$TARGET_USER" ]]; then
      run_as_target_user mkdir -p "$parent"
      run_as_target_user cp -d --preserve=mode,timestamps -T "$source" "$destination"
    else
      mkdir -p "$parent"
      cp -d --preserve=mode,timestamps -T "$source" "$destination"
    fi
  fi
}

copy_system_path() {
  local source="$1"
  local destination="$2"
  local mode
  mode="$(stat -c '%a' "$source")"

  if [[ "$TARGET_ROOT" == "/" ]]; then
    run_as_root install -D -m "$mode" -o root -g root "$source" "$destination"
  else
    mkdir -p "$(dirname "$destination")"
    cp -d --preserve=mode,timestamps -T "$source" "$destination"
  fi
}

copy_mapped_path() {
  local scope="$1"
  local category="$2"
  local source_relative="$3"
  local destination_relative="$4"
  local requirement="$5"
  local source="$REPO_ROOT/$source_relative"
  local logical_destination
  local destination

  validate_relative_path "$source_relative"
  validate_relative_path "$destination_relative"

  if [[ ! -e "$source" && ! -L "$source" ]]; then
    if [[ "$requirement" == "optional" ]]; then
      log_warn "optional $category source is absent: $source_relative"
      return
    fi
    die "required $category source is absent: $source_relative"
  fi

  case "$scope" in
    user)
      logical_destination="$TARGET_HOME/$destination_relative"
      ;;
    system)
      logical_destination="/$destination_relative"
      ;;
    *)
      die "unknown config scope '$scope' for $source_relative"
      ;;
  esac
  destination="$(physical_path "$logical_destination")"

  if (( DRY_RUN )); then
    log_info "would restore $category $source_relative -> $logical_destination"
    return
  fi

  if [[ "$scope" == "user" ]]; then
    copy_user_path "$source" "$destination"
  else
    copy_system_path "$source" "$destination"
  fi
  log_ok "restored $category $logical_destination"
}

stage_config() {
  CURRENT_STAGE="configuration"

  if (( SKIP_CONFIG )); then
    log_info "configuration stage skipped"
    return
  fi

  if [[ "$TARGET_ROOT" != "/" && "$DRY_RUN" -eq 0 ]]; then
    mkdir -p "$TARGET_ROOT"
  fi

  local scope category source destination requirement
  while IFS=$'\t' read -r scope category source destination requirement; do
    [[ -n "$scope" ]] || continue
    copy_mapped_path "$scope" "$category" "$source" "$destination" "$requirement"
  done <"$PROFILE_DIR/config-map.tsv"

  local name
  local -a local_bins=()
  read_manifest "$PROFILE_DIR/local-bin.txt" local_bins
  for name in "${local_bins[@]}"; do
    validate_relative_path "$name"
    copy_mapped_path user SCRIPT "home/.local/bin/$name" ".local/bin/$name" required
  done

  if (( ! DRY_RUN )) && [[ "$TARGET_ROOT" == "/" ]] && command -v update-desktop-database >/dev/null 2>&1; then
    run_as_target_user update-desktop-database "$TARGET_HOME/.local/share/applications"
    log_ok "updated the user desktop-entry cache"
  fi

  if (( ! DRY_RUN )); then
    CONFIG_INSTALL_PERFORMED=1
  fi
}
