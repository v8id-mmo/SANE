# The classic open-border effect

The VIC-II decides whether to draw the border or the display on a given
raster line by comparing against a control bit in `$D011` at two fixed
points every frame: around line 51 (top) and line 251 (bottom) on PAL.
Toggling that bit off right as the bottom border would normally start,
then back on right as the top border would normally start on the next
frame, tricks the VIC-II into never drawing the bottom (or top) border
at all for the lines in between. This is the simpler, vertical-only
version of the classic demo-scene "open border" effect; opening the
left/right borders too needs the same idea repeated with cycle-exact
timing on every single raster line, a much bigger undertaking.

## What this uses

- [`hidebordery`](../reference/builtins/hidebordery.md) - the actual
  register toggle.
- [`interrupt`](../reference/keywords/interrupt.md) /
  [`RasterIRQ`](../reference/builtins/rasterirq.md) - fires the toggle at
  the two exact raster lines where it has to happen.

```pascal
program OpenBorder;

// The VIC-II decides whether to draw the border or the display each
// raster line by comparing against $D011's RSEL bit at two fixed points
// every frame: around line 51 (top) and line 251 (bottom) on PAL.
// Toggling that bit off right as the bottom border would normally
// start, then back on right as the top border would normally start on
// the next frame, tricks the VIC-II into never drawing the bottom (or
// top) border at all for the lines in between: the classic "open
// border" demo effect.

interrupt OpenAtBottom();
interrupt CloseAtTop();

interrupt OpenAtBottom();
begin
	startirq(0);
	hidebordery(1); // stop the bottom border from starting
	RasterIRQ(CloseAtTop(),51,0);
	closeirq();
end;

interrupt CloseAtTop();
begin
	startirq(0);
	hidebordery(0); // restore the top border for the rest of this frame
	RasterIRQ(OpenAtBottom(),251,0);
	closeirq();
end;

begin
	clearscreen(key_space,screen_char_loc);
	screen_bg_col := blue;

	disableciainterrupts();
	StartRasterChain(OpenAtBottom(),251,0);

	loop();
end.
```

[:material-download: Download this example](../assets/examples/cookbook/open-border.ras){ .md-button download }

## How it works

`OpenAtBottom` fires at line 251, exactly where the VIC-II would
otherwise switch from display to border for the rest of the frame;
calling `hidebordery(1)` there clears the row-select bit at precisely
the moment that transition would happen, so it never does, and the
display area keeps going all the way down through the bottom of the
frame. It then arms `CloseAtTop`, at line 51, the point where the
*next* frame's top border would normally end and the display would
normally begin; calling `hidebordery(0)` there sets the bit back,
restoring completely normal border behavior for the rest of that frame,
before re-arming `OpenAtBottom` at line 251 again to repeat the whole
cycle. The net effect is a screen with no bottom or top border, redrawn
fresh every frame by this same two-step handoff. Getting either raster
line even a few lines off either does nothing (the toggle lands inside
the border, not at the transition) or corrupts the display for a few
lines around the transition, which is why this technique is normally
demonstrated on its own, without other raster-split work sharing the
same handlers.
