# Builtin function parameters

Most builtins validate their arguments quite strictly: a parameter often
has to be a plain variable, a compile-time constant, or a specific kind
of reference, rather than a general expression. These errors are grouped
by the kind of builtin that raises them. The fix is almost always the
same shape: simplify the argument to whatever specific form (variable,
constant number, address, procedure reference) the message asks for.

## Memory & data

### `First parameter must be variable or number`

Raised by `MemCpy`, `MemSet`, and several other memory/data builtins when
their first parameter isn't a variable, address, or numeric constant.
Pass a declared variable or a literal number.

### `Second parameter must be pure numeric` / `second parameter must be variable or number` / `Second parameter must be variable or number`

Raised by `MemCpy`-family and BCD builtins when the offset/count/second
argument isn't pure (a constant or plain variable). Simplify the
argument.

### `Third parameter must be pure numeric`

Raised by a `MemCpy`-family builtin when its third parameter (typically
a count) isn't pure. Simplify the argument.

### `When the source data is a pointer, you cannot use an offset. Please set the second parameter to '0'.`

`MemCpy`'s source is a pointer, but a nonzero offset was also given.
Pointers already carry their own address; set the offset parameter to
`0` when copying from a pointer.

### `Error: memcpy cannot take an integer as count, must be byte.`

`MemCpy`'s count parameter is a 16-bit (`integer`) value. Use a `byte`
count instead (this limits a single `MemCpy` call to 255 bytes; split
larger copies into multiple calls).

### `Parameter <n> must be a variable or address`

Raised by an internal helper shared by several builtins (used when
saving a computed value somewhere) when the given parameter isn't a
variable or numeric address. Pass a declared variable, or a literal
address.

### `Parameter 0 must be variable (array)`

Raised by a sprite/tile transform builtin when its first parameter isn't
a variable. Pass the array variable directly.

### `Parameter 1 must be address`

Raised by the same builtin when its second parameter isn't a numeric
address. Pass a literal/constant address.

### `Swap error: both parameters must be variables`

`Swap(a, b)` was called with at least one argument that isn't a plain
variable. Pass two declared variables.

### `Min/max : parameter 1 must be variable or constant`

`Min`/`Max`'s second parameter isn't pure. Pass a variable or a
constant number.

### `Parameter 0 is required to be a pure address` / `Parameter 1 is required to be a pure address` / `Parameter 2 is required to be a pure variable or constant`

Raised by `StrSplit` when its arguments don't match the expected shape
for each position (the first two need to be addresses, the third a
variable or constant).

### `Nop() requires a pure numeric value.`

`Nop(n)`'s argument isn't a constant or plain numeric variable. Pass a
literal number of cycles/NOPs to insert.

### `Decrunch : parameter 0 must be an incbin block or address!` / `Decrunch : parameter 0 must be a pointer to a IncBin block or address!`

`Decrunch`'s first parameter isn't a variable, or isn't an `incbin`-typed
variable/address. Pass an `incbin` variable (or its address) holding the
compressed data.

## Graphics & screen setup

### `SetBitmapLocation parameter must be an address!` / `SetBitmapLocation parameter must be one of the following values: $0000,$2000,$4000,$8000,$A000, $C000, $E000`

`SetBitmapLocation`'s parameter must be a literal address, and must be
one of the listed valid bitmap bank offsets. Use one of the values
listed in the message.

### `SetCharsetLocation parameter must be an address!` / `SetCharsetLocation parameter must be one of the following values: $0000,$0800,$1000,$1800,$2000, $2800, $3000 or $3800` / `SetCharsetLocation parameter must be one of the following values: $8000, $8400, $8800,$8C00, $1000, $1400, $1800, $1C00`

`SetCharsetLocation`'s parameter must be a literal address, and one of
the valid charset offsets for the current VIC bank (the second list
applies on VIC-20, not reachable on this fork's C64-only target but
present in the shared codegen).

