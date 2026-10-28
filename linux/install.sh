#!/usr/bin/env bash
set -Eeuo pipefail

SOURCE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
APP_DIR="$DATA_DIR/politikcheck"
APPLICATIONS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
DESKTOP_FILE="$APPLICATIONS_DIR/politikcheck.desktop"

command -v python3 >/dev/null || { echo "Python 3 fehlt. Installiere python3." >&2; exit 1; }
python3 -c 'import tkinter' 2>/dev/null || { echo "Tkinter fehlt. Unter Ubuntu/Debian: sudo apt install python3-tk" >&2; exit 1; }

mkdir -p "$APP_DIR" "$APPLICATIONS_DIR"
install -m 0644 "$SOURCE_DIR/politikcheck.py" "$APP_DIR/politikcheck.py"
cat > "$APP_DIR/politikcheck" <<EOF
#!/usr/bin/env bash
exec python3 "$APP_DIR/politikcheck.py" "\$@"
EOF
chmod 0755 "$APP_DIR/politikcheck"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=PolitikCheck
Comment=Lokaler politischer Faktencheck mit Ollama
Exec="$APP_DIR/politikcheck" %u
Terminal=false
Categories=Utility;
MimeType=x-scheme-handler/politikcheck;
EOF
chmod 0644 "$DESKTOP_FILE"
if command -v xdg-mime >/dev/null; then
  xdg-mime default politikcheck.desktop x-scheme-handler/politikcheck || true
fi
if command -v update-desktop-database >/dev/null; then
  update-desktop-database "$APPLICATIONS_DIR" >/dev/null 2>&1 || true
fi

echo "PolitikCheck installiert unter: $APP_DIR"
echo "Im App-Menü starten oder über den Startaufruf öffnen: $APP_DIR/politikcheck"
echo "Das URL-Protokoll politikcheck:// wurde registriert, sofern xdg-mime verfügbar ist."
echo "Hinweis: Linux-Version noch nicht geprüft."
