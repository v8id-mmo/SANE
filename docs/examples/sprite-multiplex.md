# A simple sprite multiplexer

The VIC-II only has 8 hardware sprites, but a raster interrupt can move a
sprite to a new position mid-frame, after the beam has already drawn past
its old one. Chaining a couple of raster interrupts down the screen lets
the same handful of hardware sprites stand in for more objects than
actually exist, a technique real games use to put far more than 8 moving
things on screen at once. This recipe multiplexes just 2 hardware sprites
across 4 falling objects, using one raster split halfway down the screen.

## What this uses

- [`interrupt`](../reference/keywords/interrupt.md) - declares each
  raster handler.
- [`StartRasterChain`](../reference/builtins/startrasterchain.md) /
  [`RasterIRQ`](../reference/builtins/rasterirq.md) - arm the first
  handler, then each handler re-arms the next one.
- [`SpritePos`](../reference/builtins/spritepos.md) - repositions a
  sprite; called twice per handler, once per raindrop it's currently
  standing in for.
- [`DisableCIAInterrupts`](../reference/builtins/disableciainterrupts.md) -
  standard first step before installing a raster interrupt chain.

```pascal
program SpriteMultiplex;

// A minimal sprite multiplexer: four falling raindrops share just two
// hardware sprites. A raster interrupt splits the screen in half.
// Sprites 0/1 show the top two raindrops while the beam draws the upper
// half, then get repositioned to the bottom two raindrops' spots the
// instant the beam crosses into the lower half, and back again for the
// next frame's top half. Since each move happens only after the beam has
// already drawn past that sprite's old position, two hardware sprites
// end up drawing four independent raindrops.

var
	dropX : array[4] of integer = (60,140,220,280);
	dropY : array[4] of byte    = (60,90,60,90);
	i : byte;

interrupt TopHalf();
interrupt BottomHalf();

interrupt TopHalf();
begin
	startirq(0);
	SpritePos(dropX[0],dropY[0],0);
	SpritePos(dropX[1],dropY[1],1);
	RasterIRQ(BottomHalf(),140,0); // hand off once the beam reaches mid-screen
	closeirq();
end;

interrupt BottomHalf();
begin
	startirq(0);
	SpritePos(dropX[2],dropY[2],0);
	SpritePos(dropX[3],dropY[3],1);
	RasterIRQ(TopHalf(),50,0); // hand back for the next frame's top half
	closeirq();
end;

begin
	clearscreen(key_space,screen_char_loc);

	sprite_color[0] := white;
	sprite_color[1] := light_blue;
	togglebit(sprite_bitmask,0,1);
	togglebit(sprite_bitmask,1,1);

	disableciainterrupts();
	StartRasterChain(TopHalf(),50,0);

	repeat
		for i:=0 to 3 do begin
			dropY[i] := dropY[i]+1;
			if (dropY[i] > 229) then dropY[i] := 50;
		end;
		wait(1);
	until false;
end.
```

[:material-download: Download this example](../assets/examples/cookbook/sprite-multiplex.ras){ .md-button download }

## How it works

`TopHalf` fires near the top of the screen and points sprites 0 and 1 at
`dropX[0]`/`dropY[0]` and `dropX[1]`/`dropY[1]`, the first two raindrops.
It then arms `BottomHalf` to fire at raster line 140, roughly the screen's
midpoint. By the time `BottomHalf` runs, the VIC-II has already drawn
sprites 0 and 1 at their top-half positions into the upper half of the
frame, so moving them now doesn't disturb what's already on screen; it
repoints them at `dropX[2]`/`dropY[2]` and `dropX[3]`/`dropY[3]`, the
bottom two raindrops, for the rest of the frame. `BottomHalf` then arms
`TopHalf` back at line 50 for the next frame, closing the loop. The main
program's `repeat` loop only ever updates the shared `dropY` array (each
raindrop falls, then wraps back to the top once it passes the bottom of
the screen); it never calls `SpritePos` itself; that's left entirely to
the two handlers, which read the same array from inside the interrupt.
The same idea scales to many more raindrops than four and many more
raster splits than two; the tradeoff is that each split costs raster
time and has to happen while the beam is somewhere both sprites' old and
new positions won't visibly tear, which is why the split line here sits
between the two rows of raindrops rather than through the middle of
either one.

## Known limitations

Because this splits the screen with `RasterIRQ`, it inherits that
builtin's own known limitations: no validation that the procedure passed
to `RasterIRQ`/`StartRasterChain` is actually an `interrupt` procedure
(passing anything else crashes the compiler itself rather than failing
to compile normally), and a raster line at or past 256 isn't reachable
through this chain, only `0`-`255`, which is not a problem for this
particular example since both split lines used here are well under that.
