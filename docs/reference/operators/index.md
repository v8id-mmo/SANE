# Operators

This section holds one reference page per operator. This category was
added on top of the original Keywords/Builtins/Types split specifically
because most of the compiler's known signed-arithmetic bugs live here.

## Comparison

- [`<`](less-than.md): true if the left value is smaller than the right
  value.
- [`<=`](less-or-equal.md): true if the left value is smaller than, or
  equal to, the right value.
- [`>`](greater-than.md): true if the left value is larger than the right
  value.
- [`>=`](greater-or-equal.md): true if the left value is larger than, or
  equal to, the right value.
- [`=`](equal.md): true if the two values are exactly equal.
- [`<>`](not-equal.md): true if the two values are different.

## Arithmetic

- [`+`](addition.md): adds two values.
- [`-`](subtraction.md): subtracts the right value from the left value.
- [`*`](multiplication.md): multiplies two values.
- [`/`](division.md): divides the left value by the right value, keeping
  only the integer part.

## Bitwise

- [`&`](bitwise-and.md): clears bits where either input has a `0`, keeps
  bits where both inputs have a `1`.
- [`|`](bitwise-or.md): sets bits where either input has a `1`.
- [`xor` / `^`](xor.md): sets bits where exactly one input has a `1`,
  toggling bits.
- [`shl` / `<<`](shift-left.md): shifts bits left, filling with `0`.
- [`shr` / `>>`](shift-right.md): shifts bits right, filling with `0`.

The remaining categories (logical, assignment) are planned for a later
batch.
