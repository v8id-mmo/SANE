# `not`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Two related uses: negates a boolean value or condition (true becomes
false and vice versa), and bitwise-complements a numeric value (every bit
flipped).

## Syntax

    not <boolean value or variable>
    not <numeric value>

## Parameters

- A boolean literal (`true`/`false`), a boolean variable, or a numeric
  `byte` value.

## Returns

For a boolean, the opposite truth value. For a numeric `byte`, the
bitwise complement.

## Example

```pascal
program NotDemo;
var
	flag : boolean = false;
	value : byte = $0F;
	complement : byte;
	msgTrue : cstring = "FLAG IS NOT SET";
	msgFalse : cstring = "FLAG IS SET";

begin
	clearscreen(key_space,screen_char_loc);
	complement := not value;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(complement,3);
	moveto(0,4,hi(screen_char_loc));
	if not flag then
		printstring(msgTrue,0,40)
	else
		printstring(msgFalse,0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/not.ras){ .md-button download }

## Known limitations

`not true`/`not false` and `not` on a plain boolean value or variable (as
in the example above) work correctly, and so does `not` on a plain
`byte` value (also shown above: `not $0F` correctly gives `$F0`).

- **`not` on an `integer`/`long` value only complements the low byte; the
  upper byte(s) pass straight through unchanged.** `not` on an `integer`
  holding `$00FF` should give `$FF00`, but the upper byte is left as `$00`
  and the actual result comes out `$0000`. Stick to `not` on `byte`
  values, or on a plain boolean, until this is fixed.
- **`not` can't negate a comparison the way it looks like it should.**
  Writing `not (a > 5)`, with the comparison in parentheses, fails to
  compile at all. Writing it without the parentheses, `not a > 5`, does
  compile, but silently means something different: it computes `not a`
  (a bitwise complement) first, and only then compares that complemented
  value against `5`, instead of negating the result of `a > 5`. For
  `a = 10`, this reads as `(not 10) > 5`, which comes out true, the
  opposite of the intended `not (10 > 5)`, which should be false. To
  negate a comparison, restructure the condition instead of using `not`
  on it directly, for example by flipping the comparison operator
  (`a <= 5` instead of `not (a > 5)`). `not` directly on a bare boolean
  value or variable, as in the example above, is unaffected and works
  correctly.