### `SetCharsetAndScreenLocation parameter 1 and 2 must be an address` / `SetCharsetAndScreenLocation parameter must have both parameters set to valid addresses. For the screen location, every $400 byte on the current vic bank, ie $400, $800, $1C00 etc. For the charset location, every $800 byte on the current VIC bank, i.e. $0, $800,$1000 etc.` / `SetCharsetAndScreenLocation parameter must be one of the following values: $0000,$0400,$0800,$0C00.. repeating every $1000 bytes`

`SetCharsetAndScreenLocation` needs both parameters to be literal
addresses, at the valid multiples of `$400` (screen) and `$800`
(charset) within the current VIC bank.

### `SetScreenLocation parameter must be an address!` / `SetScreenLocation parameter must be one of the following values: $0000,$0400,$0800,$0C00.. repeating every $1000 bytes` / `SetScreenLocation parameter must be one of the following values: $8000, $8400, $8800,$8C00, $1000, $1400, $1800, $1C00`

`SetScreenLocation`'s parameter must be a literal address at a valid
`$400`-aligned screen offset within the current VIC bank (the second
value list is the VIC-20 equivalent).

### `ClearScreen does currently not support pointers.` / `ClearScreen address must be pure numeric or a variable, and not an expression.`

`ClearScreen`'s address parameter must be a plain number or variable,
not a pointer and not a computed expression.

### `ClearBitmap: both parameters must be integer constants`

`ClearBitmap`'s two parameters (start page and page count) must both be
pure numeric/address values.

### `FillFast parameter 2 must be pure numeric/variable!`

`FillFast`'s second parameter isn't pure. Pass a constant or plain
variable.

### `PokeScreenColor: last parameter required to be pure constant number`

`PokeScreenColor`'s final parameter must be a compile-time constant
number.

### `CopyImageColorData : parameter 0 must be a variable or address` / `CopyImageColorData : parameter 1 must be a constant number!`

`CopyImageColorData`'s first parameter must resolve to a variable or
constant address, and its second (VIC bank) parameter must be a
constant number.

### `CopyHalfScreen : parameter 3 must be a constant number!` / `CopyHalfScreen : parameter 4 must be a constant number!` / `CopyHalfScreen : parameter 5 must be a constant number!`

`CopyHalfScreen`'s line-count, inverted, and invertedx parameters must
all be compile-time constants.

### `Tile number can only be a variable or number.`

The `Tile(...)` builtin's tile-index parameter isn't pure. Pass a
constant or plain variable.

### `TogglesBit (for now) needs param 3 to be a number`

A sprite multicolor/toggle-bit builtin's third parameter must be a
compile-time constant.

### `SetSpriteLoc parameter 2 (bank) must be constant 0-3`

`SetSpriteLoc`'s bank parameter must be a constant number, and (per the
message) should be in the 0-3 range for a valid VIC bank.

### `FLD: last parameter required to be pure constant number (0 or 1)`

The C64 `FLD` (flicker/flash) builtin's last parameter must be a
constant `0` or `1`.

### `Please declare <init method>() before using <method>();`

A builtin that depends on a prior setup call (for example, a sprite or
VBM helper) was used before its matching `Init...()` builtin. Add the
required initialization call earlier in the program.

## Sound & hardware registers

### `First value must be constant - addresses chip`

Raised by SID/chip-addressing builtins when their first parameter isn't
a compile-time constant. Pass a literal number.

### `InitSid currently only supports constant values`

`InitSid(...)`'s parameter isn't a constant. Pass a literal number.

### `Call currently only supports constant 0/1 (on/off)`

A hardware-toggle builtin ("Call") wasn't given a constant `0` or `1`.
Pass one of those two literal values.

### `Joystick requires numeric parameter : 1 or 2 (for port 1 or 2)`

`Joystick(n)`'s port argument isn't the constant `1` or `2`. Pass one of
those two values for the desired joystick port.

