# `shl` / `<<` (Shift Left)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Shifts every bit in a value left by a given number of positions, filling
the vacated low bits with `0`. Each shift by one position is equivalent to
multiplying by 2 (as long as the result still fits in the value's declared
width). `shl` and `<<` are the same operator, just two different
spellings.

## Syntax

    <value> shl <amount>
    <value> << <amount>

## Parameters

- `<value>`: a `byte`, `integer`, or `long` value.
- `<amount>`: how many positions to shift left by.

## Returns

The shifted value, at the same width as `<value>`.

## Example

```pascal
program ShiftLeftDemo;
var
	a : byte = 5;
	result : byte;

begin
	clearscreen(key_space,screen_char_loc);
	result := a << 3;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(result,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/shift-left.ras){ .md-button download }

## Known limitations

`shl`/`<<` works the same regardless of whether the value is `signed`:
shifting left never needs to treat a signed and unsigned value
differently, since the bit pattern moves the same way either direction.

Shifting by an amount equal to or greater than the value's own width isn't
rejected or capped to a fixed maximum; it's implemented as a literal
repeated shift, so it naturally saturates to `0` after enough
repetitions, the same way real repeated shifting would. There's no
automatic widening trick for the result the way there is for
[`+`](addition.md)/[`-`](subtraction.md)/[`*`](multiplication.md): the
shift always happens at `<value>`'s own declared width. To shift a wider
result out of a narrower starting value (e.g. get a 16-bit result from
shifting a byte), declare `<value>` itself as the wider type rather than
relying on the destination variable's type.
