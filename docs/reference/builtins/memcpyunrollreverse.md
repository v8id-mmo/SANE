# `MemCpyUnrollReverse`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Like [`MemCpyUnroll`](memcpyunroll.md), but copies the bytes starting from
the last one and working backward to the first. Useful when source and
destination overlap and the destination starts after the source, where
copying forward would overwrite source bytes before they're read.

## Syntax

    MemCpyUnrollReverse( <source>, <offset>, <dest>, <count> );

## Parameters

- `<source>`: the source address, or a `pointer` variable.
- `<offset>`: a byte offset added to `<source>` when it's a plain address
  (not a pointer).
- `<dest>`: the destination address, or a `pointer` variable.
- `<count>`: how many bytes to copy. Must be a compile-time constant, not
  a variable or runtime expression, the same restriction as
  `MemCpyUnroll`.

## Example

```pascal
program MemCpyUnrollReverseDemo;
var
	source : array[5] of byte = (1,2,3,4,5);
	dest : array[5] of byte;
	i : byte;

begin
	clearscreen(key_space,screen_char_loc);
	memcpyunrollreverse(#source,0,#dest,5); // count must be a compile-time constant

	for i:=0 to 4 do
	begin
		moveto(i*3,0,hi(screen_char_loc));
		printdecimal(dest[i],2);
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/memcpyunrollreverse.ras){ .md-button download }
