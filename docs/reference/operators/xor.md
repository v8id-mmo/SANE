# `xor` / `^` (Bitwise XOR)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Combines two numeric values bit by bit: each result bit is `1` where
exactly one of the two inputs has a `1` in that position (and `0` where
they agree). `xor` and `^` are the same operator, just two different
spellings. Commonly used to toggle a specific set of bits.

## Syntax

    <a> xor <b>
    <a> ^ <b>

## Parameters

- `<a>`, `<b>`: `byte`, `integer`, or `long` values. Bitwise operations
  don't distinguish `signed` from unsigned, they only ever look at raw
  bits.

## Returns

The bit-by-bit XOR of the two values.

## Example

```pascal
program XorDemo;
var
	a : byte = $AA;
	b : byte = $0F;
	result : byte;

begin
	clearscreen(key_space,screen_char_loc);
	result := a xor b;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(result,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/xor.ras){ .md-button download }

## Known limitations

`xor`/`^` between two `byte` or two `integer` values works correctly, and
so does mixing a `byte` with an `integer` (the byte is zero-extended,
which is always the mathematically correct thing to do for XOR, since the
result of XORing anything with an 8-bit value can never need more than 8
bits).

- **On a `long` (24-bit) value, `xor`/`^` only works correctly when the
  right-hand side is a plain variable or literal.** As soon as the
  right-hand side is a more complex expression (an addition, for
  example), two things silently go wrong at once: the top byte of the
  result isn't XORed at all, it's simply overwritten with whatever the
  right-hand expression's own top byte happened to be, and the middle
  byte can come out one off from the correct value, because of leftover
  state from evaluating the right-hand expression bleeding into the
  result. Keep the right-hand side of a `long xor` a plain variable (or
  copy a complex expression into a temporary `long` variable first) to
  avoid this.
- **`xor` written between two parenthesized conditions (not two plain
  numeric values) compiles without error but always evaluates true,
  regardless of what either condition actually is.** For example,
  `if ((a>5) xor (b<3)) then ... else ...;` compiles cleanly, but the
  `else` branch becomes unreachable: both conditions get evaluated
  correctly, but the step that's supposed to combine them with `xor` and
  branch on the result is missing, so execution always falls through into
  the "true" branch. Only `and`/`or` are actually wired up to combine two
  conditions this way; don't use `xor` for this, it silently does the
  wrong thing with no warning. This is a completely separate case from
  plain bitwise `xor` between two numeric values (as in the example
  above), which is unaffected and works correctly.
