# `Dec`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Decreases a variable by 1, in place. Shorthand for `x := x - 1;`.

## Syntax

    Dec( <variable> );

## Parameters

- `<variable>`: the variable to decrement. Any type that supports
  subtraction works: `byte`, `integer`, `long`, an array element, or a
  record field.

## Example

```pascal
program DecDemo;
var
	lives : byte = 3;
begin
	dec(lives); // lives = 2
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/dec.ras){ .md-button download }
