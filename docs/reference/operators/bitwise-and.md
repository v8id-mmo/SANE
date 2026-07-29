# `&` (Bitwise AND)

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
miscomputes `&` on a `long` value when the right-hand side is a complex
expression; SANE fixes it.

Combines two values bit by bit: each result bit is `1` only where both
inputs have a `1` in that position. Commonly used to mask off (clear) a
set of bits, for example isolating the low nibble of a byte.

## Syntax

    <a> & <b>

## Parameters

- `<a>`, `<b>`: `byte`, `integer`, or `long` values. Bitwise operations
  don't distinguish `signed` from unsigned, they only ever look at raw
  bits.

## Returns

The bit-by-bit AND of the two values.

## Example

```pascal
program BitwiseAndDemo;
var
	a : byte = $F3;
	mask : byte = $0F;
	result : byte;

begin
	clearscreen(key_space,screen_char_loc);
	result := a & mask;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(result,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/bitwise-and.ras){ .md-button download }

## Known limitations

`&` between two `byte` or two `integer` values works correctly, and so
does mixing a `byte` with an `integer` (the byte is zero-extended, which
is always the mathematically correct thing to do for AND, since the
result of ANDing anything with an 8-bit value can never need more than 8
bits).

- **In vanilla TRSE, on a `long` (24-bit) value, `&` only works correctly
  when the right-hand side is a plain variable or literal.** As soon as
  the right-hand side is a more complex expression (an addition, for
  example), two things silently go wrong at once: the top byte of the
  result isn't ANDed at all, it's simply overwritten with whatever the
  right-hand expression's own top byte happened to be, and the middle
  byte can come out one off from the correct value, because of leftover
  state from evaluating the right-hand expression bleeding into the
  result.

    :material-check-decagram:
    **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
    `&` on a `long` value now correctly combines the top byte too, and no
    longer picks up leftover carry state on the middle byte, regardless of
    how complex the right-hand side is.
