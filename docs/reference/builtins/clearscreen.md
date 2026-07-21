# `ClearScreen`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Fills an entire 1000-byte (40x25) screen with a single byte value. Works
equally well on character screen memory or color RAM, since it just fills
1000 consecutive-ish bytes starting at the address given.

## Syntax

    ClearScreen( <fill value>, <address> );

## Parameters

- `<fill value>`: the byte to fill every screen cell with (a character
  code for screen memory, a color constant for color RAM).
- `<address>`: where the 1000-byte screen starts (e.g.
  `screen_char_loc` or `screen_col_loc`). Must be a plain numeric address
  or variable, not an expression, and not a pointer.

## Example

```pascal
program ClearScreenDemo;
begin
	clearscreen(key_space, screen_char_loc); // fill 1000-byte screen with spaces

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/clearscreen.ras){ .md-button download }

## Known limitations

Unlike [`ClearBitmap`](clearbitmap.md) and [`Call`](call.md), a plain
numeric literal works fine here for the address argument; it isn't
affected by their invalid-immediate-mode assembly bug.
