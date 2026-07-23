# Types

The built-in base types available on the C64 target, and the small set of
type-system modifiers (`pure`, `pure_variable`, `pure_number`) that
constrain how a value can be used rather than describing storage. This
batch covers the first few; more are added as later batches land.

- [`address`](address.md): a compile-time-only 16-bit memory location,
  usually a hardware register or a fixed data address.
- [`array`](array.md): a fixed-size, zero-indexed sequence of elements of
  one shared type.
- [`boolean`](boolean.md): a true/false value, used in conditions and
  logical expressions.
- [`byte`](byte.md): an 8-bit unsigned value, the smallest and most
  commonly used numeric type.
- [`class`](class.md): a `record` with its own methods and a `this`
  reference, for object-style code.
