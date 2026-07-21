# `<` (Less Than)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Compares two values and is true if the left-hand value is smaller than the
right-hand value. Used anywhere a condition is expected: `if`, `while`,
`until`, and similar constructs.

## Syntax

    <a> < <b>

## Parameters

- `<a>`, `<b>`: numeric values of the same declared type (`byte`,
  `integer`, or `long`), either both unsigned or both `signed`.

## Returns

A boolean result (true or false), usable directly wherever a condition is
expected.

## Example

```pascal
program LessThanDemo;
var
	a : byte = 5;
	b : byte = 10;
	msgTrue : cstring = "A < B IS TRUE";
	msgFalse : cstring = "A < B IS FALSE";

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(a,3);
	moveto(0,4,hi(screen_char_loc));
	printdecimal(b,3);
	moveto(0,6,hi(screen_char_loc));
	if (a<b) then
		printstring(msgTrue,0,40)
	else
		printstring(msgFalse,0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/less-than.ras){ .md-button download }

## Known limitations

This operator works correctly for unsigned `byte`, `integer`, and
`long` values, and is one of only two comparison operators (along with
`<=`) implemented for `signed integer` values.

- **On a `signed byte`, this operator is accepted without a compile
  error, but is unverified at the extreme boundary values** (comparing
  something like `-128` against `127`): the generated code uses a plain
  positive/negative flag check, without the extra overflow-correction
  step the 16-bit signed path applies, so it may give the wrong answer
  there. A `signed byte` comparison near its type boundary shouldn't be
  trusted without testing it yourself first. Away from the extremes (as
  in the example above), it behaves correctly.
- **On a `signed long`, this operator isn't implemented at all.** Unlike
  `signed integer` (where `<` is one of the two operators that do
  work), a signed 24-bit comparison fails to compile no matter which
  operator is used, this one included.
