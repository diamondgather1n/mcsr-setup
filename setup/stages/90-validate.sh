#!/usr/bin/env bash
set -Eeuo pipefail

VALIDATION_FAILURES=0

validation_fail() {
  printf '[FAIL] %s\n' "$*" >&2
  VALIDATION_FAILURES=$((VALIDATION_FAILURES + 1))
}

validation_ok() {
  log_ok "$*"
}

validate_package_manifests() {
  local -a files=(
    "$SETUP_DIR/packages/pacman.txt"
    "$SETUP_DIR/packages/aur.txt"
    "$SETUP_DIR/packages/optional-pacman.txt"
    "$SETUP_DIR/packages/optional-aur.txt"
    "$SETUP_DIR/packages/legacy-pacman.txt"
  )
  local file package
  local -a packages=()
  local -A seen=()

  for file in "${files[@]}"; do
    validate_manifest "$file"
    read_manifest "$file" packages
    for package in "${packages[@]}"; do
      if [[ -n "${seen[$package]+present}" ]]; then
        validation_fail "package $package appears in both ${seen[$package]} and ${file##*/}"
      else
        seen["$package"]="${file##*/}"
      fi
    done
  done

  local unavailable=0
  for file in \
    "$SETUP_DIR/packages/pacman.txt" \
    "$SETUP_DIR/packages/optional-pacman.txt" \
    "$SETUP_DIR/packages/legacy-pacman.txt"
  do
    read_manifest "$file" packages
    for package in "${packages[@]}"; do
      if ! pacman -Si "$package" >/dev/null 2>&1; then
        validation_fail "official package is absent from current sync databases: $package"
        unavailable=$((unavailable + 1))
      fi
    done
  done

  (( unavailable == 0 )) && validation_ok "all official manifest names resolve"
  validation_ok "all AUR manifest names have valid package syntax"
  return 0
}

validate_profile_sources() {
  local scope category source destination requirement
  local source_path

  while IFS=$'\t' read -r scope category source destination requirement; do
    [[ -n "$scope" ]] || continue
    if [[ "$scope" != "user" && "$scope" != "system" ]]; then
      validation_fail "invalid config scope $scope in config-map.tsv"
      continue
    fi
    if [[ "$requirement" != "required" && "$requirement" != "optional" ]]; then
      validation_fail "invalid requirement $requirement for $source"
      continue
    fi
    if [[ -z "$category" || -z "$source" || -z "$destination" ]]; then
      validation_fail "incomplete config-map.tsv row for $source"
      continue
    fi
    source_path="$REPO_ROOT/$source"
    if [[ ! -e "$source_path" && ! -L "$source_path" ]]; then
      if [[ "$requirement" == "required" ]]; then
        validation_fail "required repository source is missing: $source"
      else
        log_warn "optional repository source is missing: $source"
      fi
    fi
  done <"$PROFILE_DIR/config-map.tsv"

  local name
  local source
  local -a local_bins=()
  read_manifest "$PROFILE_DIR/local-bin.txt" local_bins
  for name in "${local_bins[@]}"; do
    source="$REPO_ROOT/home/.local/bin/$name"
    if [[ ! -f "$source" ]]; then
      validation_fail "profile script is missing: home/.local/bin/$name"
    elif [[ ! -x "$source" ]]; then
      validation_fail "profile script is not executable: home/.local/bin/$name"
    fi
  done

  if (( VALIDATION_FAILURES == 0 )); then
    validation_ok "profile mappings and executable script sources are present"
  fi
  return 0
}

validate_shell_syntax() {
  local -a scripts=()
  local -a local_bins=()
  local script name first_line
  local failed=0

  mapfile -d '' scripts < <(find "$SETUP_DIR" -type f -name '*.sh' -print0 | sort -z)
  read_manifest "$PROFILE_DIR/local-bin.txt" local_bins
  for name in "${local_bins[@]}"; do
    script="$REPO_ROOT/home/.local/bin/$name"
    [[ -f "$script" ]] || continue
    first_line="$(head -n 1 "$script" || true)"
    if [[ "$first_line" =~ ^'#!'.*(bash|/sh) ]]; then
      scripts+=("$script")
    fi
  done

  for script in "${scripts[@]}"; do
    if ! bash -n "$script"; then
      validation_fail "shell syntax failed: ${script#"$REPO_ROOT/"}"
      failed=$((failed + 1))
    fi
  done
  (( failed == 0 )) && validation_ok "shell syntax passed for ${#scripts[@]} scripts"
  return 0
}

