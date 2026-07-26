#!/usr/bin/env bash
#
# Bug 2.68: a missing/unreadable settings file (no settings= argument, and
# no fallback trse.ini at the OS per-user AppData location either) makes
# ClascExec::Perform() (trc.cpp) print "Could not load TRSE settings!..."
# and return false - which, since Perform() returns int, becomes a literal
# 0, indistinguishable from a real successful compile to anything reading
# just the process exit code. See KNOWN_BUGS.md 2.68 / CLAUDE.md section
# 2.68.
#
# Method D (CLI/project-template) - see REGRESSION_SUITE_GUIDE.md. Not
# runnable through run_regressions.sh (no compile-and-VICE shape to
# reuse); run this script directly.
#
# This is the one bug in the whole suite where the currently-buggy state
# is "exit code 0" and the fixed state is "exit code nonzero" - the
# opposite of every other snippet, same "inverted expectation" shape as
# 2.25/2.40/2.59 (Method A/B), just for an exit code instead of a
# COMPILE_ERROR/COMPILE_OK label.
#
# PASS (fixed)  : compiler exits nonzero when settings can't be loaded.
# FAIL (buggy, expected pre-fix): compiler exits 0 despite not compiling.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

TRSE="$SCRIPT_DIR/../../build/trse"
PROJECT="$SCRIPT_DIR/project.trse"
RASFILE="2_68_missing_settings_exit_code.ras"

if [[ ! -x "$TRSE" ]]; then
	echo "ERROR: compiler binary not found/executable at $TRSE (build it first: ./compile.sh)" >&2
	exit 2
fi

# Isolate HOME/XDG_DATA_HOME to a fresh, empty directory so the
# QStandardPaths::AppDataLocation fallback (~/.local/share/TRSE/trse.ini)
# is guaranteed not to exist, regardless of whether this machine has ever
# actually run the (removed) GUI. Hermetic: doesn't depend on this
# developer's real home directory state.
fake_home="$(mktemp -d)"
trap 'rm -rf "$fake_home"' EXIT

rm -f "$SCRIPT_DIR/2_68_missing_settings_exit_code.prg" \
      "$SCRIPT_DIR/2_68_missing_settings_exit_code.asm" \
      "$SCRIPT_DIR/2_68_missing_settings_exit_code.sym"

log="$(mktemp)"
HOME="$fake_home" XDG_DATA_HOME="$fake_home" \
	"$TRSE" -cli op=project project="$PROJECT" input_file="$RASFILE" >"$log" 2>&1
rc=$?

echo "=== 2_68_missing_settings_exit_code ==="
echo "  compiler exit code: $rc"
tail -3 "$log" | sed 's/^/    /'
rm -f "$log"
rm -f "$SCRIPT_DIR/2_68_missing_settings_exit_code.prg" \
      "$SCRIPT_DIR/2_68_missing_settings_exit_code.asm" \
      "$SCRIPT_DIR/2_68_missing_settings_exit_code.sym"

if [[ "$rc" -eq 0 ]]; then
	echo "  FAIL (bug reproduced: exit code 0 despite settings failing to load)"
	exit 1
else
	echo "  PASS (fixed: exit code $rc, nonzero, on missing settings)"
	exit 0
fi
