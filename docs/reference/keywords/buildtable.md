# `buildtable`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Fills an array's initializer at compile time by evaluating a JavaScript
expression once per element, instead of writing out every value by hand.
The expression is evaluated with a variable `i` set to the element's
index (starting at 0).

## Syntax

    var
      <name> : array[<count>] of <type> = buildtable("<js expression>");

## Parameters

- `<js expression>`: a JavaScript expression string, evaluated once per
  array index with `i` bound to that index. Any user-defined `const` and
  any constant whose name contains "screen" are available in the
  expression by name. The result is truncated to fit `<type>` (masked to
  8 bits for `byte`, 16 bits for `integer`/`word`, 32 bits for `long`).

## Example

```pascal
program BuildTableDemo;
var
	// Lookup table for division by 16
	lookupDiv16 : array[256] of byte = buildtable("i/16");
	i : byte = 0;

begin
	for i := 0 to 255 do
	begin
		screen_bg_col := lookupDiv16[i]&15;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/buildtable.ras){ .md-button download }
