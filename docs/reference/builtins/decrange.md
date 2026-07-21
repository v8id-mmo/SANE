# `DecRange`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Decreases a variable by 1, wrapping it back to a chosen high value once
it reaches a chosen low value. Useful for a cyclic countdown, such as an
animation frame index that should tick backward and loop.

## Syntax

    DecRange( <variable>, <low>, <high> );

## Parameters

- `<variable>`: the `byte` variable to decrement.
- `<low>`: the value that triggers the wrap. Once `<variable>` reaches
  this value, it's immediately reset to `<high>`.
- `<high>`: the value `<variable>` wraps back to.

## Example

```pascal
program DecRangeDemo;
var
	frame : byte = 0;
begin
	// counts 9, 8, 7, ... down to 0, then wraps back to 9 and repeats
	decrange(frame, 0, 9);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/decrange.ras){ .md-button download }
