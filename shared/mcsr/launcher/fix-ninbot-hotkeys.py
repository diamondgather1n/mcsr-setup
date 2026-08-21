#!/usr/bin/env python3
from pathlib import Path
import re
import shutil


PREFS = Path.home() / ".java/.userPrefs/ninjabrainbot/prefs.xml"
BACKUP = PREFS.with_name("prefs.xml.bak-codex-hotkeys")

HOTKEYS = {
    "hotkey_increment_code": "65642",    # F23
    "hotkey_increment_modifier": "0",
    "hotkey_decrement_code": "65643",    # F24
    "hotkey_decrement_modifier": "0",
    "hotkey_lock_code": "65572",         # J, passed through natively by Waywall
    "hotkey_lock_modifier": "0",
    "hotkey_undo_code": "122957",        # Right
    "hotkey_undo_modifier": "0",
    "hotkey_redo_code": "122960",        # Down
    "hotkey_redo_modifier": "0",
    "hotkey_reset_code": "122955",       # Left
    "hotkey_reset_modifier": "0",
    "hotkey_minimize_code": "122952",    # Up
    "hotkey_minimize_modifier": "0",
}


def set_entry(text, key, value):
    pattern = re.compile(r'(<entry key="' + re.escape(key) + r'" value=")[^"]*("/>)')
    replacement = r"\g<1>" + value + r"\2"
    updated, count = pattern.subn(replacement, text)
    if count:
        return updated

    entry = f'  <entry key="{key}" value="{value}"/>\n'
    return text.replace("</map>", entry + "</map>")


def main():
    if not PREFS.exists():
        return

    if not BACKUP.exists():
        shutil.copy2(PREFS, BACKUP)

    text = PREFS.read_text()
    updated = text
    for key, value in HOTKEYS.items():
        updated = set_entry(updated, key, value)

    if updated != text:
        PREFS.write_text(updated)


if __name__ == "__main__":
    main()
