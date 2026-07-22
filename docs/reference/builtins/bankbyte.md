# `bankbyte`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Returns the third byte (bits 16-23, sometimes called the "bank byte") of
a wide, 24-bit-addressable value. [`Hi`](hi.md) and `Lo` are the
equivalent functions for the high and low byte of a 16-bit value (`Lo`
not yet documented on this site).

## Syntax

    <byte> = bankbyte( <pointer> )

## Parameters

- `<pointer>`: a `pointer` variable.

## Returns

The top byte of the pointer's 3-byte value.

## Example

```pascal
program BankbyteDemo;
var
	ptr : ^byte;
	bank : byte;

begin
	clearscreen(key_space,screen_char_loc);
	ptr := $c000;
	bank := bankbyte(ptr);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(bank,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/bankbyte.ras){ .md-button download }

## Known limitations

`bankbyte` works correctly on a `pointer` variable (as in the example
above), emitting a plain `lda ptr+2`.

It is a **silent no-op on a `long` variable**, this fork's other 24-bit
type. `b := bankbyte(longvar)` lowers straight to a bare store
instruction with no load before it anywhere in the routine, so `b` ends
up holding whatever was already in the accumulator at that point in the
program, not any byte of `longvar` at all. If you need the top byte of a
`long` value, read it directly instead (e.g. by declaring an overlapping
`array[3] of byte` at the same address, or via pointer arithmetic) rather
than through `bankbyte`.
