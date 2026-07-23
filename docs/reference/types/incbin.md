# `incbin`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a variable whose storage is the raw bytes of an external binary
file, included directly at assemble time. With no address given, the data
sits inline with the program's other variables and is directly indexable
like a byte array; with an address, the bytes are placed at that fixed
location instead. Unlike [`@bin2inc`](../directives/bin2inc.md) (which
writes a separate source file to `@include`), `incbin` needs no
intermediate file: the binary is pulled in directly at the declaration.

## Syntax

    var
        <name> : incbin("<file>");
        <name> : incbin("<file>", $<address>);

## Parameters

- `<name>`: the variable's identifier; also usable as a byte array
  (`<name>[<index>]`) when no fixed address is given.
- `<file>`: path to the binary file, resolved relative to the project
  file's own directory.
- `<address>`: optional, a fixed memory location to place the data at
  instead of packing it inline with other variables.

## Example

```pascal
program IncBinDemo;
var
	rawData : incbin("sample_data.bin");
	i : byte;
	total : integer;
begin
	clearscreen(key_space,screen_char_loc);

	total := 0;
	for i:=0 to 7 do
		total := total + rawData[i];

	moveto(0,0,hi(screen_char_loc));
	printstring("sum:",0,40);
	moveto(5,0,hi(screen_char_loc));
	printdecimal(total,3);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/incbin.ras){ .md-button download }
(also needs [`sample_data.bin`](../../assets/examples/sample_data.bin) in
the same folder)
