# `case`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A multi-way branch on a single value, in classic Pascal style: evaluates
an expression once and runs the statement next to the matching value.

## Syntax

    case <expression> of
      <value1>: <statement>;
      <value2>: <statement>;
      ...
    else
      <statement>;
    end;

The `else` branch is optional; if omitted, no branch runs when the
expression doesn't match any listed value.

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

**A `case` statement whose `else` branch is a single statement (not
wrapped in its own `begin...end`) fails to compile, but the error doesn't
point at the `case` statement itself.** It surfaces at the very end of
the file instead, as `Expected 'DOT' but found ';'` on the line of the
program's own closing `end.`. Confirmed reproducible:

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

**Confirmed workaround:** wrap the `else` block in `begin ... end`:

```pascal
else begin
    screen_bg_col := blue;
end;
```

This avoids the bug because the block is no longer a single bare
statement. The example on this page sidesteps the issue entirely by using
an explicit branch for every tested value instead of `else`, since that
form is confirmed working.
