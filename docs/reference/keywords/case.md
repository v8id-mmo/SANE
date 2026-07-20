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