### `KeyPressed requires key to be numeric! KEY_A etc`

`KeyPressed(...)`'s argument isn't a numeric literal/constant. Pass one
of the `KEY_*` constants.

### `KeyPressed: does not recognize character <n>`

`KeyPressed(...)` was given a numeric key code that isn't in the known
key table. Use one of the documented `KEY_*` constants instead of a raw
number.

### `Error! Kernal wedge not implemented. Nag the developer (leuat).`

A raster-IRQ "kernal wedge" chaining code path was reached that isn't
implemented yet. There's no user-side fix; avoid the specific
interrupt-chaining feature that triggers this path.

## Interrupts

### `First parameter must be interrupt procedure!`

Raised by interrupt-setup builtins (raster IRQ, VIA IRQ, and similar)
when the first parameter isn't a reference to a procedure. Pass the
procedure's bare name, and make sure it's declared as an interrupt
handler.

### `ScrollX requires temp_zeropages to be configured in the project settings.` / `ScrollY requires temp_zeropages to be configured in the project settings.` / `SetBank requires temp_zeropages to be configured in the project settings.`

These builtins need spare zero-page bytes to work with, configured under
`temp_zeropages` in the project settings. Add at least one temp
zero-page address to the project's settings file.

## BCD arithmetic

### `BCD: last parameter, number of digits, required to be pure constant number`

A BCD add/subtract/compare/print builtin's digit-count parameter must be
a compile-time constant.

### `BCD: last parameter, number of digits, must be greater than 0 but less than 255`

The BCD digit-count parameter is outside the valid range. Use a value
from 1 to 254.

## PETSCII & address tables

### `First parameter must be variable containing address table` / `Second parameter must be variable containing array of petscii values`

Raised by a PETSCII/screen-table builtin when its first (address table)
or second (PETSCII values) parameter isn't a declared array variable.

### `First parameter must be variable containing screen address table` / `Second parameter must be variable containing color address table` / `Third parameter must be variable containing array of petscii values`

Raised by a related multi-line PETSCII/screen builtin for the same
reason, one message per parameter position.

## Zero-page pointers & deprecations

### `IncZp: Left-hand parameter must be zeropage pointer` / `DecZp: Left-hand parameter must be zeropage pointer`

`IncZp`/`DecZp`'s target isn't a `pointer`-typed variable. Pass a
declared zero-page pointer variable.

### `Pointer must be pure variable`

A pointer-dereference builtin's target isn't a plain variable. Pass a
declared pointer variable directly.

### `incscreenx is deprecated. Please use inczp(screenmemory, val) instead`

The old `IncScreenX` builtin was called. Replace it with
`IncZp(screenmemory, val)`.

### `'ProcedureToPointer' has been deprecated. Please simply use the address of the procedure ('pointer := #myProcedure;') instead.`

The old `ProcedureToPointer` builtin was called. Replace it with a
direct pointer assignment: `pointer := #myProcedure;`.

### `When loading a file, first parameter must point to a zero-terminated string`

A file-loading builtin's filename parameter isn't a variable. Pass a
`string`/`cstring` variable holding the filename.

### `Width / height of 2d table cannot be zero.`

A 2D table-building call (used by `BuildTable2D` and similar) was given
a `0` for either dimension. Use a positive width and height.

### `BuildTable must have at least 1 element in array.`

`BuildTable`/`BuildSineTable` was asked to fill zero elements. Use an
array with at least one element.

### `Error evaluation javascript expression : <message>`

An embedded expression used by `BuildTable`, `BuildSineTable`, the 2D
table builder, or macro expansion failed to evaluate. Check the
expression's syntax; it uses a small embedded scripting expression
language, not full TRSE syntax.

### `Parameter 2 (layer 1/2) must be 1 or 2`

A VERA-layer builtin's layer parameter isn't the constant `1` or `2`, or
isn't pure numeric (X16-only builtin, not reachable on this fork's C64
target, but present in the shared codegen).
