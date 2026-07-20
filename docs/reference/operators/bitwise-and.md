# `&` (Bitwise AND)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

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

- **On a `long` (24-bit) value, `&` only works correctly when the
  right-hand side is a plain variable or literal.** As soon as the
  right-hand side is a more complex expression (an addition, for
  example), two things silently go wrong at once: the top byte of the
  result isn't ANDed at all, it's simply overwritten with whatever the
  right-hand expression's own top byte happened to be, and the middle
  byte can come out one off from the correct value, because of leftover
  state from evaluating the right-hand expression bleeding into the
  result. Confirmed by comparing the generated code for a plain-variable
  version against a complex-expression version of the same `long`
  expression. Keep the right-hand side of a `long &` a plain variable (or
  copy a complex expression into a temporary `long` variable first) to
  avoid this.
