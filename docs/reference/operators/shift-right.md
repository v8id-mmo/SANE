# `shr` / `>>` (Shift Right)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Shifts every bit in a value right by a given number of positions, filling
the vacated high bits with `0`. Each shift by one position is equivalent
to dividing by 2 and discarding the remainder, for an unsigned value.
`shr` and `>>` are the same operator, just two different spellings.

## Syntax

    <value> shr <amount>
    <value> >> <amount>

## Parameters

- `<value>`: a `byte`, `integer`, or `long` value.
- `<amount>`: how many positions to shift right by.

## Returns

The shifted value, at the same width as `<value>`.

## Example

```pascal
program ShiftRightDemo;
var
	a : byte = 80;
	result : byte;

begin
	clearscreen(key_space,screen_char_loc);
	result := a >> 2;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(result,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/shift-right.ras){ .md-button download }

## Known limitations

Shifting an **unsigned** value works correctly at every width (`byte`,
`integer`, `long`), including shifting by an amount equal to or greater
than the value's own width, which naturally saturates to `0` rather than
producing garbage.

- **`shr`/`>>` on a `signed` value is always a plain logical shift, never
  an arithmetic one.** The vacated high bits are always filled with `0`,
  the same as for an unsigned value, instead of replicating the sign bit
  the way a proper signed (arithmetic) right shift needs to. This means
  shifting a negative value right gives a wrong, positive result instead
  of preserving its sign: confirmed by compiling `signed byte x := -8; y
  := x >> 1;` and reading the generated code, which produces `124`
  instead of the mathematically correct `-4`. There's no way to get a
  correct sign-preserving right shift on a negative value using this
  operator right now; shifting an already-non-negative signed value is
  unaffected.

There's no automatic widening trick for the result the way there is for
[`+`](addition.md)/[`-`](subtraction.md)/[`*`](multiplication.md): the
shift always happens at `<value>`'s own declared width.
