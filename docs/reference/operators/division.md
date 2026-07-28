# `/` (Division)

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
never implemented signed division at all, always dividing as if both
operands were unsigned; SANE adds a real signed division path for a
result that widens to `integer` (see Known limitations for the plain
`byte / byte` case, which is still open).

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
- **In vanilla TRSE, signed division isn't implemented at all.** Division
  always uses unsigned arithmetic, completely ignoring the `signed`
  modifier on either operand; there's no signed-aware division routine to
  fall back on. `mod`/`mod16` share the identical gap. :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  `mod` and `mod16` (any width) and `/` **when the quotient widens to an
  `integer`** now follow C-style truncating semantics: the quotient's
  sign is the xor of the two operands' signs, and, for
  [`mod`](../builtins/mod.md)/[`mod16`](../builtins/mod16.md), the
  remainder's sign follows the dividend's own sign.
- **A plain `byte / byte` division that stays a `byte` result (not
  widened to `integer`) is still unsigned only, in both TRSE and SANE.**
  Unlike multiplication, a two's-complement quotient's low byte isn't
  sign-independent the way a product's is, so this case doesn't get the
  "already correct" pass multiplication's byte-only path gets; a negative
  signed operand genuinely gives a wrong result here. Still open; see
  [`init8x8div`](../builtins/init8x8div.md).
- **Dividing by zero at runtime doesn't crash or hang, but doesn't produce
  a meaningful result either.** The generated division routine is a
  fixed-length loop with no zero-check, so it always finishes normally and
  returns some fixed, meaningless quotient rather than erroring. The
  compiler does catch division by zero at compile time, but only when both
  sides of `/` are literal constants it can evaluate ahead of time (a
  runtime value that happens to be zero isn't caught).
