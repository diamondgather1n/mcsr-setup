#!/usr/bin/env python3
import glob
import os
import struct
import sys
import time

LOG_PATH = "/tmp/waywall-dpi.log"


def log(message):
    with open(LOG_PATH, "a", encoding="utf-8") as handle:
        handle.write(f"{time.strftime('%Y-%m-%d %H:%M:%S')} {message}\n")


def main():
    if len(sys.argv) != 2:
        log(f"bad args: {sys.argv!r}")
        return 2

    try:
        dpi = int(sys.argv[1])
    except ValueError:
        log(f"bad dpi: {sys.argv[1]!r}")
        return 2

    paths = sorted(glob.glob("/sys/bus/hid/drivers/razermouse/*1532:0098*/dpi"))
    if not paths:
        paths = sorted(glob.glob("/sys/devices/**/*1532:0098*/dpi", recursive=True))

    if not paths:
        log(f"no dpi path found for dpi={dpi}")
        return 1

    data = struct.pack(">HH", dpi, dpi)
    for path in paths:
        try:
            with open(path, "wb") as handle:
                handle.write(data)
            with open(path, "r", encoding="utf-8") as handle:
                current = handle.read().strip()
            log(f"set dpi={dpi} path={path} readback={current}")
            return 0
        except OSError as exc:
            log(f"failed dpi={dpi} path={path} error={exc}")

    return 1


if __name__ == "__main__":
    raise SystemExit(main())
