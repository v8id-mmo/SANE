# `|` (Bitwise OR)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Combines two values bit by bit: each result bit is `1` where either input
has a `1` in that position. Commonly used to set (turn on) a specific set
of bits without disturbing the others.

## Syntax

    <a> | <b>

## Parameters

- `<a>`, `<b>`: `byte`, `integer`, or `long` values. Bitwise operations
  don't distinguish `signed` from unsigned, they only ever look at raw
  bits.

## Returns

The bit-by-bit OR of the two values.

## Example

```pascal
program BitwiseOrDemo;
var
	a : byte = $F0;
	b : byte = $0F;
	result : byte;

begin
	clearscreen(key_space,screen_char_loc);
	result := a | b;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(result,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/bitwise-or.ras){ .md-button download }

## Known limitations

`|` between two `byte` or two `integer` values works correctly, and so
does mixing a `byte` with an `integer` (the byte is zero-extended, which
is always the mathematically correct thing to do for OR, since the result
of ORing anything with an 8-bit value can never need more than 8 bits).

- **On a `long` (24-bit) value, `|` only works correctly when the
  right-hand side is a plain variable or literal.** As soon as the
  right-hand side is a more complex expression (an addition, for
  example), two things silently go wrong at once: the top byte of the
  result isn't ORed at all, it's simply overwritten with whatever the
  right-hand expression's own top byte happened to be, and the middle
  byte can come out one off from the correct value, because of leftover
  state from evaluating the right-hand expression bleeding into the
  result. Keep the right-hand side of a `long |` a plain variable (or
  copy a complex expression into a temporary `long` variable first) to
  avoid this.
