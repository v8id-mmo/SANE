# `not`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
only complements the low byte of a `not` on an `integer`/`long`
plain-variable operand, and can't negate a whole comparison (`not (a>5)`
is a parse error; unparenthesized `not a>5` silently binds to just `a`);
SANE fixes both.

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

`not true`/`not false` used directly in an expression (not a condition,
e.g. `flag := not true;`) and `not` on a plain `byte` value (also shown
above: `not $0F` correctly gives `$F0`) work correctly.

- **In vanilla TRSE, `not` on an `integer`/`long` value only complements
  the low byte; the upper byte(s) pass straight through unchanged.** `not`
  on an `integer` holding `$00FF` should give `$FF00`, but the upper byte
  is left as `$00` and the actual result comes out `$0000`.

    :material-check-decagram:
    **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
    `not` on an `integer`/`long` plain-variable operand now correctly
    complements every byte. `not` on a more complex expression (not a
    plain variable) still only complements the low byte.
- **In vanilla TRSE, `not` can't correctly negate a whole comparison or
  condition.** Three related issues, all in the same shape: writing
  `not (a > 5)`, with the comparison in parentheses, fails to compile at
  all. Writing it without the parentheses, `not a > 5`, does compile, but
  silently means something different: it computes `not a` (a bitwise
  complement) first, and only then compares that complemented value
  against `5`, instead of negating the result of `a > 5`. For `a = 10`,
  this reads as `(not 10) > 5`, which comes out true, the opposite of the
  intended `not (10 > 5)`, which should be false. Even `not` directly on a
  bare boolean flag used as a condition (`if not someFlag then`, as in the
  example above) only gave the right answer when the flag held exactly
  `false` (`0`): any other nonzero "true" value (such as `1`) was wrongly
  still treated as true after negation, since the old implementation
  bitwise-complemented the value and re-tested the complement for
  non-zero, rather than actually inverting the truth value.

    :material-check-decagram:
    **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
    `not` now has real clause-level negation. `not (a > 5)` and the
    unparenthesized `not a > 5` both correctly negate the whole
    comparison, and `not` on a bare boolean flag, an `and`/`or`/`xor`
    combination, or any other condition used in an `if`/`while`/`until` is
    evaluated as a true logical negation instead of a bitwise complement
    plus a non-zero re-test.
