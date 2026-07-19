#!/usr/bin/env bash
#
# compile.sh - build the TRSE compiler/CLI binary out-of-source into ./build
#
# Usage:
#   ./compile.sh              # release build (default), incremental
#   ./compile.sh --clean      # wipe ./build first, then build
#   ./compile.sh --debug      # debug build instead of release
#   ./compile.sh -j4          # override parallel job count (default: nproc)
#
# On success, the binary is at ./build/trse and can be used as a pure CLI
# compiler, e.g.:
#   ./build/trse -cli op=project project=myproj.trse input_file=main.ras \
#       settings=Publish/publish_linux/trse.ini
#
# ---------------------------------------------------------------------------
# DEPENDENCIES (fresh Debian/Ubuntu/Mint system)
# ---------------------------------------------------------------------------
# This fork still builds from TRSE.pro (the full GUI project), not
# TRSECLI.pro: TRSECLI.pro's SOURCES list references maincli.cpp, which does
# not exist anywhere in this snapshot of the repo (see CLAUDE.md, section 1,
# "goal and scope"). Until that's written, TRSE.pro is the only .pro that
# actually links. The resulting `trse` binary still supports plain CLI usage
# via `trse -cli ...` (see main.cpp, the argv[1]=="-cli" branch) - it just
# also pulls in Qt Widgets/GUI at link time, which is why Qt widgets/gui
# packages are still required below even though this is only ever run
# headless from VSCode.
#
# Install build tools + Qt5 (dev packages) + OpenGL headers:
#
#   sudo apt-get update
#   sudo apt-get install -y \
#       build-essential \
#       qtbase5-dev qtbase5-dev-tools qt5-qmake \
#       qtdeclarative5-dev qtdeclarative5-dev-tools \
#       libqt5opengl5-dev \
#       mesa-common-dev libgl1-mesa-dev
#
# Notes:
#   - OpenMP (-fopenmp, DEFINES+=USE_OMP) needs no separate package on
#     Linux: it's provided by libgomp, which ships with g++/build-essential.
#     (libomp-dev is only needed for the macOS branch of the .pro file.)
#   - Lua is statically linked from the binary already checked into the
#     repo (libs/lua/liblua.a) via -L$$PWD/libs/lua -llua. No liblua*-dev
#     package needs to be installed.
#   - qmake must resolve to the Qt5 one. If another Qt version's qmake is
#     first on PATH, either install qt5-qmake so its alternatives entry
#     wins, or run `qtchooser -qt=5 -run-tool=qmake` / point QMAKE at the
#     qt5 binary explicitly.
#   - macOS/Windows: this script targets Linux only. See README.md for the
#     Xcode/MSVC + Qt6 installer instructions used on those platforms.
# ---------------------------------------------------------------------------

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

BUILD_DIR="$SCRIPT_DIR/build"
BUILD_CONFIG="release"
JOBS="$(nproc)"
CLEAN=0

for arg in "$@"; do
    case "$arg" in
        --clean) CLEAN=1 ;;
        --debug) BUILD_CONFIG="debug" ;;
        --release) BUILD_CONFIG="release" ;;
        -j*) JOBS="${arg#-j}" ;;
        -h|--help)
            sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'
            exit 0
            ;;
        *)
            echo "Unknown option: $arg" >&2
            exit 1
            ;;
    esac
done

command -v qmake >/dev/null 2>&1 || {
    echo "error: qmake not found. Install the Qt5 dev packages (see header of this script)." >&2
    exit 1
}
command -v g++ >/dev/null 2>&1 || {
    echo "error: g++ not found. Install build-essential (see header of this script)." >&2
    exit 1
}

if [[ "$CLEAN" -eq 1 && -d "$BUILD_DIR" ]]; then
    echo "Removing $BUILD_DIR"
    rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "Running qmake (CONFIG+=$BUILD_CONFIG)..."
qmake ../TRSE.pro -spec linux-g++ "CONFIG+=$BUILD_CONFIG"

echo "Building with $JOBS parallel jobs..."
make -j"$JOBS"

echo
echo "Build finished: $BUILD_DIR/trse"
