#!/usr/bin/env bash
# Build the vendored GoPro GPR SDK and its gpr_tools binary.
# Run this once after cloning (and after `git submodule update --init`).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
GPR_DIR="$PKG_ROOT/Sources/Cgpr_tools/gpr"
BUILD_DIR="$GPR_DIR/build"

if [[ ! -d "$GPR_DIR" ]]; then
    echo "error: gpr submodule missing at $GPR_DIR"
    echo "       run: git submodule update --init --recursive"
    exit 1
fi

echo "Configuring gpr in $BUILD_DIR ..."
cmake -S "$GPR_DIR" -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE=Release

echo "Building gpr_tools ..."
cmake --build "$BUILD_DIR" --config Release -j"$(nproc)" --target gpr_tools

BIN="$BUILD_DIR/source/app/gpr_tools/gpr_tools"
if [[ -x "$BIN" ]]; then
    echo "Built: $BIN"
else
    echo "error: gpr_tools binary not found at $BIN" >&2
    exit 1
fi
