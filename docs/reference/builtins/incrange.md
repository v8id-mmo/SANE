# `IncRange`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Increases a variable by 1, wrapping it back to a chosen low value once it
reaches a chosen high value. Useful for a cyclic counter, such as an
animation frame index that should tick forward and loop. `DecRange` is
the counterpart that counts down instead.

## Syntax

    IncRange( <variable>, <low>, <high> );

## Parameters

- `<variable>`: the `byte` variable to increment.
- `<low>`: the value `<variable>` wraps back to.
- `<high>`: the value that triggers the wrap. Once `<variable>` reaches
  this value, it's immediately reset to `<low>`.

## Example

```pascal
program IncRangeDemo;
var
	frame : byte = 0;
begin
	// counts 0, 1, 2, ... up to 9, then wraps back to 0 and repeats
	incrange(frame, 0, 9);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/incrange.ras){ .md-button download }
