# `-` (Subtraction)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Subtracts the right-hand value from the left-hand value.

## Syntax

    <a> - <b>

## Parameters

- `<a>`, `<b>`: numeric values (`byte`, `integer`, or `long`), unsigned or
  `signed`.

## Returns

The difference. The result stays at whichever width is wider: the
operands' own declared type, or, when the difference is assigned straight
into a variable, that variable's type (see the widening note below).

## Example

```pascal
program SubtractionDemo;
var
	a : byte = 10;
	b : byte = 4;
	diff : byte;

begin
	clearscreen(key_space,screen_char_loc);
	diff := a - b;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(diff,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/subtraction.ras){ .md-button download }

## Known limitations

Subtraction works correctly for unsigned and `signed` values alike, at
every supported width (`byte`, `integer`, `long`); like addition, it never
needs to treat a signed and unsigned value differently, since
two's-complement subtraction is bit-identical either way.

- **Assigning a `byte - byte` result directly into a wider variable widens
  it correctly**, the same way addition does: `byteA - byteB` assigned
  straight into an `integer` variable produces a correct wider result
  (including correctly representing a result that went negative, if the
  destination is `signed`), not a truncated 8-bit one. This only applies
  when assigning straight into the wider variable; a `byte - byte` result
  used any other way stays 8-bit and wraps on underflow instead (`0 - 1`
  comes out as `255`, not `-1`).
- **Mixing a negative `signed byte` into a wider expression zero-extends
  instead of sign-extending its value**, the same limitation described on
  the [`signed`](../keywords/signed.md) page: a `-1` byte widened into an
  `integer` comes out as `255` (`$00FF`) instead of `-1` (`$FFFF`). Same-width
  subtraction (`signed byte - signed byte`, or `signed integer - signed
  integer`) is unaffected; the problem is specific to combining a negative
  byte with an already-wider operand in the same expression.
