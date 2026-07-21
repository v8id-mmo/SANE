# `or` (Logical OR)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Combines two conditions: true if either one is true. Used inside an
`if`/`while`/`until` condition to accept more than one possibility.

## Syntax

    (<condition1> or <condition2>)

The whole combined clause needs to sit inside one pair of parentheses,
see Known limitations below.

## Parameters

- `<condition1>`, `<condition2>`: comparisons or boolean values/variables.

## Returns

True if either condition is true.

## Example

```pascal
program OrDemo;
var
	a : byte = 10;
	b : byte = 20;
	msgTrue : cstring = "AT LEAST ONE CONDITION TRUE";
	msgFalse : cstring = "NEITHER CONDITION TRUE";

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,2,hi(screen_char_loc));
	if ((a>5) or (b<3)) then
		printstring(msgTrue,0,40)
	else
		printstring(msgFalse,0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/or.ras){ .md-button download }

## Known limitations

`or` works correctly as a condition combinator, with real short-circuit
evaluation: if the left condition is already true, the right condition's
code doesn't run at all (so a right-hand side with a side effect, like a
function call, won't happen when short-circuited).

- **`or` is only usable to combine two conditions inside an `if`/
  `while`/`until` test, not as a bitwise operator on plain numeric
  values.** Writing `byteA or byteB` outside a conditional is a compile
  error that suggests using [`|`](bitwise-or.md) instead, which is the
  only way to do a bitwise OR on numbers in this language.
- **The whole combined clause needs one pair of parentheses around it,
  not one pair around each individual condition.** `if (a>5) or (b<3)
  then` (each condition separately parenthesized, no outer wrap) is a
  parse error; the working form wraps the entire combination in one more
  set of parentheses, as in the example above:
  `if ((a>5) or (b<3)) then`. Chaining three or more conditions needs
  explicit nested parentheses the same way; there's no flat,
  unparenthesized chain of `or`s.
