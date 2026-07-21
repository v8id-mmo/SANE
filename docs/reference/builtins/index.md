# Builtins

This section holds one reference page per builtin function/array. The full
list (139 builtins, scoped to the C64 target) is being written in batches;
this is the first one.

- [`Abs`](abs.md): returns the absolute (unsigned magnitude) value of a
  signed `byte` or `integer`.
- [`AddBreakpoint`](addbreakpoint.md): inserts a debugger breakpoint that
  halts execution and opens the VICE monitor when hit.
- [`AddressTable`](addresstable.md): looks up a screen (or other) address
  from a table built with [`CreateAddressTable`](createaddresstable.md).
- [`Atan2`](atan2.md): calculates the angle between two points.
- [`bankbyte`](bankbyte.md): returns the third byte (bits 16-23) of a
  24-bit-addressable value.
- [`BcdAdd`](bcdadd.md): adds one BCD (binary-coded decimal) number to
  another, in place.
- [`BcdCompare`](bcdcompare.md): reports whether one BCD number is larger
  than another.
- [`BcdIsEqual`](bcdisequal.md): reports whether two BCD numbers are
  exactly equal.
- [`BcdPrint`](bcdprint.md): prints a BCD number as decimal digits
  directly to the screen.
- [`BcdSub`](bcdsub.md): subtracts one BCD number from another, in place.
- [`CreateAddressTable`](createaddresstable.md): builds a table of
  addresses in memory, for fast lookup with
  [`AddressTable`](addresstable.md).
