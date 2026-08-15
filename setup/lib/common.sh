#!/usr/bin/env bash
set -Eeuo pipefail

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$SETUP_DIR/.." && pwd)"
CURRENT_STAGE="initialization"

log_ok() {
  printf '[OK] %s\n' "$*"
}

log_info() {
  printf '[INFO] %s\n' "$*"
}

log_warn() {
  printf '[WARN] %s\n' "$*" >&2
}

die() {
  printf '[FAIL] %s\n' "$*" >&2
  exit 1
}

setup_error() {
  local exit_code="$1"
  local line="$2"
  local command="$3"
  trap - ERR
  printf '[FAIL] stage=%s line=%s exit=%s command=%q\n' \
    "$CURRENT_STAGE" "$line" "$exit_code" "$command" >&2
  exit "$exit_code"
}

trim_line() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "$value"
}

read_manifest() {
  local file="$1"
  local output_name="$2"
  local line
  local -n output="$output_name"

  [[ -f "$file" ]] || die "missing manifest: $file"
  output=()
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%%#*}"
    line="$(trim_line "$line")"
    [[ -n "$line" ]] || continue
    output+=("$line")
  done <"$file"
}

validate_manifest() {
  local file="$1"
  local package
  local -a packages=()
  local -A seen=()

  read_manifest "$file" packages
  for package in "${packages[@]}"; do
    [[ "$package" =~ ^[a-z0-9@._+:-]+$ ]] \
      || die "invalid package name '$package' in $file"
    [[ -z "${seen[$package]+present}" ]] \
      || die "duplicate package '$package' in $file"
    seen["$package"]=1
  done
}

run_as_root() {
  if (( EUID == 0 )); then
    "$@"
  else
    sudo "$@"
  fi
}

run_as_target_user() {
  local current_user
  current_user="$(id -un)"

  if [[ "$current_user" == "$TARGET_USER" ]]; then
    "$@"
    return
  fi

  (( EUID == 0 )) || die "cannot run as target user $TARGET_USER from $current_user"
  runuser -u "$TARGET_USER" -- env \
    HOME="$TARGET_HOME" \
    USER="$TARGET_USER" \
    LOGNAME="$TARGET_USER" \
    PATH="$TARGET_HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin" \
    "$@"
}

physical_path() {
  local logical_path="$1"
  [[ "$logical_path" == /* ]] || die "logical path is not absolute: $logical_path"

  if [[ "$TARGET_ROOT" == "/" ]]; then
    printf '%s' "$logical_path"
  else
    printf '%s%s' "${TARGET_ROOT%/}" "$logical_path"
  fi
}

validate_relative_path() {
  local path="$1"
  [[ -n "$path" && "$path" != /* && "$path" != *'..'* ]] \
    || die "unsafe relative path in profile: $path"
}
