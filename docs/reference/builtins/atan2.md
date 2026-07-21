# `Atan2`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Calculates the angle between two points, given as `(x1, y1)` and
`(x2, y2)`. Useful for aiming a sprite or projectile at a target.

## Syntax

    <byte angle> = Atan2( <byte x1>, <byte x2>, <byte y1>, <byte y2> );

## Parameters

- `<x1>`, `<y1>`: the first point.
- `<x2>`, `<y2>`: the second point.

If working with sprite X positions, scale both X values by half first
(sprite coordinates are wider than the underlying angle table expects).

## Returns

A `byte` between 0 and 255 representing the angle from point 1 to point 2,
where 0 is 3 o'clock, 64 is 6 o'clock, 128 is 9 o'clock, and 192 is
12 o'clock.

## Example

```pascal
program Atan2Demo;
var
	x1, x2, y1, y2, angle : byte;

begin
	clearscreen(key_space,screen_char_loc);

	x1 := 100; y1 := 100;
	x2 := 200; y2 := 100; // point 2 is due "3 o'clock" from point 1

	angle := Atan2(x1, x2, y1, y2);

	moveto(0,2,hi(screen_char_loc));
	printdecimal(angle,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/atan2.ras){ .md-button download }

## Known limitations

`Atan2` is auto-initialized (the compiler includes its lookup table and
calculation routine the first time it sees `atan2(` in the source), but
unlike some other auto-initialized builtins, it isn't affected by the
`@use`d-unit-file auto-init scan gap: calling it only from inside a unit
file still works correctly. Its "auto-init" doesn't need a runtime setup
call at all, it just makes sure the lookup table and routine get
included exactly once, and that inclusion is triggered independently by
each file's own text, unit files included.
