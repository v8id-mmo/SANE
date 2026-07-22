# `SpritePos`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Sets a hardware sprite's X/Y screen position. `x` is a full 16-bit value
since sprites can be positioned slightly off the left edge of the
320-pixel-wide coordinate space.

## Syntax

    SpritePos(x : integer, y : byte, spriteNum : byte)

## Parameters

- `x`: horizontal position, `0`-`320` ish (`integer`, since it can exceed
  255).
- `y`: vertical position, `0`-`255` (`byte`).
- `spriteNum`: which sprite (`0`-`7`) to move.

## Example

```pascal
program SpritePosDemo;
var
	x : integer = 100;
begin
	sprite_color[0] := light_red;
	togglebit(sprite_bitmask, 0, 1);   // turn sprite 0 on
	repeat
		x := x + 1;
		if (x > 320) then
			x := 0;
		SpritePos(x, 100, 0);
		Wait(1);
	until false;
end.
```

[:material-download: Download this example](../../assets/examples/spritepos.ras){ .md-button download }

## Known limitations

`spriteNum` isn't range-checked. If it's a compile-time constant of `8`
or higher, the position writes land on the wrong target entirely: `8`
writes the X value straight into the VIC-II's sprite-MSB register and
the Y value into the VIC-II's main control register (screen on/off,
text/bitmap mode, Y-scroll, and the raster-compare high bit), corrupting
core display state instead of moving a (nonexistent) ninth sprite. Keep
`spriteNum` in the real `0`-`7` hardware range; nothing in the compiler
enforces it for you.
