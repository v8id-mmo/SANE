# `Tile`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Draws a 2x2-character tile at the current screen cursor position (set
with [`MoveTo`](moveto.md)), picking each of the tile's four character
codes out of four parallel lookup arrays. Auto-init: the first time
`moveto(`, `printstring(`, or `tile(` appears in a file, the compiler
automatically includes the cursor-positioning routine this builtin needs.

## Syntax

    Tile( <top-left>, <top-right>, <bottom-left>, <bottom-right>, <tile index>, <screen width> );

## Parameters

- `<top-left>`, `<top-right>`, `<bottom-left>`, `<bottom-right>`: four
  arrays, one per corner, all passed as addresses (`#array`). Each
  array is indexed by `<tile index>` to pick that corner's character
  code for the chosen tile, so all four arrays need at least
  `<tile index> + 1` entries.
- `<tile index>`: which tile to draw, a `byte` constant or variable.
- `<screen width>`: how many characters wide a screen row is (`40` for a
  standard C64 text screen), used to work out the offset to the tile's
  bottom row.

## Example

```pascal
program TileDemo;
var
	// Two 2x2 tiles: tile 0 is blank, tile 1 is a box made of the
	// PETSCII line-drawing characters.
	tl : array[2] of byte = ($20,$70);
	tr : array[2] of byte = ($20,$6e);
	bl : array[2] of byte = ($20,$6d);
	br : array[2] of byte = ($20,$7d);
	tileno : byte = 1;
begin
	clearscreen(key_space,screen_char_loc);

	moveto(10,10,hi(screen_char_loc));
	tile(#tl,#tr,#bl,#br,tileno,40);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/tile.ras){ .md-button download }
