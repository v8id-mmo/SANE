# Showing a live counter or score

A common beginner question: how do you display a number on screen that
changes while the program runs. This counts up ten times, redrawing the
number after each step.

## What this uses

- [`for`](../reference/keywords/for.md) - the counted loop driving each
  step.
- [`MoveTo`](../reference/builtins/moveto.md) - re-positions the cursor
  before every redraw.
- [`PrintDecimal`](../reference/builtins/printdecimal.md) - prints the
  running total as a fixed-width decimal number.
- [`Wait`](../reference/builtins/wait.md) - a short delay so each step
  is actually visible.

```pascal
program ScoreCounter;
var
	// integer, not byte, since we want room to count past 255.
	score : integer = 0;
	i : byte;

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring("score:",0,40);

	// Count up ten times, adding 10 each pass and redrawing the number
	// straight after, so you can watch the on-screen value change.
	for i:=0 to 9 do
	begin
		score := score + 10;

		// Re-position the cursor before every redraw: PrintDecimal doesn't
		// remember where it printed last time.
		moveto(7,0,hi(screen_char_loc));
		printdecimal(score,3); // 4 digits, e.g. "0100"

		wait(80); // slow it down enough to actually see each step tick by
	end;

	loop();
end.
```

[:material-download: Download this example](../assets/examples/cookbook/score-counter.ras){ .md-button download }

## How it works

`PrintDecimal` always prints at the current cursor position and doesn't
track where it printed last time, so the cursor is moved back to the
same spot with `MoveTo` before every redraw; otherwise each new number
would print one line further down. `score` is declared as an `integer`
rather than a `byte` since a running total like this can easily exceed
255, the limit of a single byte. The `wait(80)` call at the end of each
pass exists purely so a human watching the screen can actually see each
step happen; without it the whole loop finishes in a small fraction of
a second.
