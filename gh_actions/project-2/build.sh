#!/usr/bin/env bash
# Build a versioned release tarball into dist/.
set -euo pipefail
VERSION="$(cat VERSION)"
mkdir -p dist
tar -czf "dist/app-${VERSION}.tar.gz" pixelpost VERSION
echo "built dist/app-${VERSION}.tar.gz"
