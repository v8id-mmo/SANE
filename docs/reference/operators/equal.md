# `=` (Equal)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Compares two values and is true if they're exactly equal. Used anywhere a
condition is expected: `if`, `while`, `until`, `case`, and similar
constructs.

## Syntax

    <a> = <b>

## Parameters

- `<a>`, `<b>`: numeric values of the same declared type (`byte`,
  `integer`, or `long`), either both unsigned or both `signed`.

## Returns

A boolean result (true or false), usable directly wherever a condition is
expected.

## Example

```pascal
program EqualDemo;
var
	a : byte = 7;
	b : byte = 7;
	msgTrue : cstring = "A = B IS TRUE";
	msgFalse : cstring = "A = B IS FALSE";

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(a,3);
	moveto(0,4,hi(screen_char_loc));
	printdecimal(b,3);
	moveto(0,6,hi(screen_char_loc));
	if (a=b) then
		printstring(msgTrue,0,40)
	else
		printstring(msgFalse,0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/equal.ras){ .md-button download }

## Known limitations

This operator works correctly for unsigned `byte`, `integer`, and
`long` values. Unlike the ordering operators (`<`, `<=`, `>`, `>=`), it
also works correctly on a **`signed byte`** at every value, including
right at the `-128`/`127` boundary: equality only cares whether two bit
patterns match, not how the sign bit is interpreted, so it isn't affected
by the boundary-value risk that applies to signed byte ordering
comparisons.

- **On a `signed integer` or `signed long`, this operator isn't
  implemented, for the same reason the ordering operators (other than
  `<`/`<=`) aren't: the compiler currently only allows `<`/`<=` on a
  signed 16-bit value, and nothing at all on a signed 24-bit value.**
  Writing `if (signedWord = 0) then ...` fails to compile even though
  equality doesn't inherently need any sign-aware logic; this is a gap in
  what's currently wired up rather than a fundamental limitation of the
  operator itself.
