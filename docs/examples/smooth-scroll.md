# Smooth horizontal scrolling, both directions

A pixel-smooth scroller needs two moving parts working together: the
VIC-II's hardware fine-scroll register handles the sub-character pixel
motion every single frame, and once that fine-scroll counter wraps, the
actual screen content shifts over by one full character (the "coarse"
step). This recipe scrolls a line of text left or right with the
joystick, treating both directions as equally important, mirror images
of each other rather than one being the "real" implementation and the
other a shortened afterthought (which is the most common way this
mechanism ends up flickering, stalling, or only working going one way).

## What this uses

- [`ScrollX`](../reference/builtins/scrollx.md) - the VIC-II's horizontal
  fine-scroll register, `0`-`7`.
- [`Joystick`](../reference/builtins/joystick.md) - drives the scroll
  direction.
- [`PrintString`](../reference/builtins/printstring.md) - redraws the
  visible slice of the message on each coarse step.

```pascal
program SmoothScroll;

// A minimal, symmetric left/right smooth scroller: ScrollX (the VIC-II
// fine-scroll register) handles the sub-character pixel motion every
// single frame, and once the fine-scroll counter wraps, the visible
// substring of the message is redrawn one character further along
// (the "coarse" step). Both directions are handled the same way here,
// deliberately mirrored: a scroller where only one direction gets this
// full treatment and the other is a shortened afterthought is exactly
// how this mechanism ends up flickering or stalling going one way.

var
	message : string = "THIS TEXT SCROLLS SMOOTHLY, BOTH LEFT AND RIGHT, FOREVER.     ";
	messageEnd : byte = 62; // length of the string above; where the loop point is
	textOffset : byte = 0;
	fineScroll : byte = 0;

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,12,hi(screen_char_loc));
	printstring(message,0,40);

	repeat
		joystick(1);

		if (joystickleft=1) then begin
			if (fineScroll=0) then begin
				// coarse step: reveal the next character on the right edge
				fineScroll := 7;
				textOffset += 1;
				if (textOffset > messageEnd-40) then textOffset := 0;
				moveto(0,12,hi(screen_char_loc));
				printstring(message,textOffset,40);
			end else fineScroll -= 1;
			scrollx(fineScroll & 7);
		end;

		if (joystickright=1) then begin
			if (fineScroll=7) then begin
				// coarse step: reveal the next character on the left edge
				fineScroll := 0;
				if (textOffset=0) then textOffset := messageEnd-40
				else textOffset -= 1;
				moveto(0,12,hi(screen_char_loc));
				printstring(message,textOffset,40);
			end else fineScroll += 1;
			scrollx(fineScroll & 7);
		end;

		wait(1);
	until false;
end.
```

[:material-download: Download this example](../assets/examples/cookbook/smooth-scroll.ras){ .md-button download }

## How it works

Scrolling left, `fineScroll` counts down from `7` to `0`, one step per
frame, which is what actually produces the pixel-by-pixel motion via
`ScrollX`; the moment it's already at `0` (nowhere left to count down to
smoothly), that same frame does the coarse step instead: reset
`fineScroll` back to `7` and redraw the message one character further
along, revealing new text on the right edge. Scrolling right is the
exact mirror: `fineScroll` counts *up* from `0` to `7`, and hitting `7`
triggers the coarse step the other way, resetting to `0` and revealing
new text on the left edge. `textOffset` walks through the message
string, wrapping back to `0` once it would run past the end (this is a
simple loop-to-start wrap, not a seamless circular buffer, so there's a
visible jump at the wrap point rather than an infinite scroll, a
deliberate simplification). `scrollx(fineScroll & 7)` masks the value
before every call even though `fineScroll` can only ever hold `0`-`7`
by construction here: `ScrollX` doesn't range-check or mask its own
input (see that page's Known limitations), so any code path that could
ever pass it something outside `0`-`7` will silently corrupt unrelated
bits of the VIC-II's control register, and masking defensively costs
nothing.

The most common way this exact mechanism goes wrong in practice: writing
the full "coarse step + reset + redraw" logic for one direction, then
reusing only *part* of it for the other (skipping the wraparound check,
forgetting to call `scrollx` again on that path, or comparing the
fine-scroll counter against the wrong boundary for that direction).
Every asymmetry between the two `if` blocks above is a place that class
of bug hides; keeping both directions structurally identical, just with
the comparisons and `+`/`-` flipped, is what makes this reliable rather
than "usually reliable in one direction."
