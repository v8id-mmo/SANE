#!/usr/bin/env bash
#
# run_method_d.sh - run every Method D (CLI/project-template) regression
# script in this folder and report PASS/FAIL/ERROR per bug, same summary-
# table idea as run_regressions.sh uses for Methods A/B/C.
#
# Method D bugs (2.68-2.71, batch 12) aren't compile-and-VICE snippets at
# all - each one is its own standalone, self-contained shell script
# (2_NN_*.sh) that sets up its own tiny fixture, invokes the compiler
# directly, and asserts an exit code / produced-file / .asm-content
# outcome. See REGRESSION_SUITE_GUIDE.md's Method D section and
# REGRESSION_SUITE_PROGRESS.md's batch-12 note.
#
# Usage:
#   ./run_method_d.sh            # run every 2_NN_*.sh script here
#   ./run_method_d.sh 2_68 2_70  # run only the named script(s), by prefix

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

names=()
if [[ $# -gt 0 ]]; then
	for arg in "$@"; do
		names+=("$arg")
	done
else
	for f in "$SCRIPT_DIR"/2_*.sh; do
		base="$(basename "$f" .sh)"
		names+=("$base")
	done
fi

declare -a RESULTS

for name in "${names[@]}"; do
	match="$(ls "$SCRIPT_DIR"/"${name}"*.sh 2>/dev/null | grep -v '/run_method_d\.sh$' | head -1)"
	if [[ -z "$match" ]]; then
		echo "SKIP: no Method D script matching '$name'"
		RESULTS+=("$name|SKIP|no matching .sh file")
		continue
	fi
	script="$(basename "$match")"
	stem="${script%.sh}"

	"$match"
	rc=$?
	echo
	case $rc in
	0) RESULTS+=("$stem|PASS|") ;;
	1) RESULTS+=("$stem|FAIL|bug reproduced") ;;
	*) RESULTS+=("$stem|ERROR|exit $rc") ;;
	esac
done

echo "=== Summary ==="
printf '%-45s %-10s %s\n' "SNIPPET" "RESULT" "NOTE"
for r in "${RESULTS[@]}"; do
	IFS='|' read -r n res note <<< "$r"
	printf '%-45s %-10s %s\n' "$n" "$res" "$note"
done
