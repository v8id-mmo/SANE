# `MemCpyFast`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A faster variant of [`MemCpy`](memcpy.md), using a tighter decrementing
loop instead of an incrementing one.

## Syntax

    MemCpyFast( <source>, <offset>, <dest>, <count> );

## Parameters

- `<source>`: the source address, or a `pointer` variable (in which case
  `<offset>` must be `0`).
- `<offset>`: a byte offset added to `<source>` when it's a plain address
  (not a pointer).
- `<dest>`: the destination address, or a `pointer` variable.
- `<count>`: how many bytes to copy, as a `byte` value (not `integer`).

## Example

```pascal
program MemCpyFastDemo;
var
	source : array[5] of byte = (1,2,3,4,5);
	dest : array[5] of byte;
	i : byte;

begin
	clearscreen(key_space,screen_char_loc);
	memcpyfast(#source,0,#dest,5);

	for i:=0 to 4 do
	begin
		moveto(i*3,0,hi(screen_char_loc));
		printdecimal(dest[i],2);
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/memcpyfast.ras){ .md-button download }

## Known limitations

If `<count>` is a runtime value (a variable or computed expression, not a
literal written in the source) that happens to be `0`, `MemCpyFast`
doesn't copy zero bytes: its loop counter starts at `count - 1`, which
wraps to `255` when `count` is `0`, so it copies a full 256 bytes instead
of none, overwriting whatever memory follows `<dest>`. If `<count>` is
always a fixed value known at compile time, this doesn't come up, since
nothing would call `MemCpyFast` with a literal `0` count in practice. See
[`MemCpy`](memcpy.md), which shares this same limitation.
