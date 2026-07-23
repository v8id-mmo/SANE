# `long`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A 24-bit value, stored as three bytes. Available on every MOS6502-family
target (including the C64), not just wider CPUs; useful for a counter or
address range that outgrows a 16-bit [`integer`](integer.md) without
reaching for full 32-bit arithmetic the 6502 has no fast native support
for anyway.

## Syntax

    var
        <name> : long;
        <name> : long = <initial value>;

## Parameters

- `<name>`: the variable's identifier.
- `<initial value>`: optional, a 24-bit constant.

## Example

```pascal
program LongDemo;
var
	frameCount : long = 0;
	i : integer;
	lowByte : ^byte;
begin
	clearscreen(key_space,screen_char_loc);

	for i:=0 to 999 do
		frameCount := frameCount + 1;

	// PrintDecimal takes a byte, so read just the low byte of the
	// 24-bit total through a pointer rather than the full value.
	// (Lo()/Hi() don't work on a long, see Known limitations below,
	// so a plain pointer is used here instead.)
	lowByte := #frameCount;
	moveto(0,0,hi(screen_char_loc));
	printstring("frames (low byte):",0,40);
	moveto(19,0,hi(screen_char_loc));
	printdecimal(lowByte^,3);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/long.ras){ .md-button download }

## Known limitations

Several operations that work correctly on `byte`/`integer` are incomplete
or wrong specifically for `long`:

- **Signed comparison isn't implemented at all** for `signed long`; every
  comparison operator fails to compile with "Signed long comparison not
  implemented yet." (`signed integer` at least has `<`/`<=` working; see
  [`signed`](../keywords/signed.md).)
- **Bitwise `&`/`|`/`xor`/`^` silently miscompute the result** when the
  right-hand operand is a non-trivial expression rather than a plain
  variable: the top byte isn't combined into the result at all (it's
  overwritten with the right operand's own top byte), and the middle byte
  can come out off by one. See [`bitwise-and`](../operators/bitwise-and.md).
- **[`Lo`](../builtins/lo.md)/[`Hi`](../builtins/hi.md)/[`bankbyte`](../builtins/bankbyte.md)
  are all a silent no-op on a `long` value**: no code at all is emitted,
  unlike on a `pointer`, where all three work correctly.
- **[`abs()`](../builtins/abs.md) only negates the low byte** of a `long`
  (checking the wrong byte for the sign, leaving the other two untouched),
  giving a wrong result for any negative `long`.
- **`long` multiplication and division aren't supported at all**;
  `*`/`/` on two `long` operands is a compile error, not a silently wrong
  result.
