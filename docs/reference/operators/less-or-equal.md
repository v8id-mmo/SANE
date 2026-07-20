# `<=` (Less Than or Equal)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Compares two values and is true if the left-hand value is smaller than, or
exactly equal to, the right-hand value. Used anywhere a condition is
expected: `if`, `while`, `until`, and similar constructs.

## Syntax

    <a> <= <b>

## Parameters

- `<a>`, `<b>`: numeric values of the same declared type (`byte`,
  `word`/`integer`, or `long`), either both unsigned or both `signed`.

## Returns

A boolean result (true or false), usable directly wherever a condition is
expected.

## Example

```pascal
program LessOrEqualDemo;
var
	a : byte = 10;
	b : byte = 10;
	msgTrue : cstring = "A <= B IS TRUE";
	msgFalse : cstring = "A <= B IS FALSE";

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(a,3);
	moveto(0,4,hi(screen_char_loc));
	printdecimal(b,3);
	moveto(0,6,hi(screen_char_loc));
	if (a<=b) then
		printstring(msgTrue,0,40)
	else
		printstring(msgFalse,0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/less-or-equal.ras){ .md-button download }

## Known limitations

This operator works correctly for unsigned `byte`, `word`/`integer`, and
`long` values, and is one of only two comparison operators (along with
`<`) implemented for `signed word`/`integer` values.

- **On a `signed byte`, this operator is accepted without a compile
  error, but is suspected to give the wrong answer right at the extreme
  boundary values** (comparing something like `-128` against `127`). The
  generated code for a signed byte comparison uses a plain positive/
  negative flag check, without the extra overflow-correction step the
  16-bit signed path applies. This hasn't been confirmed by actually
  running it, only by reading the generated code, but it's a real enough
  risk that a `signed byte` comparison near its type boundary shouldn't be
  trusted without testing it yourself first. Away from the extremes (as in
  the example above), it behaves correctly.
- **On a `signed long`, this operator isn't implemented at all.** Unlike
  `signed word`/`integer` (where `<=` is one of the two operators that do
  work), a signed 24-bit comparison fails to compile no matter which
  operator is used, this one included.
