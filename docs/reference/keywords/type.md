# `type`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a named alias for a type expression (an array shape, a record, a
pointer, etc.) so that name can be reused in place of writing the full
type expression out again in every `var` declaration that needs it.

## Syntax

    var
      type <name> = <type expression>;

`type` declarations are written as individual lines *inside* the same
`var` block as regular variables, not as a separate top-level section,
the same way [`const`](const.md) works.

## Parameters

- `<name>`: the identifier that will stand in for the type expression from
  here on.
- `<type expression>`: anything valid on the right-hand side of a variable
  declaration's colon, most usefully `array[<size>] of <type>`.

## Example

```pascal
program TypeDemo;

var
	type TByteArray = array[4] of byte;

	scores : TByteArray;
	total : byte = 0;
	i : byte;

begin
	scores[0] := 10;
	scores[1] := 20;
	scores[2] := 30;
	scores[3] := 40;
	for i:=0 to 4 do
		total := total + scores[i];
	screen_bg_col := total;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/type.ras){ .md-button download }
