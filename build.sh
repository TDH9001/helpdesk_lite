#!/bin/bash
set -e

echo "=== Installing Flutter SDK ==="
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter
else
  cd flutter
  git pull
  cd ..
fi

export PATH="$PATH:$(pwd)/flutter/bin"

echo "=== Flutter Environment ==="
flutter doctor -v
flutter config --enable-web

echo "=== Getting Dependencies ==="
flutter pub get

echo "=== Generating Localizations ==="
flutter gen-l10n || true

echo "=== Building Flutter Web Release ==="
flutter build web --release --no-wasm-dry-run

echo "=== Build Complete ==="
