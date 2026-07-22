# `MemCpy`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Copies a run of bytes from one address to another, byte by byte, in a
runtime loop.

## Syntax

    MemCpy( <source>, <offset>, <dest>, <count> );

## Parameters

- `<source>`: the source address, or a `pointer` variable (in which case
  `<offset>` must be `0`).
- `<offset>`: a byte offset added to `<source>` when it's a plain address
  (not a pointer).
- `<dest>`: the destination address, or a `pointer` variable.
- `<count>`: how many bytes to copy, as a `byte` value (not `integer`).

## Example

```pascal
program MemCpyDemo;
var
	source : array[5] of byte = (1,2,3,4,5);
	dest : array[5] of byte;
	i : byte;

begin
	clearscreen(key_space,screen_char_loc);
	memcpy(#source,0,#dest,5);

	for i:=0 to 4 do
	begin
		moveto(i*3,0,hi(screen_char_loc));
		printdecimal(dest[i],2);
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/memcpy.ras){ .md-button download }

## Known limitations

If `<count>` is a runtime value (a variable or computed expression, not a
literal written in the source) that happens to be `0`, `MemCpy` doesn't
copy zero bytes: the loop's exit check only runs after each byte is
copied, so a count of 0 makes it wrap all the way around and copy a full
256 bytes instead, overwriting whatever memory follows `<dest>`. If
`<count>` is always a fixed value known at compile time, this doesn't
come up, since nothing would call `MemCpy` with a literal `0` count in
practice. See [`MemCpyFast`](memcpyfast.md), which shares this same
limitation.
