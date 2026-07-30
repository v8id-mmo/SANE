# `case`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
desynced the parser on a `case` statement whose `else` branch was a single
bare statement, and separately, forcing [`onpage`](onpage.md)/
[`offpage`](offpage.md) on a `case` had no effect at all; SANE fixes both.

A multi-way branch on a single value, in classic Pascal style: evaluates
an expression once and runs the statement next to the matching value.

## Syntax

    case <expression> [onpage | offpage] of
      <value1>: <statement>;
      <value2>: <statement>;
      ...
    else
      <statement>;
    end;

The `else` branch is optional; if omitted, no branch runs when the
expression doesn't match any listed value. `onpage`/`offpage` is also
optional, forcing the compiler's choice of short relative branch vs. long
jump for the comparisons; see [`onpage`](onpage.md)/[`offpage`](offpage.md)
for what that means and their vanilla TRSE behavior on `case`.

## Example

```pascal
program CaseDemo;
var
	i : byte = 0;

begin
	for i := 0 to 3 do
	begin
		case i of
			0: screen_bg_col := black;
			1: screen_bg_col := white;
			2: screen_bg_col := red;
			3: screen_bg_col := blue;
		end;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/case.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, a `case` statement whose `else` branch is a single
statement (not wrapped in its own `begin...end`) fails to compile, but
the error doesn't point at the `case` statement itself.** It surfaces at
the very end of the file instead, as `Expected 'DOT' but found ';'` on
the line of the program's own closing `end.`:

```pascal
case i of
    0: screen_bg_col := black;
    1: screen_bg_col := white;
else
    screen_bg_col := blue;
end;
```

The cause: the compiler's `else`-branch handling never consumes the
closing `end` of the `case` statement the way its non-`else` branch does,
so the token stream shifts by one and every line after it gets
misinterpreted, right up to the file's own final `end.`.

**Workaround (needed on vanilla TRSE):** wrap the `else` block in
`begin ... end`:

```pascal
else begin
    screen_bg_col := blue;
end;
```

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
a `case` statement's `else` branch can now be a single bare statement or
a `begin ... end` block, so the workaround above is no longer necessary
on SANE.

**In vanilla TRSE, forcing `onpage` or `offpage` on a `case` statement had
no effect at all.** Both keywords parsed without error, and the forced
flag was threaded all the way through the compiler, but the one concrete
comparison routine actually generating code for it never read the flag it
was given, so the same short-branch form was emitted regardless of which
direction (or neither) was requested.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`onpage`/`offpage` now actually change the generated comparison code on a
`case` statement, the same as on `if`/`while`/`for`.
