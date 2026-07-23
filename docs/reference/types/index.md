# Types

The built-in base types available on the C64 target, and the small set of
type-system modifiers (`pure`, `pure_variable`, `pure_number`) that
constrain how a value can be used rather than describing storage.

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
- [`cstring`](cstring.md): text pre-converted to C64 screen codes, ready
  to copy straight into screen memory.
- [`incbin`](incbin.md): embeds a raw binary file's bytes directly as a
  variable's storage, no separate include step needed.
- [`incsid`](incsid.md): embeds a `.sid` music file and exposes its
  init/play addresses as ready-made constants.
- [`integer`](integer.md): a 16-bit value, the only 16-bit numeric type on
  this fork (there is no separate `word`).
- [`long`](long.md): a 24-bit value, available on every MOS6502-family
  target.
- [`pointer`](pointer.md): a 16-bit address that can be dereferenced to
  read or write a `byte`/`integer`/`long`/record instance.
- [`pure`](pure.md): a parameter modifier accepting either a constant or a
  plain variable, not a computed expression.
- [`pure_number`](pure_number.md): a parameter modifier accepting only a
  compile-time constant.
- [`pure_variable`](pure_variable.md): a parameter modifier accepting
  only a plain variable reference.
- [`record`](record.md): a fixed collection of named fields grouped under
  one type, the base for `class`.
- [`string`](string.md): plain, unconverted text with an automatic null
  terminator.
