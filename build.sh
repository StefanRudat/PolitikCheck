#!/usr/bin/env bash
set -Eeuo pipefail

SOURCE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$SOURCE_DIR/build/PolitikCheck.app"
CONTENTS="$APP_DIR/Contents"
MODULE_CACHE="$SOURCE_DIR/.module-cache"

rm -rf "$APP_DIR"
mkdir -p "$CONTENTS/MacOS" "$MODULE_CACHE"
CLANG_MODULE_CACHE_PATH="$MODULE_CACHE/clang" swiftc -parse-as-library -swift-version 5 \
  -module-cache-path "$MODULE_CACHE/swift" -framework SwiftUI -framework AppKit \
  "$SOURCE_DIR/PolitikCheck.swift" -o "$CONTENTS/MacOS/PolitikCheck"
cp "$SOURCE_DIR/Info.plist" "$CONTENTS/Info.plist"
codesign --force --sign - "$APP_DIR"
printf 'Erstellt: %s\n' "$APP_DIR"
