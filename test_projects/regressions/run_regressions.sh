#!/usr/bin/env bash
#
# run_regressions.sh - compile + run every bug regression snippet in this
# folder, report PASS/FAIL/COMPILE_ERROR per bug.
#
# See REGRESSION_SUITE_GUIDE.md
# (/home/dey/.claude/projects/-home-dey-SANE/) for the full design this
# implements: four verification methods (A/B/C/D), folder layout, per-bug
# batch list. This script implements Method A (compile + headless VICE
# run, pass/fail flag at $8000) plus a bare compile-error fallback for any
# Method A bug that currently fails to compile at all (an expected,
# documented state for some bugs pre-fix, e.g. 2.1), and Method B (compile-
# time-only verification, no VICE step: a snippet is Method B whenever its
# .ras file has no `addbreakpoint` call - see batch 5, 2.8/2.9/2.12/2.18/
# 2.20/2.23/2.25/2.44/2.72). Method C snippets whose bug is itself a
# compile-time failure (2.10, 2.11, 2.27) fall under the same Method B
# fallback; Method C snippets whose bug is a wrong-but-successfully-built
# asset file (2.13, 2.16, 2.21) use the new .outputcheck mechanism below
# (batch 11). Method D snippets (2.68-2.71, batch 12) aren't runnable
# through this script at all (no compile-and-VICE shape to reuse) - each
# is its own standalone, self-contained 2_NN_*.sh script; run all of them
# via ./run_method_d.sh instead. This script's default sweep skips any
# 2_NN_*.ras that has a same-named .sh next to it, since that .ras is just
# fixture data for the Method D script, not a snippet to compile-check on
# its own.
#
# Two batch-8 additions:
# - Per-snippet project file override: if <stem>.trse exists next to a
#   snippet, it's used instead of the shared project.trse (2.62 needs a
#   project file missing its zeropage_internal1-4 keys; the shared project
#   file has to stay intact for every other snippet).
# - <stem>.asmcheck: a static check on the generated .asm for bugs whose
#   symptom isn't a runtime value or a compile error at all (2.50's SID
#   control register is write-only, unreadable at runtime; 2.65's bug is a
#   harmless-at-runtime code-doubling issue). One line, `MODE:pattern`:
#     ADJACENT2:<pattern>  - FAIL if <pattern> appears on exactly 2 lines
#                            exactly 2 apart (i.e. truly back-to-back with
#                            only one other line between), PASS otherwise.
#     ABSENT:<pattern>     - FAIL if <pattern> appears anywhere, PASS if
#                            entirely absent.
#     PRESENT:<pattern>    - FAIL if <pattern> is absent, PASS if it
#                            appears anywhere (batch 9, added for 2.45:
#                            the inverse of ABSENT, for a bug whose fix
#                            direction is "emit a `cli` that currently
#                            never gets emitted" rather than "stop
#                            emitting something that shouldn't be there").
#   A snippet with an .asmcheck file has no `addbreakpoint` call either
#   (no VICE step), but is reported via this check instead of the plain
#   Method B "COMPILE_OK" fallback.
#
# Batch-11 addition:
# - <stem>.outputcheck: for asset/export-pipeline bugs (Method C) where the
#   compile itself succeeds but a generated *asset* file (not the .asm) is
#   what's wrong - empty when it shouldn't be, unchanged when it should
#   have been rewritten, or an unclamped byte range. One or more lines,
#   each its own assertion, `MODE:args`; a snippet FAILs overall if any
#   line fails (same aggregation idea as multiple Common::PASS()/FAIL()
#   calls in one Method A snippet). Checked right after a successful
#   compile, same slot as .asmcheck/.diffcheck/.stdoutcheck; a snippet
#   using this has no `addbreakpoint` call either (no VICE step). Three
#   modes:
#     NONEMPTY:<path>            - PASS if <path> exists and is >0 bytes,
#                                   FAIL if missing or empty (2.13:
#                                   @exportblackwhite/@exportframe silently
#                                   write a zero-byte file for every
#                                   C64-reachable asset type).
#     DIFFERS:<path>:<goldenpath> - PASS if the two files' contents differ,
#                                   FAIL if byte-identical or either is
#                                   missing (2.16: @importchar's actual
#                                   copy step is an unimplemented no-op
#                                   stub, so its destination asset comes
#                                   back byte-for-byte unchanged). <path>
#                                   is refreshed from <goldenpath> (a
#                                   plain `cp`) immediately before every
#                                   compile, since the directive under
#                                   test rewrites <path> in place - without
#                                   this refresh, a run after the bug is
#                                   actually fixed would compare an
#                                   already-modified file against itself on
#                                   every subsequent run.
#     RAREBYTE:<path>:<hex>:<n>   - counts occurrences of byte <hex> (e.g.
#                                   "ff") anywhere in <path>; FAIL if
#                                   count<=<n>, PASS if count><n> (2.21:
#                                   @perlinnoise casts its raw float value
#                                   to a byte *before* clamping it to
#                                   [0,255], unlike the .png preview it
#                                   saves alongside, which is clamped -
#                                   with a large enough amplitude, a
#                                   properly clamped output should read
#                                   back as the same saturated byte almost
#                                   everywhere, while the actual unclamped
#                                   output wraps unpredictably and almost
#                                   never lands on that byte by chance).
#
# Two batch-9 additions:
# - <stem>.diffcheck: for bugs where a flag/keyword is threaded all the way
#   through but silently never changes the generated code (2.15's
#   @ignoresystemheaders, 2.19's case onpage/offpage, 2.28's wedge vs
#   interrupt) - a runtime value assertion can't distinguish these since
#   the working code path is identical either way. One line: the stem of a
#   baseline .ras next to it (same internal `program` name, so only the
#   documented difference separates them). The baseline is compiled
#   separately and its .asm diffed against the snippet's own, with
#   whole-line comments stripped from both first (same TRSE-echoes-
#   source-comments pitfall the .asmcheck filter above already handles -
#   two files' own differently-worded header comments would otherwise
#   always show up as a "difference" even when the real generated code is
#   identical): FAIL if identical (today's bug - no distinguishable
#   effect), PASS if different. A snippet using this has no `addbreakpoint` call (no VICE
#   step); its baseline twin (named `<something>_baseline.ras`) is excluded
#   from the default no-argument sweep so it doesn't show up as its own,
#   redundant summary row (it can still be run explicitly by name).
# - <stem>.stdoutcheck: for bugs where the compiler runs to a successful
#   exit but a message that should have been surfaced (a warning, a
#   deprecation notice) never gets printed anywhere (2.22). One line,
#   `PRESENT:<pattern>` - FAIL if <pattern> is absent from the full compile
#   log despite a successful compile, PASS if present. Checked only after
#   a successful compile, same as .asmcheck/.diffcheck; a snippet using
#   this has no `addbreakpoint` call either.
#
# Usage:
#   ./run_regressions.sh                # run every 2_NN_*.ras snippet here
#   ./run_regressions.sh 2_01 2_03       # run only the named snippet(s)
#
# Exit code: nonzero if any snippet's result is unexpected for a "gate"
# run (see --gate below); 0 otherwise. Without --gate, exit code is always
# 0 and this is purely a reporting tool (its main use before any bugs are
# fixed: confirming each snippet reproduces its documented symptom).

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

