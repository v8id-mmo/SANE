# `DrawTextBox`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Draws a rectangular PETSCII box outline directly to screen memory, using
a screen address table built with
[`CreateAddressTable`](createaddresstable.md) and an 8-element array of
box-drawing characters (top-left, top edge, top-right, right edge,
bottom-right, bottom edge, bottom-left, left edge, in that order).

## Syntax

    DrawTextBox( <addrtable>, <petsciiarray>, <column>, <row>, <width>, <height> );

## Parameters

- `<addrtable>`: an `array of integer` built with `CreateAddressTable`,
  one entry per screen row, referenced with `#`.
- `<petsciiarray>`: an `array[8] of byte` holding the 8 border characters,
  referenced with `#`.
- `<column>`, `<row>`: top-left corner of the box, in character cells.
- `<width>`, `<height>`: size of the box, in character cells.

## Example

```pascal
program DrawTextBoxDemo;
var
	saddr : array[screen_height] of integer; // screen address table
	box : array[8] of byte = ($55, $43, $49, $5d, $4b, $43, $4a, $5d); // PETSCII box-drawing chars

begin
	clearscreen(key_space, #screen_char_loc);
	createaddresstable(#saddr,#screen_char_loc,screen_width,screen_height);
	drawtextbox(#saddr, #box, 5, 5, 9, 5);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/drawtextbox.ras){ .md-button download }
