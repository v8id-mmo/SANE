# `GetBit`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reads a single bit out of a `byte` value and returns it as `1` (set) or
`0` (clear).

## Syntax

    <byte> = getbit( <variable>, <bit index> )

## Parameters

- `<variable>`: the `byte` variable to read a bit from.
- `<bit index>`: which bit to read, `0` (least significant) through `7`
  (most significant). Can be a constant or a variable/expression.

## Returns

`1` if the chosen bit is set, `0` if it's clear.

## Example

```pascal
program GetBitDemo;
var
	flags : byte = %00000101;
	idx : byte = 1;
	result : byte;
begin
	clearscreen(key_space,screen_char_loc);

	// constant bit index: bit 0 is set
	result := getbit(flags, 0);
	moveto(0,0,hi(screen_char_loc));
	printdecimal(result,1);

	// constant bit index: bit 1 is clear
	result := getbit(flags, 1);
	moveto(0,1,hi(screen_char_loc));
	printdecimal(result,1);

	// variable bit index: bit 2 is set
	result := getbit(flags, idx+1);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(result,1);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/getbit.ras){ .md-button download }