TRSE="$SCRIPT_DIR/../../build/trse"
SETTINGS="$SCRIPT_DIR/../../Publish/publish_linux/trse.ini"
PROJECT="$SCRIPT_DIR/project.trse"
X64SC="x64sc"
VICE_TIMEOUT=15

if [[ ! -x "$TRSE" ]]; then
	echo "ERROR: compiler binary not found/executable at $TRSE (build it first: ./compile.sh)" >&2
	exit 2
fi

names=()
if [[ $# -gt 0 ]]; then
	for arg in "$@"; do
		names+=("$arg")
	done
else
	for f in "$SCRIPT_DIR"/2_*.ras; do
		base="$(basename "$f" .ras)"
		# .diffcheck baseline twins aren't their own bug snippet (see the
		# batch-9 note above) - skip them in the default sweep, but they can
		# still be run explicitly by name.
		[[ "$base" == *_baseline ]] && continue
		# Method D (batch 12+, 2.68-2.71): the .ras alongside a same-named
		# .sh is just fixture data for that standalone script (run via
		# run_method_d.sh, not this one) - it compiles fine on its own but
		# that's not the actual bug assertion, so skip it here too (it can
		# still be run explicitly by name, same as a _baseline twin).
		[[ -f "$SCRIPT_DIR/$base.sh" ]] && continue
		names+=("$base")
	done
fi

declare -a RESULTS

for name in "${names[@]}"; do
	# allow both "2_01" and "2_01_signed_int_compare" style args. A
	# *_baseline.ras twin (batch 9+, see the .diffcheck note above) is
	# excluded from the candidate list unless the given name already ends
	# in "_baseline" itself - otherwise a short numeric prefix like "2_15"
	# can match its own baseline twin first under some locales' `ls`
	# collation order (observed: "_baseline.ras" sorting before ".ras").
	if [[ "$name" == *_baseline ]]; then
		match="$(ls "$SCRIPT_DIR"/"${name}"*.ras 2>/dev/null | head -1)"
	else
		match="$(ls "$SCRIPT_DIR"/"${name}"*.ras 2>/dev/null | grep -v '_baseline\.ras$' | head -1)"
	fi
	if [[ -z "$match" ]]; then
		echo "SKIP: no snippet matching '$name'"
		RESULTS+=("$name|SKIP|no matching .ras file")
		continue
	fi
	rasfile="$(basename "$match")"
	stem="${rasfile%.ras}"

	echo "=== $stem ==="
	rm -f "$SCRIPT_DIR/$stem.prg" "$SCRIPT_DIR/$stem.asm" "$SCRIPT_DIR/$stem.sym"

	project="$PROJECT"
	if [[ -f "$SCRIPT_DIR/$stem.trse" ]]; then
		project="$SCRIPT_DIR/$stem.trse"
	fi

	# .outputcheck DIFFERS lines name a file the compile-under-test rewrites
	# in place; refresh it from its golden copy before compiling so a run
	# after the underlying bug is fixed doesn't compare an already-modified
	# file against itself (see the .outputcheck note above).
	outputcheck="$SCRIPT_DIR/$stem.outputcheck"
	if [[ -f "$outputcheck" ]]; then
		while IFS= read -r line; do
			[[ -z "$line" ]] && continue
			if [[ "$line" == DIFFERS:* ]]; then
				rest="${line#DIFFERS:}"
				path="${rest%%:*}"
				golden="${rest#*:}"
				if [[ -f "$SCRIPT_DIR/$golden" ]]; then
					cp "$SCRIPT_DIR/$golden" "$SCRIPT_DIR/$path"
				fi
			fi
		done < "$outputcheck"
	fi

	compile_log="$(mktemp)"
	"$TRSE" -cli op=project project="$project" input_file="$rasfile" settings="$SETTINGS" >"$compile_log" 2>&1
	compile_rc=$?

	if [[ $compile_rc -gt 128 ]]; then
		sig=$((compile_rc - 128))
		echo "  CRASH (compiler killed by signal $sig, exit $compile_rc)"
		tail -5 "$compile_log" | sed 's/^/    /'
		RESULTS+=("$stem|CRASH|signal $sig")
		rm -f "$compile_log"
		continue
	fi

	if [[ $compile_rc -ne 0 ]] || [[ ! -f "$SCRIPT_DIR/$stem.prg" ]]; then
		echo "  COMPILE_ERROR (exit $compile_rc)"
		tail -5 "$compile_log" | sed 's/^/    /'
		RESULTS+=("$stem|COMPILE_ERROR|exit $compile_rc")
		rm -f "$compile_log"
		continue
	fi
	# compile_log is kept alive past this point (not deleted yet) in case
	# .stdoutcheck below needs it; every branch after this cleans it up
	# itself before continuing/finishing.

	asmcheck="$SCRIPT_DIR/$stem.asmcheck"
	if [[ -f "$asmcheck" ]]; then
		spec="$(head -1 "$asmcheck")"
		mode="${spec%%:*}"
		pattern="${spec#*:}"
		asmfile="$SCRIPT_DIR/$stem.asm"
		# skip whole-line comments (TRSE echoes .ras source comments into
		# the .asm as "; // ..." lines, which can coincidentally contain
		# the same literal pattern as the real generated instruction)
		lines="$(grep -nF -- "$pattern" "$asmfile" | grep -v -- '^[0-9]*:[[:space:]]*;' | cut -d: -f1)"
		count=0
		[[ -n "$lines" ]] && count=$(wc -l <<< "$lines")

		case "$mode" in
		ADJACENT2)
			if [[ "$count" -eq 2 ]]; then
				l1=$(sed -n 1p <<< "$lines")
				l2=$(sed -n 2p <<< "$lines")
				gap=$((l2 - l1))
				if [[ "$gap" -eq 2 ]]; then
					echo "  FAIL (asmcheck: '$pattern' adjacent at .asm lines $l1/$l2)"
					RESULTS+=("$stem|FAIL|asmcheck adjacent lines $l1/$l2")
				else
					echo "  PASS (asmcheck: '$pattern' found twice but not adjacent, gap=$gap)"
					RESULTS+=("$stem|PASS|asmcheck gap=$gap")
				fi
			else
				echo "  PASS (asmcheck: '$pattern' occurs $count time(s), not the buggy pair)"
				RESULTS+=("$stem|PASS|asmcheck count=$count")
			fi
			;;
		ABSENT)
			if [[ "$count" -gt 0 ]]; then
				echo "  FAIL (asmcheck: '$pattern' present, $count occurrence(s))"
				RESULTS+=("$stem|FAIL|asmcheck present count=$count")
			else
				echo "  PASS (asmcheck: '$pattern' absent)"
				RESULTS+=("$stem|PASS|asmcheck absent")
			fi
			;;
		PRESENT)
			if [[ "$count" -gt 0 ]]; then
				echo "  PASS (asmcheck: '$pattern' present, $count occurrence(s))"
				RESULTS+=("$stem|PASS|asmcheck present count=$count")
			else
				echo "  FAIL (asmcheck: '$pattern' absent)"
				RESULTS+=("$stem|FAIL|asmcheck absent")
			fi
			;;
		*)
			echo "  ERROR: unknown asmcheck mode '$mode'"
			RESULTS+=("$stem|ERROR|unknown asmcheck mode $mode")
			;;
		esac
		rm -f "$compile_log"
		continue
	fi

	diffcheck="$SCRIPT_DIR/$stem.diffcheck"
	if [[ -f "$diffcheck" ]]; then
		rm -f "$compile_log"
		baseline_stem="$(head -1 "$diffcheck" | tr -d '[:space:]')"
		baseline_ras="$SCRIPT_DIR/$baseline_stem.ras"
		baseline_asm="$SCRIPT_DIR/$baseline_stem.asm"
		if [[ ! -f "$baseline_ras" ]]; then
			echo "  ERROR: diffcheck baseline '$baseline_stem.ras' not found"
			RESULTS+=("$stem|ERROR|missing diffcheck baseline")
			continue
		fi
		rm -f "$baseline_asm" "$SCRIPT_DIR/$baseline_stem.prg" "$SCRIPT_DIR/$baseline_stem.sym"
		baseline_project="$PROJECT"
		if [[ -f "$SCRIPT_DIR/$baseline_stem.trse" ]]; then
			baseline_project="$SCRIPT_DIR/$baseline_stem.trse"
		fi
		"$TRSE" -cli op=project project="$baseline_project" input_file="$baseline_stem.ras" settings="$SETTINGS" >/dev/null 2>&1
		if [[ ! -f "$baseline_asm" ]]; then
			echo "  ERROR: diffcheck baseline '$baseline_stem' failed to compile"
			RESULTS+=("$stem|ERROR|diffcheck baseline compile failed")
			continue
		fi
		# strip whole-line .asm comments before comparing: TRSE echoes each
		# file's own .ras source comments into the .asm as "; // ..." lines,
		# and a snippet's explanatory header comment is expected to differ
		# in wording from its baseline twin's even when the real generated
		# code is identical (confirmed happening here before this filter was
		# added - see REGRESSION_SUITE_PROGRESS.md's batch-9 note).
		if diff -q \
			<(grep -v '^[[:space:]]*;' "$SCRIPT_DIR/$stem.asm") \
			<(grep -v '^[[:space:]]*;' "$baseline_asm") \
			>/dev/null 2>&1; then
			echo "  FAIL (diffcheck: identical to baseline '$baseline_stem', no distinguishable codegen)"
			RESULTS+=("$stem|FAIL|diffcheck identical to $baseline_stem")
		else
			echo "  PASS (diffcheck: differs from baseline '$baseline_stem')"
			RESULTS+=("$stem|PASS|diffcheck differs from $baseline_stem")
		fi
		continue
	fi

	stdoutcheck="$SCRIPT_DIR/$stem.stdoutcheck"
	if [[ -f "$stdoutcheck" ]]; then
		spec="$(head -1 "$stdoutcheck")"
		mode="${spec%%:*}"
		pattern="${spec#*:}"
		case "$mode" in
		PRESENT)
			if grep -qF -- "$pattern" "$compile_log"; then
				echo "  PASS (stdoutcheck: '$pattern' present in compile log)"
				RESULTS+=("$stem|PASS|stdoutcheck present")
			else
				echo "  FAIL (stdoutcheck: '$pattern' absent from compile log despite a successful compile)"
				RESULTS+=("$stem|FAIL|stdoutcheck absent")
			fi
			;;
		*)
			echo "  ERROR: unknown stdoutcheck mode '$mode'"
			RESULTS+=("$stem|ERROR|unknown stdoutcheck mode $mode")
			;;
		esac
		rm -f "$compile_log"
		continue
	fi

	if [[ -f "$outputcheck" ]]; then
		rm -f "$compile_log"
		overall="PASS"
		notes=()
		while IFS= read -r line; do
			[[ -z "$line" ]] && continue
			mode="${line%%:*}"
			args="${line#*:}"
			case "$mode" in
			NONEMPTY)
				path="$SCRIPT_DIR/$args"
				if [[ -s "$path" ]]; then
					notes+=("NONEMPTY $args: ok, $(stat -c%s "$path") bytes")
				else
					overall="FAIL"
					notes+=("NONEMPTY $args: missing or empty")
				fi
				;;
			DIFFERS)
				path="${args%%:*}"
				golden="${args#*:}"
				p1="$SCRIPT_DIR/$path"
				p2="$SCRIPT_DIR/$golden"
				if [[ ! -f "$p1" ]] || [[ ! -f "$p2" ]]; then
					overall="FAIL"
					notes+=("DIFFERS $path/$golden: one or both missing")
				elif cmp -s "$p1" "$p2"; then
					overall="FAIL"
					notes+=("DIFFERS $path/$golden: identical")
				else
					notes+=("DIFFERS $path/$golden: differ, ok")
				fi
				;;
			RAREBYTE)
				path="$(cut -d: -f1 <<< "$args")"
				hexbyte="$(cut -d: -f2 <<< "$args")"
				threshold="$(cut -d: -f3 <<< "$args")"
				p1="$SCRIPT_DIR/$path"
				if [[ ! -f "$p1" ]]; then
					overall="FAIL"
					notes+=("RAREBYTE $path: missing")
				else
					count=$(xxd -p "$p1" | tr -d '\n' | grep -o "$hexbyte" | wc -l)
					if [[ "$count" -le "$threshold" ]]; then
						overall="FAIL"
						notes+=("RAREBYTE $path: 0x$hexbyte count=$count <= $threshold")
					else
						notes+=("RAREBYTE $path: 0x$hexbyte count=$count > $threshold, ok")
					fi
				fi
				;;
			*)
				overall="FAIL"
				notes+=("unknown outputcheck mode '$mode'")
				;;
			esac
		done < "$outputcheck"
		note_str="$(IFS='; '; echo "${notes[*]}")"
		echo "  $overall (outputcheck: $note_str)"
		RESULTS+=("$stem|$overall|outputcheck: $note_str")
		continue
	fi

	rm -f "$compile_log"

	if ! grep -q "addbreakpoint" "$rasfile"; then
		echo "  COMPILE_OK (Method B, no VICE step)"
		RESULTS+=("$stem|COMPILE_OK|Method B")
		continue
	fi

	symfile="$SCRIPT_DIR/$stem.sym"
	prgfile="$SCRIPT_DIR/$stem.prg"
	resultfile="$SCRIPT_DIR/results.bin"
	rm -f "$resultfile"

	sed -i "s|\$DIR|$SCRIPT_DIR|g" "$symfile"

	timeout "$VICE_TIMEOUT" "$X64SC" -sound -autostartprgmode 1 -moncommands "$symfile" "$prgfile" >/dev/null 2>&1

	if [[ ! -f "$resultfile" ]]; then
		echo "  ERROR: VICE did not produce results.bin (breakpoint never hit?)"
		RESULTS+=("$stem|ERROR|no results.bin")
		continue
	fi

	flag=$(od -An -tu1 -j2 -N1 "$resultfile" | tr -d ' ')
	if [[ "$flag" == "0" ]]; then
		echo "  PASS"
		RESULTS+=("$stem|PASS|")
	else
		echo "  FAIL"
		RESULTS+=("$stem|FAIL|flag=$flag")
	fi
done

echo
echo "=== Summary ==="
printf '%-40s %-15s %s\n' "SNIPPET" "RESULT" "NOTE"
for r in "${RESULTS[@]}"; do
	IFS='|' read -r n res note <<< "$r"
	printf '%-40s %-15s %s\n' "$n" "$res" "$note"
done
