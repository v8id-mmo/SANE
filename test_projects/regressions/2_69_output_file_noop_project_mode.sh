#!/usr/bin/env bash
#
# Bug 2.69: output_file=<name> only renames the produced binary in
# op=orgasm mode. In the normal op=project compile mode,
# ClascExec::CompileFromProject (trc.cpp) has the equivalent rename call
# present in source but commented out, so the produced .prg silently
# keeps the source file's own base name instead, with no error or
# warning that the argument had no effect. See KNOWN_BUGS.md / CLAUDE.md
# section 2.69.
#
# Method D (CLI/project-template) - see REGRESSION_SUITE_GUIDE.md. Not
# runnable through run_regressions.sh; run this script directly.
#
# PASS (fixed)  : the custom output_file= name is what actually gets
#                 produced (and the source-named .prg is not left behind
#                 instead).
# FAIL (buggy, expected pre-fix): the source-named .prg is produced,
#                 the custom name never appears.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

TRSE="$SCRIPT_DIR/../../build/trse"
SETTINGS="$SCRIPT_DIR/../../Publish/publish_linux/trse.ini"
PROJECT="$SCRIPT_DIR/project.trse"
STEM="2_69_output_file_noop_project_mode"
RASFILE="$STEM.ras"
CUSTOM_NAME="${STEM}_custom_out.prg"

if [[ ! -x "$TRSE" ]]; then
	echo "ERROR: compiler binary not found/executable at $TRSE (build it first: ./compile.sh)" >&2
	exit 2
fi

cleanup() {
	rm -f "$SCRIPT_DIR/$STEM.prg" "$SCRIPT_DIR/$STEM.asm" "$SCRIPT_DIR/$STEM.sym" \
	      "$SCRIPT_DIR/$CUSTOM_NAME"
}
trap cleanup EXIT
cleanup

log="$(mktemp)"
"$TRSE" -cli op=project project="$PROJECT" input_file="$RASFILE" settings="$SETTINGS" \
	output_file="$CUSTOM_NAME" >"$log" 2>&1
rc=$?

echo "=== $STEM ==="
echo "  compiler exit code: $rc"

if [[ $rc -ne 0 ]]; then
	echo "  ERROR: compile itself failed, can't check output_file= behavior"
	tail -5 "$log" | sed 's/^/    /'
	rm -f "$log"
	exit 2
fi
rm -f "$log"

custom_exists=0
[[ -f "$SCRIPT_DIR/$CUSTOM_NAME" ]] && custom_exists=1
default_exists=0
[[ -f "$SCRIPT_DIR/$STEM.prg" ]] && default_exists=1

echo "  custom-named '$CUSTOM_NAME' produced: $custom_exists"
echo "  source-named '$STEM.prg' produced:   $default_exists"

if [[ $custom_exists -eq 1 ]]; then
	echo "  PASS (fixed: output_file= was honored in op=project mode)"
	exit 0
else
	echo "  FAIL (bug reproduced: output_file= ignored, source-named .prg produced instead)"
	exit 1
fi
