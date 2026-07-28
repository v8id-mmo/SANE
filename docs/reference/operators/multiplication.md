# `*` (Multiplication)

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE's
signed multiplication silently gave the wrong result once the product
widened to an `integer`; SANE fixes it.

Multiplies two numeric values together.

## Syntax

    <a> * <b>

## Parameters

- `<a>`, `<b>`: `byte` or `integer` values. `long` (24-bit) operands
  aren't supported, see Known limitations.

## Returns

The product. Whether it's computed as an 8-bit or 16-bit multiply depends
on the operand and destination types, see the widening note below.

## Example

```pascal
program MultiplicationDemo;
var
	a : byte = 20;
	b : byte = 20;
	product : integer;

begin
	clearscreen(key_space,screen_char_loc);
	product := a * b;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(product,5);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/multiplication.ras){ .md-button download }

## Known limitations

- **`long` (24-bit) multiplication isn't supported at all**; using `*`
  with a `long` operand fails to compile.
- **Assigning a `byte * byte` product directly into an `integer` variable
  correctly computes the full 16-bit product**, as in the example above
  (`20 * 20 = 400`, which doesn't fit in a `byte`, but `product` correctly
  ends up `400` because it's declared `integer`). This only happens when
  assigning straight into the wider variable; a `byte * byte` product used
  any other way (assigned to another `byte`, passed as a `byte` parameter,
  or used inside a larger expression with nothing wider around it) keeps
  only the low 8 bits of the product and silently discards the rest, with
  no warning (`20 * 20` would come out as `144`, not `400`).
- **In vanilla TRSE, multiplying two byte values where the product
  widened to an `integer` and at least one operand was a negative signed
  number gave a wrong result, with no compile error or warning.** A plain
  `byte * byte` product kept as a `byte` was never affected, since a
  two's-complement product's low byte is identical whether the inputs are
  interpreted as signed or unsigned.  
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  the word-widening case now correctly accounts for the sign of a
  negative operand.