validate_structured_configs() {
  local output
  local failed=0

  if command -v python >/dev/null 2>&1; then
    if python - \
      "$REPO_ROOT/home/.config/jay/config.toml" \
      "$REPO_ROOT/home/.config/yazi/yazi.toml" \
      "$REPO_ROOT/home/.config/yazi/keymap.toml" \
      "$REPO_ROOT/home/.config/micro/settings.json" \
      "$REPO_ROOT/home/.config/micro/bindings.json" <<'PY'
import json
import pathlib
import sys
import tomllib

for name in sys.argv[1:4]:
    with pathlib.Path(name).open("rb") as handle:
        tomllib.load(handle)
for name in sys.argv[4:]:
    with pathlib.Path(name).open(encoding="utf-8") as handle:
        json.load(handle)
PY
    then
      validation_ok "Jay and Yazi TOML plus Micro JSON parse"
    else
      validation_fail "TOML or JSON parsing failed"
      failed=$((failed + 1))
    fi
  else
    log_warn "python is unavailable; TOML and JSON parsing skipped"
  fi

  if command -v luajit >/dev/null 2>&1; then
    if luajit -b "$REPO_ROOT/home/.config/waywall/init.lua" /dev/null; then
      validation_ok "Waywall Lua compiles"
    else
      validation_fail "Waywall Lua compilation failed"
      failed=$((failed + 1))
    fi
  else
    log_warn "luajit is unavailable; Waywall Lua compilation skipped"
  fi

  if command -v zellij >/dev/null 2>&1; then
    if output="$(ZELLIJ_CONFIG_DIR="$REPO_ROOT/home/.config/zellij" zellij setup --check 2>&1)" \
      && grep -q 'CONFIG FILE.*Well defined' <<<"$output"
    then
      validation_ok "Zellij configuration is well defined"
    else
      validation_fail "Zellij configuration check failed"
      failed=$((failed + 1))
    fi
  else
    log_warn "zellij is unavailable; semantic Zellij check skipped"
  fi

  if command -v yazi >/dev/null 2>&1; then
    if YAZI_CONFIG_HOME="$REPO_ROOT/home/.config/yazi" yazi --debug >/dev/null 2>&1; then
      validation_ok "Yazi accepts the tracked configuration"
    else
      validation_fail "Yazi configuration check failed"
      failed=$((failed + 1))
    fi
  else
    log_warn "yazi is unavailable; semantic Yazi check skipped"
  fi

  if command -v keyd >/dev/null 2>&1; then
    if keyd check \
      "$REPO_ROOT/system/etc/keyd/normal.conf" \
      "$REPO_ROOT/system/etc/keyd/speedrun.conf" >/dev/null 2>&1
    then
      validation_ok "keyd configurations pass keyd check"
    else
      validation_fail "keyd configuration check failed"
      failed=$((failed + 1))
    fi
  else
    log_warn "keyd is unavailable; semantic keyd check skipped"
  fi

  if command -v desktop-file-validate >/dev/null 2>&1; then
    local desktop
    while IFS= read -r -d '' desktop; do
      if ! desktop-file-validate "$desktop" >/dev/null 2>&1; then
        validation_fail "desktop entry validation failed: ${desktop#"$REPO_ROOT/"}"
        failed=$((failed + 1))
      fi
    done < <(find "$REPO_ROOT/home/.local/share/applications" -maxdepth 1 -type f -name '*.desktop' -print0)
    (( failed == 0 )) && validation_ok "tracked desktop entries validate"
  else
    log_warn "desktop-file-validate is unavailable; desktop checks skipped"
  fi

  if command -v dex >/dev/null 2>&1; then
    output="$(dex -d "$REPO_ROOT/home/.local/share/applications/foot.desktop" 2>&1 || true)"
    if [[ "$output" == *'/home/nathan/.local/bin/foot-tabbed'* ]]; then
      validation_ok "Foot desktop override resolves to foot-tabbed"
    else
      validation_fail "Foot desktop override does not resolve to foot-tabbed"
    fi
  else
    log_warn "dex is unavailable; Foot desktop execution check skipped"
  fi

  local xkb_link="$REPO_ROOT/home/.config/xkb/symbols/mcsr"
  if [[ -L "$xkb_link" ]] \
    && [[ "$(readlink "$xkb_link")" == "$TARGET_HOME/MCSR/wayland/xkb/symbols/mcsr" ]]
  then
    validation_ok "tracked MCSR XKB symlink target is correct"
  else
    validation_fail "tracked MCSR XKB symlink target is incorrect"
  fi
  return 0
}

