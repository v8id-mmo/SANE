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
- [`GetBit`](getbit.md): reads a single bit out of a `byte` value,
  returned as `1` or `0`.
- [`getKey`](getkey.md): reads the keyboard matrix directly, returning a
  raw key code or `0`.
- [`Hi`](hi.md): returns the high byte (bits 8-15) of a 16-bit value.
- [`hideborderx`](hideborderx.md): widens or restores the left/right
  screen border.
- [`hidebordery`](hidebordery.md): widens or restores the top/bottom
  screen border.
- [`Inc`](inc.md): increases a variable by 1, in place.
- [`IncRange`](incrange.md): increases a variable by 1, wrapping back to
  a chosen low value once it reaches a chosen high value.
- [`init16x8div`](init16x8div.md): includes the 16-bit-by-8-bit division
  routine used by `integer` division and `mod16`.
- [`init16x8mul`](init16x8mul.md): includes the 16-bit-by-8-bit
  multiplication routine used when an `integer` is multiplied by a `byte`.
- [`init8x8div`](init8x8div.md): includes the 8-bit-by-8-bit division
  routine used by plain `byte / byte`.
- [`initatan2`](initatan2.md): includes the angle table and routine used
  by `Atan2`.
- [`initBcd`](initbcd.md): includes the digit-plotting routine used by
  `BcdPrint`.
- [`initeightbitmul`](initeightbitmul.md): includes the 8-bit-by-8-bit
  multiplication routine used by plain `byte * byte`.
- [`initGetKey`](initgetkey.md): includes the keyboard-matrix scanning
  routine used by `getKey`.
- [`initJoy1`](initjoy1.md): includes the joystick port 1 reading routine
  used by `ReadJoy1`.
- [`initJoy2`](initjoy2.md): includes the joystick port 2 reading routine
  used by `ReadJoy2`.
- [`initjoystick`](initjoystick.md): includes the generic joystick-reading
  routine used by `Joystick`.
- [`InitKrill`](initkrill.md): installs Krill's loader into memory ahead
  of loading data or code from disk.
- [`initmoveto`](initmoveto.md): includes the cursor-positioning routine
  used by `MoveTo`, `PrintString`, and `Tile`.
- [`initprintdecimal`](initprintdecimal.md): includes the divide-by-10
  routine used by `PrintDecimal`.
- [`initprintstring`](initprintstring.md): includes the character-copy
  routine used by `PrintString` and `PrintNumber`.
- [`initrandom`](initrandom.md): includes the 8-bit random number
  generator used by `Rand`.
- [`initrandom256`](initrandom256.md): includes the self-modifying random
  number generator used by `Random`.
- [`InitSid`](initsid.md): calls a SID tune's own init routine to select a
  subtune and set up its player.
- [`initsinetable`](initsinetable.md): computes the 256-byte sine lookup
  table read by `sine[]`.
- [`int2ptr`](int2ptr.md): reinterprets an `integer` value as a
  `pointer`, for assigning computed addresses.
- [`IsOverlapping`](isoverlapping.md): checks whether two points are
  within a given distance of each other on both axes.
- [`IsOverlappingWH`](isoverlappingwh.md): checks whether two rectangular
  hitboxes overlap.
- [`Jammer`](jammer.md): a raster-timing watchdog that freezes the
  machine if a target raster line has already passed.
- [`Joystick`](joystick.md): reads a joystick port into the
  `joystickup`/`down`/`left`/`right`/`button` state bytes.
- [`Keypressed`](keypressed.md): reports whether one specific key is
  currently held down.
- [`KrillLoad`](krillload.md): loads a file from disk using Krill's
  fastloader.
- [`KrillLoadCompressed`](krillloadcompressed.md): loads and decompresses
  a tinycrunch-compressed file using Krill's fastloader.
- [`LeftBitShift`](leftbitshift.md): shifts (rotates) a multi-byte-wide
  strip of 8-row data one bit to the left.
- [`Lo`](lo.md): returns the low byte (bits 0-7) of a 16-bit value.
- [`Loop`](loop.md): spins forever in place, keeping the program alive
  past the end of `main`.
