# `/` (Division)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Divides the left-hand value by the right-hand value, keeping only the
integer part of the result (no fractional/remainder value).

## Syntax

    <a> / <b>

## Parameters

- `<a>`, `<b>`: `byte` or `integer` values. `long` (24-bit) operands
  aren't supported, see Known limitations.

## Returns

The integer quotient. Whether it's computed as an 8-bit or 16-bit divide
depends on the operand and destination types, the same way multiplication
does (see [`*`](multiplication.md)'s widening note).

## Example

```pascal
program DivisionDemo;
var
	a : byte = 17;
	b : byte = 5;
	quotient : byte;

begin
	clearscreen(key_space,screen_char_loc);
	quotient := a / b;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(quotient,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/division.ras){ .md-button download }

## Known limitations

- **`long` (24-bit) division isn't supported at all**; using `/` with a
  `long` operand fails to compile.
- **Signed division isn't implemented at all.** Division always uses
  unsigned arithmetic, completely ignoring the `signed` modifier on either
  operand; there's no signed-aware division routine anywhere in the
  compiler to fall back on, so this isn't just an occasionally-wrong
  result the way signed multiplication is, it's simply never
  sign-correct.
- **Dividing by zero at runtime doesn't crash or hang, but doesn't produce
  a meaningful result either.** The generated division routine is a
  fixed-length loop with no zero-check, so it always finishes normally and
  returns some fixed, meaningless quotient rather than erroring. The
  compiler does catch division by zero at compile time, but only when both
  sides of `/` are literal constants it can evaluate ahead of time (a
  runtime value that happens to be zero isn't caught).
