# `MemCpyUnroll`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Copies a run of bytes from one address to another, the same way
[`MemCpy`](memcpy.md) does, but generates one literal copy instruction per
byte at compile time instead of a runtime loop. Faster to execute, at the
cost of a larger program for a large count.

## Syntax

    MemCpyUnroll( <source>, <offset>, <dest>, <count> );

## Parameters

- `<source>`: the source address, or a `pointer` variable.
- `<offset>`: a byte offset added to `<source>` when it's a plain address
  (not a pointer).
- `<dest>`: the destination address, or a `pointer` variable.
- `<count>`: how many bytes to copy. Must be a compile-time constant, not
  a variable or runtime expression, since it directly controls how many
  copy instructions get generated.

## Example

```pascal
program MemCpyUnrollDemo;
var
	source : array[5] of byte = (1,2,3,4,5);
	dest : array[5] of byte;
	i : byte;

begin
	clearscreen(key_space,screen_char_loc);
	memcpyunroll(#source,0,#dest,5); // count must be a compile-time constant

	for i:=0 to 4 do
	begin
		moveto(i*3,0,hi(screen_char_loc));
		printdecimal(dest[i],2);
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/memcpyunroll.ras){ .md-button download }
