# `ToggleBit`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE's constant-bit-index fast path falls through into the general path
too, doubling the generated code and work; SANE's stops once the fast
path is done.

Sets or clears a single bit of a `byte` variable, in place.

## Syntax

    ToggleBit( <variable>, <bit index>, <state> );

## Parameters

- `<variable>`: the `byte` variable to modify.
- `<bit index>`: which bit to change, `0` (least significant) through
  `7` (most significant). Can be a constant or a variable/expression.
- `<state>`: `1` to set the bit, `0` to clear it. Must be a compile-time
  constant, not a variable or expression.

## Example

```pascal
program ToggleBitDemo;
var
	flags : byte = %00000000;
	idx : byte = 3;
begin
	clearscreen(key_space,screen_char_loc);

	togglebit(flags,2,1); // constant bit index: turn bit 2 on
	moveto(0,0,hi(screen_char_loc));
	printdecimal(flags,3); // 4

	togglebit(flags,idx,1); // variable bit index: turn bit 3 on too
	moveto(0,1,hi(screen_char_loc));
	printdecimal(flags,3); // 12

	togglebit(flags,2,0); // constant bit index: turn bit 2 back off
	moveto(0,2,hi(screen_char_loc));
	printdecimal(flags,3); // 8

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/togglebit.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, a constant `<bit index>` produces double the code and
double the work.** Whenever `<bit index>` is a compile-time constant, the
compiler generates a fast, direct version of the set/clear (a single
`and`/`or` against a fixed bitmask), but there also generates the full
variable-index version right after it, which recomputes the same bitmask
at runtime and applies the same set/clear a second time. The end result
is still correct, since setting or clearing the same bit twice in a row
has no further effect, but every call with a literal bit index (like
`togglebit(flags,2,1)` above) assembles and runs both versions back to
back there, roughly doubling this builtin's code size and execution time
for no benefit. [`GetBit`](getbit.md), which shares the same constant/
variable split, does not have this problem.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
the constant-bit-index fast path now stops once it's done, instead of
also falling through into the general path; a call like
`togglebit(flags,2,1)` now assembles and runs only the fast version.
