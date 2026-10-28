#!/usr/bin/env bash
set -Eeuo pipefail

DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
rm -rf "$DATA_DIR/politikcheck"
rm -f "$DATA_DIR/applications/politikcheck.desktop"
if command -v update-desktop-database >/dev/null; then
  update-desktop-database "$DATA_DIR/applications" >/dev/null 2>&1 || true
fi
echo "PolitikCheck wurde entfernt. Eine Zuordnung des URL-Protokolls kann in mimeapps.list verbleiben."
