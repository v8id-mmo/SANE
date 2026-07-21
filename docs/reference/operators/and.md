# `and` (Logical AND)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Combines two conditions: true only if both are true. Used inside an
`if`/`while`/`until` condition to require more than one thing to hold at
once.

## Syntax

    (<condition1> and <condition2>)

The whole combined clause needs to sit inside one pair of parentheses,
see Known limitations below.

## Parameters

- `<condition1>`, `<condition2>`: comparisons or boolean values/variables.

## Returns

True only if both conditions are true.

## Example

```pascal
program AndDemo;
var
	a : byte = 10;
	b : byte = 2;
	msgTrue : cstring = "BOTH CONDITIONS TRUE";
	msgFalse : cstring = "NOT BOTH CONDITIONS TRUE";

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,2,hi(screen_char_loc));
	if ((a>5) and (b<3)) then
		printstring(msgTrue,0,40)
	else
		printstring(msgFalse,0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/and.ras){ .md-button download }

## Known limitations

`and` works correctly as a condition combinator, with real short-circuit
evaluation: if the left condition is already false, the right condition's
code doesn't run at all (so a right-hand side with a side effect, like a
function call, won't happen when short-circuited).

- **`and` is only usable to combine two conditions inside an `if`/
  `while`/`until` test, not as a bitwise operator on plain numeric
  values.** Writing `byteA and byteB` outside a conditional is a compile
  error that suggests using [`&`](bitwise-and.md) instead, which is the
  only way to do a bitwise AND on numbers in this language.
- **The whole combined clause needs one pair of parentheses around it,
  not one pair around each individual condition.** `if (a>5) and (b<3)
  then` (each condition separately parenthesized, no outer wrap) is a
  parse error; the working form wraps the entire combination in one more
  set of parentheses, as in the example above:
  `if ((a>5) and (b<3)) then`. Chaining three or more conditions needs
  explicit nested parentheses the same way, e.g.
  `((a=5) and ((b=7) and (c=255)))`; there's no flat, unparenthesized
  chain of `and`s.
