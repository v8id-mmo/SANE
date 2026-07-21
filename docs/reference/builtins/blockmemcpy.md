# `BlockMemCpy`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Copies one or more full 256-byte pages of memory from a source address to
a destination address.

## Syntax

    BlockMemCpy( <source>, <destination>, <page count> );

## Parameters

- `<source>`: the address to copy from. A plain numeric address or a
  `pointer` variable.
- `<destination>`: the address to copy to. Same rules as `<source>`.
- `<page count>`: how many 256-byte pages to copy, always a compile-time
  constant number (`1` copies 256 bytes, `2` copies 512, and so on).

## Example

```pascal
program BlockMemCpyDemo;
var
	i : byte;

begin
	clearscreen(key_space, screen_char_loc);

	for i := 0 to 39 do
		screen_char_loc[i] := 65; // fill row 0 with 'A'

	blockmemcpy($0400, $0500, 1); // copy one 256-byte page: row 0-6 area to the page below it

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/blockmemcpy.ras){ .md-button download }
