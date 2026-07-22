# `MoveTo`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Positions the screen "cursor" used by `PrintString`, `PrintNumber`,
`PrintDecimal`, and `Tile` at a given column/row on a 40x25 text screen.
Auto-init: the first time `moveto(`, `printstring(`, or `tile(` appears in
a file, the compiler automatically includes the cursor-positioning
routine this builtin needs.

## Syntax

    MoveTo( <x>, <y>, <screen hi-byte> );

## Parameters

- `<x>`: column, 0-39.
- `<y>`: row, 0-24.
- `<screen hi-byte>`: the high byte of the screen memory address to
  position within, e.g. `hi(screen_char_loc)`.

## Example

```pascal
program MoveToDemo;
var
	i : byte;

begin
	clearscreen(key_space,screen_char_loc);

	for i:=0 to 4 do
	begin
		moveto(i*2,i,hi(screen_char_loc)); // diagonal line, one cell per row
		printstring("*",0,40);
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/moveto.ras){ .md-button download }
