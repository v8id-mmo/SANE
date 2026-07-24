# A sprite that changes role over time

The [raster-split multiplexer](sprite-multiplex.md) reuses hardware
sprites by repositioning them mid-frame. This is a different axis of the
same idea: one hardware sprite plays several different *roles* over
time, driven by game state rather than by raster position. Here, sprite
0 is an idle crosshair that follows the joystick; pressing fire launches
it upward as a "bullet"; reaching the top of the screen switches it to
an "explosion" shape for a few frames, then it returns to being an idle
crosshair again, all using the same single hardware sprite throughout.

## What this uses

- [`SetSpriteLoc`](../reference/builtins/setspriteloc.md) - repoints the
  sprite at a different shape when its state changes.
- [`Joystick`](../reference/builtins/joystick.md) - drives the idle
  state and fires the launch.
- [`SpritePos`](../reference/builtins/spritepos.md) /
  `sprite_color` - moved and recolored every state transition.

```pascal
program SpriteStateMachine;

// One hardware sprite, three roles: while idle it's a crosshair that
// follows the joystick; pressing fire launches it upward as a "bullet";
// reaching the top of the screen switches it to an "explosion" shape for
// a few frames, then it returns to being an idle crosshair again. This
// is a different kind of sprite reuse than a raster-split multiplexer:
// here the same hardware sprite index changes ROLE over time, driven by
// game state, rather than being repositioned mid-frame.

var
	const STATE_IDLE      : byte = 0;
	const STATE_FLYING    : byte = 1;
	const STATE_EXPLODING : byte = 2;

	// Placeholder shapes, deliberately simple: a thin "+" for the
	// crosshair/bullet, a solid block for the explosion. Both are placed
	// at fixed, 64-byte-aligned addresses, since SetSpriteLoc needs that
	// (its dataLoc argument is the address divided by 64).
	crosshairShape : array[63] of byte = (
		$18,$18,$00, $18,$18,$00, $18,$18,$00, $18,$18,$00,
		$18,$18,$00, $18,$18,$00, $18,$18,$00, $18,$18,$00,
		$18,$18,$00, $ff,$ff,$00, $ff,$ff,$00, $ff,$ff,$00,
		$18,$18,$00, $18,$18,$00, $18,$18,$00, $18,$18,$00,
		$18,$18,$00, $18,$18,$00, $18,$18,$00, $18,$18,$00,
		$18,$18,$00
	) at $3000;

	explosionShape : array[63] of byte = (
		$ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff,
		$ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff,
		$ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff,
		$ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff,
		$ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff, $ff,$ff,$ff,
		$ff,$ff,$ff
	) at $3040;

	state : byte = STATE_IDLE;
	x : integer = 160;
	y : byte = 150;
	explodeTimer : byte = 0;

begin
	clearscreen(key_space,screen_char_loc);

	SetSpriteLoc(0, $c0, vic_bank0); // $3000 / 64
	sprite_color[0] := white;
	togglebit(sprite_bitmask,0,1);

	repeat
		joystick(1);

		if (state = STATE_IDLE) then begin
			if (joystickleft=1)  then x := x - 2;
			if (joystickright=1) then x := x + 2;
			if (joystickup=1)    then y := y - 2;
			if (joystickdown=1)  then y := y + 2;
			if (joystickbutton=1) then begin
				state := STATE_FLYING;
				sprite_color[0] := yellow;
			end;
		end;

		if (state = STATE_FLYING) then begin
			y := y - 4;
			if (y <= 50) then begin
				state := STATE_EXPLODING;
				explodeTimer := 15;
				SetSpriteLoc(0, $c1, vic_bank0); // $3040 / 64
				sprite_color[0] := light_red;
			end;
		end;

		if (state = STATE_EXPLODING) then begin
			explodeTimer := explodeTimer - 1;
			if (explodeTimer = 0) then begin
				state := STATE_IDLE;
				SetSpriteLoc(0, $c0, vic_bank0); // back to the crosshair shape
				sprite_color[0] := white;
				y := 150;
			end;
		end;

		SpritePos(x,y,0);
		wait(2);
	until false;
end.
```

[:material-download: Download this example](../assets/examples/cookbook/sprite-state-machine.ras){ .md-button download }

## How it works

`state` is the whole machine: three plain `if` blocks, one per state,
each only doing anything when `state` currently matches it. In
`STATE_IDLE`, the sprite just tracks the joystick; pressing fire flips
`state` to `STATE_FLYING` and changes the color, but doesn't touch the
shape, since the bullet reuses the crosshair's own sprite data.
`STATE_FLYING` moves the sprite straight up every frame; once it
crosses the top boundary, `SetSpriteLoc` repoints sprite 0 at the
explosion shape (a different 64-byte-aligned block, `$3040` instead of
`$3000`), the color changes again, and a short `explodeTimer` starts
counting down. Once that timer hits zero, everything resets: shape,
color, and vertical position all go back to their idle values, and
`state` returns to `STATE_IDLE`. The sprite's hardware index (`0`) never
changes throughout; only what it points at (`SetSpriteLoc`), what color
it is, and where it's positioned change, which is the whole trick to
getting more visual variety out of a fixed set of 8 hardware sprites
without needing a raster split at all.
