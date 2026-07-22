# Builtins

This section holds one reference page per builtin function/array. The full
list (139 builtins, scoped to the C64 target) is being written in batches.

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
- [`BlockMemCpy`](blockmemcpy.md): copies one or more full 256-byte pages
  from a source address to a destination address.
- [`Call`](call.md): calls a machine-code routine at an address, and
  returns once it hits an `rts`.
- [`ClearBitmap`](clearbitmap.md): clears one or more 256-byte pages of
  bitmap memory to zero.
- [`ClearScreen`](clearscreen.md): fills an entire 1000-byte screen (or
  color RAM) with one byte value.
- [`ClearSound`](clearsound.md): immediately silences all three SID
  voices.
- [`CloseIRQ`](closeirq.md): restores registers at the end of an
  interrupt handler started with `StartIRQ`.
- [`CloseIRQWedge`](closeirqwedge.md): the `CloseIRQ` counterpart for
  raster-IRQ "wedge" chaining.
- [`CopyBytesShift`](copybytesshift.md): copies a run of bytes while
  shifting or rotating each one by a fixed number of bits.
- [`CopyCharsetFromRom`](copycharsetfromrom.md): copies the character ROM
  font to RAM for customization.
- [`CopyFullScreen`](copyfullscreen.md): copies an entire 1000-byte text
  screen (or color RAM) from one address to another.
- [`CopyHalfScreen`](copyhalfscreen.md): copies a chosen number of
  40-column rows from one address to another.
- [`CopyImageColorData`](copyimagecolordata.md): unpacks an exported
  image asset's char and color data into a chosen VIC bank.
- [`CreateInteger`](createinteger.md): builds a 16-bit value from
  separate low/high byte expressions.
- [`CreatePointer`](createpointer.md): builds a 24-bit-addressable
  pointer value from separate low/high byte expressions.
- [`Dec`](dec.md): decreases a variable by 1, in place.
- [`DecRange`](decrange.md): decreases a variable by 1, wrapping back to
  a high value once it reaches a low value.
- [`Decrunch`](decrunch.md): decompresses an Exomizer-crunched block of
  data in place.
- [`DecrunchFromIndex`](decrunchfromindex.md): like `Decrunch`, but picks
  the source address from a table at runtime.
- [`DefineScreen`](definescreen.md): defines the `screenmemory` and
  `colormemory` label aliases other builtins rely on.
- [`DisableCIAInterrupts`](disableciainterrupts.md): turns off the CIA
  timer interrupts, ahead of installing a custom raster interrupt.
- [`disassemble`](disassemble.md): pauses in the VICE monitor at this
  point, showing a disassembly.
- [`DrawColorTextBox`](drawcolortextbox.md): like `DrawTextBox`, but also
  fills the box's border cells in color RAM with one color.
- [`DrawTextBox`](drawtextbox.md): draws a rectangular PETSCII box outline
  to screen memory from an address table and border characters.
- [`EnableAllRam`](enableallram.md): banks out BASIC/KERNAL ROM, leaving
  I/O and color RAM visible.
- [`EnableIRQ`](enableirq.md): acknowledges the raster interrupt flag and
  turns interrupts back on.
- [`EnableRasterIRQ`](enablerasterirq.md): turns on the VIC-II's
  raster-compare interrupt source.
- [`Fill`](fill.md): writes the same byte value to a run of consecutive
  memory locations.
- [`FillFast`](fillfast.md): a faster variant of `Fill` for plain
  numeric/variable fill values.
- [`FLD`](fld.md): performs one or more lines of a Flexible Line Distance
  raster-stretch effect.
