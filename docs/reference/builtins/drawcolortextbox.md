# `DrawColorTextBox`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Like [`DrawTextBox`](drawtextbox.md), but also fills the box's border
cells in color RAM with a single solid color, using a second address
table built over color memory.

## Syntax

    DrawColorTextBox( <addrtable>, <coloraddrtable>, <petsciiarray>, <column>, <row>, <width>, <height>, <color> );

## Parameters

- `<addrtable>`: a screen address table built with `CreateAddressTable`,
  referenced with `#`.
- `<coloraddrtable>`: a color-RAM address table built with
  `CreateAddressTable`, referenced with `#`.
- `<petsciiarray>`: an `array[8] of byte` holding the 8 border characters,
  referenced with `#`.
- `<column>`, `<row>`: top-left corner of the box, in character cells.
- `<width>`, `<height>`: size of the box, in character cells.
- `<color>`: the color applied to every border cell.

## Example

```pascal
program DrawColorTextBoxDemo;
var
	saddr : array[screen_height] of integer; // screen address table
	caddr : array[screen_height] of integer; // color address table
	box : array[8] of byte = ($55, $43, $49, $5d, $4b, $43, $4a, $5d); // PETSCII box-drawing chars

begin
	clearscreen(key_space, #screen_char_loc);
	clearscreen(black, #screen_col_loc);
	createaddresstable(#saddr,#screen_char_loc,screen_width,screen_height);
	createaddresstable(#caddr,#screen_col_loc,screen_width,screen_height);
	drawcolortextbox(#saddr, #caddr, #box, 5, 5, 9, 5, light_blue);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/drawcolortextbox.ras){ .md-button download }
