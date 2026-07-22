# `ScrollX`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Sets the VIC-II's horizontal fine-scroll value, used to smoothly scroll
the screen sideways in single-pixel steps.

## Syntax

    ScrollX(x : byte)

## Parameters

- `x`: the new horizontal scroll value, `0` to `7`.

## Example

```pascal
program ScrollXDemo;
var
	x : byte;
begin
	clearscreen(key_space, screen_char_loc);
	x := 0;
	repeat
		x := (x + 1) & 7;
		ScrollX(x);
		Wait(2);
	until false;
end.
```

[:material-download: Download this example](../../assets/examples/scrollx.ras){ .md-button download }

## Known limitations

`ScrollX` only masks the VIC-II register's *existing* contents before
writing the new value in; it never masks the value you pass it. Always
mask your own scroll counter to `0`-`7` (e.g. `x & 7`) before calling
`ScrollX`, since a value outside that range gets OR'd straight into the
scroll register, silently flipping the 38/40-column-select or
multicolor-mode bits that live in the same register.

`ScrollX` also depends on the compiling project's `temp_zeropages`
setting being non-empty; every shipped project template already
populates this, but if it's blank, `ScrollX` silently does nothing at
all, with no compiler error.
