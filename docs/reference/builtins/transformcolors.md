# `TransformColors`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Remaps an entire 1000-byte (40x25) text screen and its matching Color
RAM in place, through a 16-entry lookup table. Useful for palette-swap
style effects: recolor or re-character every cell on screen in one call
instead of looping over all 1000 cells by hand.

## Syntax

    TransformColors( <palette>, <screen address> );

## Parameters

- `<palette>`: a 16-entry `byte` array, passed as an address
  (`#array`). Entry `i` is the replacement for old value `i`. Each
  screen character byte has its upper and lower nibble looked up and
  replaced independently, then recombined; each Color RAM byte at the
  same offset is looked up and replaced directly (color values are
  already a single nibble, 0-15).
- `<screen address>`: the address of the 1000-byte screen memory block
  to transform (see Known limitations for what this needs to be). Color
  RAM is always read/written at the fixed hardware address `$D800`,
  regardless of `<screen address>`.

Always processes exactly 1000 bytes, regardless of the project's actual
screen size or location; it isn't aware of a screen moved with
[`SetScreenLocation`](setscreenlocation.md) unless `<screen address>` is
set to match.

## Example

```pascal
program TransformColorsDemo;
var
	invpal : array[16] of byte = (15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0);
	const
		screenbase : address = $0400;
begin
	clearscreen(key_space,screen_char_loc);
	screen_fg_col := white;
	moveto(0,0,hi(screen_char_loc));
	printstring("INVERTED ON NEXT FRAME",0,40);

	transformcolors(#invpal,screenbase);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/transformcolors.ras){ .md-button download }

## Known limitations

**A bare numeric literal for `<screen address>` fails to assemble**,
the same known issue that affects [`Call`](call.md),
[`ClearBitmap`](clearbitmap.md), and several other builtins: writing
`transformcolors(#invpal,$0400)` directly produces an invalid
instruction at the assembly stage. Routing the same address through a
named `address` constant, as shown in the example above, works
correctly.
