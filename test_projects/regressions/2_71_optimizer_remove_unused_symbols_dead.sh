#!/usr/bin/env bash
#
# Bug 2.71: the settings-file (trse.ini) key optimizer_remove_unused_symbols
# has no reads anywhere in the surviving source tree - it's dead. The real
# switch is a similarly-named but separate PROJECT-file key,
# remove_unused_symbols, read at compiler.cpp and passed into
# Parser::Parse(...). See KNOWN_BUGS.md and CLAUDE.md section 2.71.
#
# Method D (CLI/project-template) - see REGRESSION_SUITE_GUIDE.md. Not
# runnable through run_regressions.sh; run this script directly.
#
# Two checks:
# 1. Toggling optimizer_remove_unused_symbols between 0 and 1 in the
#    settings file (project file left at its default, remove_unused_symbols
#    unset) - the dead-symbol procedure/var this snippet declares (never
#    called from begin/end) should keep surviving either way today (bug
#    reproduced: byte-identical .asm), and should start differing once
#    the settings key is wired up (or, per KNOWN_BUGS.md's other fix
#    direction, is removed from the shipped trse.ini entirely - see the
#    note below).
# 2. Positive control: the real switch, remove_unused_symbols=1 in the
#    PROJECT file (2_71_optimizer_remove_unused_symbols_dead_remove1.trse),
#    actually strips the same dead symbols today - confirming this check
#    technique is capable of detecting a real difference, not just
#    "nothing ever changes regardless of what's toggled". This should
#    keep passing regardless of what happens to bug 2.71 itself.
#
# PASS (fixed)  : check 1 shows a real difference, check 2 still holds.
# FAIL (buggy, expected pre-fix): check 1 shows no difference.
#
# Note: if the eventual fix is instead to just remove the dead settings
# key from the shipped trse.ini (KNOWN_BUGS.md's other suggested fix
# direction), check 1 has nothing left to toggle and this script should
# be retired/rewritten rather than trusted as-is - re-verify against
# KNOWN_BUGS.md 2.71 first.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

TRSE="$SCRIPT_DIR/../../build/trse"
BASE_SETTINGS="$SCRIPT_DIR/../../Publish/publish_linux/trse.ini"
PROJECT="$SCRIPT_DIR/project.trse"
STEM="2_71_optimizer_remove_unused_symbols_dead"
RASFILE="$STEM.ras"
CONTROL_PROJECT="$SCRIPT_DIR/${STEM}_remove1.trse"

if [[ ! -x "$TRSE" ]]; then
	echo "ERROR: compiler binary not found/executable at $TRSE (build it first: ./compile.sh)" >&2
	exit 2
fi
if ! grep -q '^optimizer_remove_unused_symbols' "$BASE_SETTINGS"; then
	echo "ERROR: '$BASE_SETTINGS' no longer contains 'optimizer_remove_unused_symbols' - re-verify this bug against the live repo" >&2
	exit 2
fi

settings_off="$(mktemp)"
settings_on="$(mktemp)"
asm_off="$(mktemp)"
asm_on="$(mktemp)"
log="$(mktemp)"
sed 's/^optimizer_remove_unused_symbols.*/optimizer_remove_unused_symbols = 0/' "$BASE_SETTINGS" >"$settings_off"
sed 's/^optimizer_remove_unused_symbols.*/optimizer_remove_unused_symbols = 1/' "$BASE_SETTINGS" >"$settings_on"

cleanup() {
	rm -f "$SCRIPT_DIR/$STEM.prg" "$SCRIPT_DIR/$STEM.asm" "$SCRIPT_DIR/$STEM.sym" \
	      "$settings_off" "$settings_on" "$asm_off" "$asm_on" "$log"
}
trap cleanup EXIT

echo "=== $STEM ==="

# --- Check 1: settings-key toggle, project key left at default ---
rm -f "$SCRIPT_DIR/$STEM.prg" "$SCRIPT_DIR/$STEM.asm" "$SCRIPT_DIR/$STEM.sym"
"$TRSE" -cli op=project project="$PROJECT" input_file="$RASFILE" settings="$settings_off" >"$log" 2>&1
rc=$?
if [[ $rc -ne 0 ]] || [[ ! -f "$SCRIPT_DIR/$STEM.asm" ]]; then
	echo "  ERROR: compile failed with optimizer_remove_unused_symbols=0"
	tail -5 "$log" | sed 's/^/    /'
	exit 2
fi
cp "$SCRIPT_DIR/$STEM.asm" "$asm_off"

rm -f "$SCRIPT_DIR/$STEM.prg" "$SCRIPT_DIR/$STEM.asm" "$SCRIPT_DIR/$STEM.sym"
"$TRSE" -cli op=project project="$PROJECT" input_file="$RASFILE" settings="$settings_on" >"$log" 2>&1
rc=$?
if [[ $rc -ne 0 ]] || [[ ! -f "$SCRIPT_DIR/$STEM.asm" ]]; then
	echo "  ERROR: compile failed with optimizer_remove_unused_symbols=1"
	tail -5 "$log" | sed 's/^/    /'
	exit 2
fi
cp "$SCRIPT_DIR/$STEM.asm" "$asm_on"

toggle_has_effect=1
if diff -q "$asm_off" "$asm_on" >/dev/null 2>&1; then
	toggle_has_effect=0
	echo "  check 1 (settings key toggle): .asm identical regardless of optimizer_remove_unused_symbols"
else
	echo "  check 1 (settings key toggle): .asm differs when optimizer_remove_unused_symbols is toggled"
fi

# --- Check 2: positive control, the real project-file key ---
rm -f "$SCRIPT_DIR/$STEM.prg" "$SCRIPT_DIR/$STEM.asm" "$SCRIPT_DIR/$STEM.sym"
"$TRSE" -cli op=project project="$CONTROL_PROJECT" input_file="$RASFILE" settings="$BASE_SETTINGS" >"$log" 2>&1
rc=$?
if [[ $rc -ne 0 ]] || [[ ! -f "$SCRIPT_DIR/$STEM.asm" ]]; then
	echo "  ERROR: compile failed with remove_unused_symbols=1 (project key)"
	tail -5 "$log" | sed 's/^/    /'
	exit 2
fi
occurrences=$(grep -c "unused_var_xyz\|UnusedProcXyz" "$SCRIPT_DIR/$STEM.asm")
control_works=0
if [[ "$occurrences" -eq 0 ]]; then
	control_works=1
	echo "  check 2 (project-key positive control): remove_unused_symbols=1 stripped the dead symbols, as expected"
else
	echo "  check 2 (project-key positive control): ERROR - dead symbols survived even with remove_unused_symbols=1 ($occurrences occurrence(s)); check technique itself may be stale"
fi

if [[ $control_works -eq 0 ]]; then
	echo "  ERROR (see check 2 above)"
	exit 2
fi

if [[ $toggle_has_effect -eq 0 ]]; then
	echo "  FAIL (bug reproduced: settings key optimizer_remove_unused_symbols has no effect)"
	exit 1
else
	echo "  PASS (fixed: optimizer_remove_unused_symbols now has an effect)"
	exit 0
fi
