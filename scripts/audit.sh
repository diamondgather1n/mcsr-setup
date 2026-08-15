#!/usr/bin/env bash
set -Eeuo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
status=0

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  status=1
}

ok() {
  printf 'OK: %s\n' "$*"
}

check_pair() {
  local live="$1"
  local repo="$2"
  [[ -e "$live" ]] || fail "missing live path: $live"
  [[ -e "$repo_root/$repo" ]] || fail "missing repo path: $repo"
}

check_pair /home/nathan/.config/jay/config.toml home/.config/jay/config.toml
check_pair /home/nathan/.config/waywall/init.lua home/.config/waywall/init.lua
check_pair /home/nathan/.config/waybar/config home/.config/waybar/config
check_pair /home/nathan/.config/i3/config home/.config/i3/config
check_pair /home/nathan/.config/i3blocks/config home/.config/i3blocks/config
check_pair /home/nathan/.config/yazi/yazi.toml home/.config/yazi/yazi.toml
check_pair /home/nathan/.config/mimeapps.list home/.config/mimeapps.list
check_pair /etc/keyd/normal.conf system/etc/keyd/normal.conf
check_pair /etc/keyd/speedrun.conf system/etc/keyd/speedrun.conf

if [[ -L /home/nathan/.config/xkb/symbols/mcsr ]]; then
  target="$(readlink /home/nathan/.config/xkb/symbols/mcsr)"
  [[ "$target" == "/home/nathan/MCSR/wayland/xkb/symbols/mcsr" ]] \
    || fail "unexpected XKB symlink target: $target"
else
  fail "expected ~/.config/xkb/symbols/mcsr to be a symlink"
fi

if git -C "$repo_root" ls-files | grep -E '(^|/)(__pycache__|\.cache|tmp|MCSR/temp)(/|$)|(\.bak|\.backup|\.old|\.tmp|\.swp|\.swo|~|\.log|\.pyc|\.jar)$|codex-before|codex-backup' >/tmp/nathan-mcsr-audit-temp-files; then
  fail "tracked temporary/backup/generated files found:"
  sed 's/^/  /' /tmp/nathan-mcsr-audit-temp-files >&2
else
  ok "no tracked temporary/backup/generated files"
fi

while IFS= read -r script; do
  if [[ -f "$repo_root/$script" ]]; then
    first_line="$(head -n 1 "$repo_root/$script" || true)"
    if [[ "$script" == *.sh || "$first_line" =~ ^'#!'.*(bash|sh) ]]; then
      bash -n "$repo_root/$script" || fail "bash syntax failed: $script"
    fi
  fi
done < <(git -C "$repo_root" ls-files '*.sh' 'home/.local/bin/*' | sort -u)
ok "shell syntax check completed"

python3 - "$repo_root" <<'PY' || status=1
import pathlib
import re
import subprocess
import sys

repo = pathlib.Path(sys.argv[1])
files = subprocess.check_output(["git", "-C", str(repo), "ls-files"], text=True).splitlines()
keyword = re.compile(r"(password|passwd|token|secret|oauth|api_key|apikey|stream_key|bearer|authorization|webhook|cookie|session|private_key)", re.I)
assignment = re.compile(r"(?i)(password|passwd|token|secret|oauth|api_key|apikey|stream_key|bearer|authorization|webhook|cookie|session|private_key)[A-Za-z0-9_-]*\s*[:=]\s*['\"]([^'\"]+)['\"]")
userinfo_url = re.compile(r"[a-z][a-z0-9+.-]*://[^/\s:@]+:[^/\s@]+@")
webhook_url = re.compile(r"https://(?:canary\.|ptb\.)?discord(?:app)?\.com/api/webhooks/[^\s'\"]+", re.I)
private_key = "BEGIN " + "OPENSSH PRIVATE KEY"
secretish = re.compile(r"^[A-Za-z0-9_+=/@.-]{16,}$")

findings = []
for rel in files:
    path = repo / rel
    if not path.is_file():
        continue
    try:
        text = path.read_text(errors="ignore")
    except OSError:
        continue
    for lineno, line in enumerate(text.splitlines(), 1):
        reason = None
        if private_key in line:
            reason = "private key marker"
        elif userinfo_url.search(line):
            reason = "URL with embedded credentials"
        elif webhook_url.search(line):
            reason = "webhook URL"
        else:
            match = assignment.search(line)
            if match:
                value = match.group(2)
                if "$" not in value and "/" not in value and value not in {"", "none", "None", "false", "true"} and secretish.match(value):
                    reason = "secret-like literal assignment"
        if reason:
            redacted = keyword.sub(lambda m: m.group(1) + "[REDACTED]", line)
            redacted = userinfo_url.sub("URL_WITH_CREDENTIALS[REDACTED]", redacted)
            redacted = webhook_url.sub("WEBHOOK_URL[REDACTED]", redacted)
            findings.append((rel, lineno, reason, redacted.strip()))

if findings:
    print("Secret scan found high-risk entries:", file=sys.stderr)
    for rel, lineno, reason, redacted in findings:
        print(f"possible secret in {rel}:{lineno}: {reason}: {redacted}", file=sys.stderr)
    sys.exit(1)

print("OK: high-risk secret scan found no matches")
PY

exit "$status"