compare_copied_path() {
  local source="$1"
  local destination="$2"
  local label="$3"
  local -a entries=()
  local entry relative target

  if [[ ! -e "$destination" && ! -L "$destination" ]]; then
    validation_fail "restored destination is missing: $label"
    return
  fi

  if [[ -d "$source" && ! -L "$source" ]]; then
    [[ -d "$destination" ]] || {
      validation_fail "restored destination is not a directory: $label"
      return
    }
    mapfile -d '' entries < <(find "$source" -mindepth 1 -print0)
    for entry in "${entries[@]}"; do
      relative="${entry#"$source/"}"
      target="$destination/$relative"
      if [[ -L "$entry" ]]; then
        if [[ ! -L "$target" || "$(readlink "$entry")" != "$(readlink "$target" 2>/dev/null || true)" ]]; then
          validation_fail "restored symlink differs: $label/$relative"
        fi
      elif [[ -d "$entry" ]]; then
        [[ -d "$target" ]] || validation_fail "restored directory is missing: $label/$relative"
      elif [[ ! -f "$target" ]] || ! cmp -s "$entry" "$target"; then
        validation_fail "restored file differs: $label/$relative"
      fi
    done
  elif [[ -L "$source" ]]; then
    if [[ ! -L "$destination" || "$(readlink "$source")" != "$(readlink "$destination" 2>/dev/null || true)" ]]; then
      validation_fail "restored symlink differs: $label"
    fi
  elif [[ ! -f "$destination" ]] || ! cmp -s "$source" "$destination"; then
    validation_fail "restored file differs: $label"
  fi
}

validate_restored_config() {
  if (( ! CONFIG_INSTALL_PERFORMED )); then
    return 0
  fi

  local scope category source destination requirement
  local logical_destination physical_destination
  while IFS=$'\t' read -r scope category source destination requirement; do
    [[ -n "$scope" ]] || continue
    [[ -e "$REPO_ROOT/$source" || -L "$REPO_ROOT/$source" ]] || continue
    if [[ "$scope" == "user" ]]; then
      logical_destination="$TARGET_HOME/$destination"
    else
      logical_destination="/$destination"
    fi
    physical_destination="$(physical_path "$logical_destination")"
    compare_copied_path "$REPO_ROOT/$source" "$physical_destination" "$logical_destination"
  done <"$PROFILE_DIR/config-map.tsv"

  local name
  local -a local_bins=()
  read_manifest "$PROFILE_DIR/local-bin.txt" local_bins
  for name in "${local_bins[@]}"; do
    physical_destination="$(physical_path "$TARGET_HOME/.local/bin/$name")"
    compare_copied_path \
      "$REPO_ROOT/home/.local/bin/$name" \
      "$physical_destination" \
      "$TARGET_HOME/.local/bin/$name"
    [[ -x "$physical_destination" ]] \
      || validation_fail "restored script is not executable: $TARGET_HOME/.local/bin/$name"
  done

  validation_ok "restored configuration content was compared with repository sources"
  return 0
}

validate_installed_packages() {
  if (( ! PACKAGE_INSTALL_PERFORMED )); then
    return 0
  fi

  local -a official_packages=()
  local -a aur_packages=()
  local package
  collect_selected_packages official_packages aur_packages

  for package in "${official_packages[@]}" "${aur_packages[@]}"; do
    if pacman -Q "$package" >/dev/null 2>&1; then
      validation_ok "package installed: $package"
    else
      validation_fail "package not installed after package stage: $package"
    fi
  done

  local command package_name
  while IFS=$'\t' read -r command package_name; do
    [[ -n "$command" ]] || continue
    if command -v "$command" >/dev/null 2>&1; then
      validation_ok "executable exists: $command"
    else
      validation_fail "executable $command is missing (package $package_name)"
    fi
  done <"$PROFILE_DIR/required-commands.tsv"
  return 0
}

stage_validate() {
  CURRENT_STAGE="validation"
  VALIDATION_FAILURES=0

  validate_package_manifests
  validate_profile_sources
  validate_shell_syntax
  validate_structured_configs
  validate_restored_config
  validate_installed_packages

  if (( VALIDATION_FAILURES > 0 )); then
    die "validation completed with $VALIDATION_FAILURES failure(s)"
  fi
  validation_ok "v0.1 validation passed"
}
