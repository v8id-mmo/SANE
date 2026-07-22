# `Inc`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Increases a variable by 1, in place. Shorthand for `x := x + 1;`.

## Syntax

    Inc( <variable> );

## Parameters

- `<variable>`: the variable to increment. Any type that supports
  addition works: `byte`, `integer`, `long`, an array element, or a
  record field.

## Example

```pascal
program IncDemo;
var
	score : byte = 0;
begin
	inc(score); // score = 1
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/inc.ras){ .md-button download }
