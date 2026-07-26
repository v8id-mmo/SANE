#!/usr/bin/env bash
#
# Bug 2.70: every shipped C64 project template spells two of its own
# settings keys wrong: override_target_settings_ignore_sys/_ignore_prg
# instead of the keys compiler6502.cpp actually reads
# (override_target_settings_sys/_prg), and (in the general-purpose
# templates) exomize_toggle instead of the key systemmos6502.cpp/
# abstractsystem.cpp actually read (exomizer_toggle). See KNOWN_BUGS.md
# and CLAUDE.md section 2.70.
#
# Method D (CLI/project-template) - see REGRESSION_SUITE_GUIDE.md. Not
# runnable through run_regressions.sh; run this script directly.
#
# Two independent assertions, aggregated (same idea as multiple
# Common::PASS()/FAIL() calls in one Method A snippet):
#
# 1. Functional/compiled check (override_target_settings_ignore_sys):
#    2_70_template_misspelled_keys.trse reproduces the exact shape of the
#    shipped c64_general/c64_general2 templates - override_target_settings=1
#    and the wrong _ignore_sys/_ignore_prg keys set to 1, no correctly-
#    spelled _sys/_prg key at all. Compiling with it should, once fixed,
#    make Syntax::s.m_ignoreSys true and skip emitting the BASIC "SYS"
#    stub token; today it has no effect, so the token is always present.
# 2. Static content check (exomize_toggle): confirms the shipped
#    Publish/project_templates/c64_general(2)/project.trse files really
#    do carry the misspelled exomize_toggle key with no correctly-spelled
#    exomizer_toggle key anywhere in the same file (unlike
#    c64_advanced_game/c64_disk_demo/c64_crt, which carry both and so
#    aren't affected) - not compiled, since no exomizer binary is
#    configured/available on this machine to observe an actual crunch
#    attempt one way or the other (see REGRESSION_SUITE_PROGRESS.md's
#    batch-12 note).
#
# PASS (fixed)  : both assertions pass.
# FAIL (buggy, expected pre-fix): either assertion fails.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
REPO_ROOT="$SCRIPT_DIR/../.."

TRSE="$SCRIPT_DIR/../../build/trse"
SETTINGS="$SCRIPT_DIR/../../Publish/publish_linux/trse.ini"
STEM="2_70_template_misspelled_keys"
RASFILE="$STEM.ras"
PROJECT="$SCRIPT_DIR/$STEM.trse"

if [[ ! -x "$TRSE" ]]; then
	echo "ERROR: compiler binary not found/executable at $TRSE (build it first: ./compile.sh)" >&2
	exit 2
fi

cleanup() {
	rm -f "$SCRIPT_DIR/$STEM.prg" "$SCRIPT_DIR/$STEM.asm" "$SCRIPT_DIR/$STEM.sym"
}
trap cleanup EXIT
cleanup

echo "=== $STEM ==="

overall="PASS"

# --- Assertion 1: override_target_settings_ignore_sys functional check ---
log="$(mktemp)"
"$TRSE" -cli op=project project="$PROJECT" input_file="$RASFILE" settings="$SETTINGS" >"$log" 2>&1
rc=$?
if [[ $rc -ne 0 ]] || [[ ! -f "$SCRIPT_DIR/$STEM.asm" ]]; then
	echo "  ERROR: compile itself failed, can't check override_target_settings_ignore_sys"
	tail -5 "$log" | sed 's/^/    /'
	rm -f "$log"
	exit 2
fi
rm -f "$log"

# The BASIC SYS-line stub token ($9e = "SYS" PETSCII token byte) should be
# skipped when override_target_settings=1 and "ignore sys" is requested;
# check for its documented emission comment/byte in the generated .asm.
if grep -q '\$9e' "$SCRIPT_DIR/$STEM.asm"; then
	echo "  assertion 1 (override_target_settings_ignore_sys): FAIL - SYS token still emitted despite ignore_sys=1 (wrong key)"
	overall="FAIL"
else
	echo "  assertion 1 (override_target_settings_ignore_sys): PASS - SYS token skipped"
fi

# --- Assertion 2: exomize_toggle static content check ---
# Expected buggy (pre-fix) state: c64_general and c64_general2 carry only
# the misspelled exomize_toggle key, with no correctly-spelled
# exomizer_toggle anywhere in the same file. FAIL if that's still true for
# either template; PASS once every shipped template carries (at least)
# the correct key.
still_broken=()
for tmpl in c64_general c64_general2; do
	f="$REPO_ROOT/Publish/project_templates/$tmpl/project.trse"
	if [[ ! -f "$f" ]]; then
		echo "  ERROR: expected template not found: $f"
		overall="FAIL"
		continue
	fi
	if ! grep -q '^exomize_toggle' "$f"; then
		echo "  ERROR: $tmpl/project.trse no longer contains 'exomize_toggle' - re-verify this bug against the live repo"
		overall="FAIL"
		continue
	fi
	if ! grep -q '^exomizer_toggle' "$f"; then
		still_broken+=("$tmpl: only 'exomize_toggle' present, no 'exomizer_toggle'")
	fi
done

if [[ ${#still_broken[@]} -gt 0 ]]; then
	for m in "${still_broken[@]}"; do
		echo "  assertion 2 note: $m"
	done
	echo "  assertion 2 (exomize_toggle template spelling): FAIL - c64_general/c64_general2 have only the misspelled key, no exomizer_toggle"
	overall="FAIL"
else
	echo "  assertion 2 (exomize_toggle template spelling): PASS"
fi

echo "  $overall"
if [[ "$overall" == "PASS" ]]; then
	exit 0
else
	exit 1
fi
