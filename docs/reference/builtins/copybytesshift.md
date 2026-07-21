# `CopyBytesShift`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Copies a run of bytes from one array to another, shifting or rotating
every byte by a fixed number of bits along the way.

## Syntax

    CopyBytesShift( <source>, <destination>, <count>, <shift amount>, <mode> );

## Parameters

- `<source>`: the array/address to copy from.
- `<destination>`: the array/address to copy to.
- `<count>`: how many bytes to process.
- `<shift amount>`: how many times to shift/rotate each byte.
- `<mode>`: a compile-time constant, `0`-`3`:
    - `0`: shift left (`asl`, fills with `0`)
    - `1`: shift right (`lsr`, fills with `0`)
    - `2`: rotate left (bit that falls off the top wraps to the bottom)
    - `3`: rotate right (see Known limitations, this one doesn't actually
      rotate)

## Example

```pascal
program CopyBytesShiftDemo;
var
	src : array[4] of byte = (1, 2, 64, 255);
	dst : array[4] of byte;
	i : byte;

begin
	copybytesshift(#src, #dst, 4, 1, 0); // shift all 4 bytes left by 1 bit (mode 0 = asl)

	moveto(0, 0, hi(screen_char_loc));
	for i := 0 to 3 do
	begin
		moveto(0, i, hi(screen_char_loc));
		printdecimal(dst[i], 3);
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/copybytesshift.ras){ .md-button download }

## Known limitations

Modes `0` (shift left), `1` (shift right), and `2` (rotate left) all work
correctly, including for a shift amount greater than one: rotating
`%10000001` left by 3 correctly produces `%00001100` (`$0C`), the true
circular-rotate result.

**Mode `3` (documented as "rotate right") never actually rotates: it
silently behaves exactly like mode `1` (plain logical shift right) at
every shift amount, including `1`.** The bit that falls off the bottom is
simply discarded and `0` is always shifted in from the top, the same as
mode `1`. Rotating `%10000001` right by one should give `%11000000`
(`$C0`); this mode instead gives `%01000000` (`$40`), the plain-shift
result. If you need a true rotate-right, rotate left by
`8 - <shift amount>` using mode `2` instead, or shift a copy of each byte
manually.
