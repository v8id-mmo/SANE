# Moving a sprite with the joystick

A classic first building block for any game: read the joystick every
frame and move a sprite around in response.

## What this uses

- [`sprite_color`/`sprite_bitmask`](../reference/constants.md#sprite-registers) -
  gives sprite 0 a color and switches it on.
- [`ToggleBit`](../reference/builtins/togglebit.md) - sets the one bit
  in `sprite_bitmask` that enables sprite 0.
- [`Joystick`](../reference/builtins/joystick.md) - reads port 1 into
  five easy `1`/`0` direction/button variables.
- [`SpritePos`](../reference/builtins/spritepos.md) - moves sprite 0 to
  a given X/Y position.

```pascal
program JoystickSpriteMove;
var
	// x is integer since the sprite coordinate space runs past 255;
	// y stays a byte, the full range it needs.
	x : integer = 160;
	y : byte = 100;

begin
	clearscreen(key_space,screen_char_loc);

	// Give sprite 0 a color, then flip its enable bit on in the hardware
	// sprite-enable register (sprite_bitmask).
	sprite_color[0] := light_red;
	togglebit(sprite_bitmask,0,1);

	repeat
		// Reading the joystick fills in joystickup/down/left/right/button;
		// each is 1 while that direction is held, 0 otherwise.
		joystick(1);

		if (joystickleft=1) then x := x - 2;
		if (joystickright=1) then x := x + 2;
		if (joystickup=1) then y := y - 2;
		if (joystickdown=1) then y := y + 2;

		// Keep the sprite from wandering off the visible screen entirely.
		if (x < 0) then x := 0;
		if (x > 320) then x := 320;
		if (y < 50) then y := 50;
		if (y > 229) then y := 229;

		SpritePos(x,y,0);
		wait(2); // small delay so movement is visible, not instant
	until false;
end.
```

[:material-download: Download this example](../assets/examples/cookbook/joystick-sprite-move.ras){ .md-button download }

## How it works

A sprite has to be explicitly switched on before it's visible: setting
`sprite_color[0]` picks its color, and `ToggleBit` flips bit 0 of
`sprite_bitmask`, the hardware register that controls which of the 8
sprites are currently displayed. `Joystick(1)` reads port 1 once and
fills in five variables the compiler declares automatically the first
time `joystick(` is used; those are just read directly afterward,
they're not returned as a value. The bounds check right before
`SpritePos` is there so the sprite can't be pushed off the edges of the
visible screen and effectively disappear; `SpritePos` itself doesn't do
any clamping on its own.