- [`max`](max.md): returns the larger of two `byte` values.
- [`MemCpy`](memcpy.md): copies a run of bytes from one address to
  another in a runtime loop.
- [`MemCpyFast`](memcpyfast.md): a faster variant of `MemCpy` using a
  decrementing loop.
- [`MemCpyUnroll`](memcpyunroll.md): copies a run of bytes using a
  compile-time-unrolled sequence of instructions instead of a loop.
- [`MemCpyUnrollReverse`](memcpyunrollreverse.md): like `MemCpyUnroll`,
  but copies from the last byte to the first.
- [`min`](min.md): returns the smaller of two `byte` values.
- [`mod`](mod.md): returns the remainder of dividing one `byte` value by
  another.
- [`mod16`](mod16.md): returns the remainder of dividing an `integer`
  value by a `byte` value.
- [`MoveTo`](moveto.md): positions the screen cursor used by
  `PrintString`/`PrintNumber`/`PrintDecimal`/`Tile`.
- [`NmiIRQ`](nmiirq.md): hooks the non-maskable interrupt vector to an
  `interrupt` procedure.
- [`Nop`](nop.md): inserts a compile-time-constant run of `nop`
  instructions.
- [`Peek`](peek.md): reads and returns a byte from a base address plus
  an offset.
- [`PlaySound`](playsound.md): sets up one SID voice and plays a note on
  it in a single call.
- [`Poke`](poke.md): writes a byte to a base address plus an offset.
- [`PreventIRQ`](preventirq.md): disables maskable interrupts, the same
  as `asm(" sei")`.
- [`PrintDecimal`](printdecimal.md): prints an integer as a fixed-width
  decimal number at the screen cursor.
- [`PrintNumber`](printnumber.md): prints a byte as a 2-character
  hexadecimal number at the screen cursor.
- [`PrintString`](printstring.md): prints a zero-terminated string at
  the screen cursor, with a start offset and max length.
- [`Rand`](rand.md): generates a random byte in a given range using the
  SID chip's noise generator.
- [`Random`](random.md): returns a raw random byte in the full `0`-`255`
  range, no range parameters.
- [`RasterIRQ`](rasterirq.md): hooks an `interrupt` procedure directly to
  a raster line.
- [`RasterIRQWedge`](rasterirqwedge.md): hooks an `interrupt` procedure
  to a raster line via the wedge-chaining mechanism.
- [`ReadJoy1`](readjoy1.md): reads joystick port 1 into a bitmask
  variable.
- [`ReadJoy2`](readjoy2.md): reads joystick port 2 into a bitmask
  variable.
- [`ReturnInterrupt`](returninterrupt.md): the correct way to exit an
  `interrupt` procedure early.
- [`ReturnValue`](returnvalue.md): sets a function's return value and
  exits, in one call.
- [`RightBitShift`](rightbitshift.md): shifts (rotates) a multi-byte-wide
  strip of 8-row data one bit to the right.
- [`ScreenOff`](screenoff.md): blanks the VIC-II display.
- [`ScreenOn`](screenon.md): turns the VIC-II display back on.
- [`ScrollX`](scrollx.md): sets the VIC-II's horizontal fine-scroll
  value.
- [`ScrollY`](scrolly.md): sets the VIC-II's vertical fine-scroll value.
- [`SetBank`](setbank.md): selects which 16KB region of memory the
  VIC-II reads video data from.
- [`SetBitmapMode`](setbitmapmode.md): switches the VIC-II from text
  mode into bitmap mode.
- [`SetCharsetAndScreenLocation`](setcharsetandscreenlocation.md): sets
  the character-set and screen base addresses in one combined write.
- [`SetCharsetLocation`](setcharsetlocation.md): sets the character-set
  (or bitmap data) base address.
- [`SetFrequency`](setfrequency.md): sets the coarse pitch of one SID
  sound channel.
- [`setHi`](sethi.md): writes the high byte of a `pointer`/`integer`
  variable.
- [`setLo`](setlo.md): writes the low byte of a `pointer`/`integer`
  variable.
- [`SetMemoryConfig`](setmemoryconfig.md): banks BASIC/KERNAL ROM and
  the I/O area in or out.
