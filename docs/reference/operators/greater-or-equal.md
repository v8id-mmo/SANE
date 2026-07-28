# `>=` (Greater Than or Equal)

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
didn't implement this operator at all for a signed `integer`/`long`
comparison, was wrong right at the sign boundary for `signed byte`, and
gave a wrong result comparing an unsigned byte against the literal `0`;
SANE fixes all three.

Compares two values and is true if the left-hand value is larger than, or
exactly equal to, the right-hand value. Used anywhere a condition is
expected: `if`, `while`, `until`, and similar constructs.

## Syntax

    <a> >= <b>

## Parameters

- `<a>`, `<b>`: numeric values of the same declared type (`byte`,
  `integer`, or `long`), either both unsigned or both `signed`.

## Returns

A boolean result (true or false), usable directly wherever a condition is
expected.

## Example

```pascal
program GreaterOrEqualDemo;
var
	a : byte = 10;
	b : byte = 10;
	msgTrue : cstring = "A >= B IS TRUE";
	msgFalse : cstring = "A >= B IS FALSE";

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(a,3);
	moveto(0,4,hi(screen_char_loc));
	printdecimal(b,3);
	moveto(0,6,hi(screen_char_loc));
	if (a>=b) then
		printstring(msgTrue,0,40)
	else
		printstring(msgFalse,0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/greater-or-equal.ras){ .md-button download }

## Known limitations

In vanilla TRSE, this operator works correctly for unsigned `byte`,
`integer`, and `long` values.

- **On a `signed byte`, this operator is accepted without a compile
  error, but was unverified at the extreme boundary values** (comparing
  something like `127` against `-128`): the generated code used a plain
  positive/negative flag check, without the extra overflow-correction
  step the 16-bit signed `<`/`<=` path applies, so it could give the
  wrong answer there.  
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  the byte-level path now gets the same overflow correction, so it's
  correct at every boundary too.
- **On a `signed integer`, this operator wasn't implemented at all.**
  Only `<` and `<=` were implemented for a signed 16-bit comparison;
  writing `if (signedWord >= 0) then ...` failed to compile, even though
  restructuring the condition to use `<`/`<=` instead worked.  
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  all six comparison operators now work on `signed integer`.
- **On a `signed long`, this operator wasn't implemented at all
  either**; no comparison operator worked on a signed 24-bit value.  
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  all six comparison operators now work on `signed long` too.
- **Comparing an unsigned byte against the literal `0` gave the wrong
  result.** `x >= 0` always evaluated false regardless of `x`'s actual
  value, and the same applied to a signed comparison against literal `0`.  
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  this now correctly evaluates for both unsigned and signed operands.
