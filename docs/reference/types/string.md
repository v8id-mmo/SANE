# `string`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A text literal stored as-is (plain PETSCII/ASCII text, unconverted), with
a null terminator appended automatically. The type
[`printstring`](../builtins/printstring.md)/
[`Tile`](../builtins/tile.md) and similar text-output builtins expect. Use
[`cstring`](cstring.md) instead when the text needs to already be in
screen-code form (for a direct screen-memory copy).

## Syntax

    var
        <name> : string = "<text>";
        <name> : array[<size>] of string = ("<text1>", "<text2>", ...);
        <name> : string = "<text>" no_term;

## Parameters

- `<name>`: the variable's identifier.
- `"<text>"`: the literal text.
- [`no_term`](../keywords/no_term.md): optional flag, suppresses the
  trailing terminator byte.

## Example

```pascal
program StringDemo;
var
	greeting : string = "HELLO WORLD";
	names : array[3] of string = ("ALICE","BOB","CARL");
	i : byte;
begin
	clearscreen(key_space,screen_char_loc);

	printstring(greeting,0,0);

	for i:=0 to 2 do
	begin
		moveto(0,i+1,hi(screen_char_loc));
		printstring(names[i],0,40);
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/string.ras){ .md-button download }

## Known limitations

**An `array` of `string` is really an array of pointers**, not an array of
inline text blocks: each string literal is emitted as its own separately
addressed block of data, and the array itself just stores a table of
16-bit addresses pointing at them. This matters if the array's raw bytes
are ever inspected or copied directly (with, say,
[`MemCpy`](../builtins/memcpy.md)): what's actually stored per element is
an address, not the text itself.
