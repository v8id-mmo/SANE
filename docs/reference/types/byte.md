# `byte`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

An 8-bit unsigned value, `0` to `255`. The smallest and most commonly used
numeric type on the C64, matching the width of a single memory
location/register. Add [`signed`](../keywords/signed.md) before it for a
signed interpretation (`-128` to `127`) instead.

## Syntax

    var
        <name> : byte;
        <name> : byte = <initial value>;
        <name> : signed byte;

## Parameters

- `<name>`: the variable's identifier.
- `<initial value>`: optional, `0`-`255` (or `-128`-`127` for `signed
  byte`).

## Example

```pascal
program ByteDemo;
var
	counter : byte = 250;
	i : byte;
	total : integer;
	sb : signed byte = -1;
	widened : integer;
begin
	clearscreen(key_space,screen_char_loc);

	// Wraparound: adding past 255 wraps back to 0, ordinary 8-bit behavior
	for i:=0 to 9 do
		counter := counter + 1;
	moveto(0,0,hi(screen_char_loc));
	printstring("counter:",0,40);
	moveto(9,0,hi(screen_char_loc));
	printdecimal(counter,2);

	// Plain (unsigned) byte -> integer widening is correct
	total := counter + 1000;
	moveto(0,1,hi(screen_char_loc));
	printstring("total:",0,40);
	moveto(7,1,hi(screen_char_loc));
	printdecimal(total,4);

	// signed byte -> integer: should sign-extend to keep the negative
	// value, but zero-extends instead (known limitation, see below)
	widened := sb;
	moveto(0,2,hi(screen_char_loc));
	printstring("widened:",0,40);
	moveto(9,2,hi(screen_char_loc));
	printdecimal(widened,4);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/byte.ras){ .md-button download }

## Known limitations

**Widening a `signed byte` into a wider type (`integer`) always
zero-extends instead of sign-extending.** A negative `signed byte` should
keep its negative value when mixed into 16-bit arithmetic (`-1` becoming
`$FFFF`), but instead comes out as the small positive value its raw bit
pattern represents (`$FF` becomes `$00FF`, i.e. `255`). The example above
demonstrates this: `widened` prints `255`, not `-1`. A plain (unsigned)
`byte` widening into `integer` is unaffected, always correct, as the
`total` line above shows. See [`signed`](../keywords/signed.md)'s Known
limitations for the full cluster of related signed-arithmetic gaps this
also affects (comparison, multiplication, division, right shift).
