#!/usr/bin/env bash
set -e
VERSION="v1.0.0"
ARCHIVE="kag-ecommerce3-${VERSION}.zip"

echo "Install dependencies"
npm install

echo "Build project"
npm run build

echo "Prepare archive: ${ARCHIVE}"
rm -f "${ARCHIVE}"
zip -r "${ARCHIVE}" README.md LICENSE package.json docs src assets

echo "Archive created: ${ARCHIVE}"
