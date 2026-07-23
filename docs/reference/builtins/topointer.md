# `ToPointer`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Builds a `pointer` value out of two separate `byte` expressions, one for
each half of the 16-bit address.

## Syntax

    <pointer> = ToPointer( <high byte>, <low byte> )

## Parameters

- `<high byte>`: the high (most significant) byte of the resulting
  address.
- `<low byte>`: the low (least significant) byte of the resulting
  address. **Note the order**: the high byte comes first, the low byte
  second, which is easy to get backwards since it's the opposite of how
  the bytes actually sit in memory.

## Returns

A `pointer` equal to `<high byte> * 256 + <low byte>`.

## Example

```pascal
program ToPointerDemo;
var
	base : integer = $0400;
	p : pointer;
begin
	clearscreen(key_space,screen_char_loc);

	// high byte first, low byte second
	p := topointer(hi(base),lo(base)+5);
	p[0] := 65; // poke an "A" screen code 5 characters into the screen

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/topointer.ras){ .md-button download }
