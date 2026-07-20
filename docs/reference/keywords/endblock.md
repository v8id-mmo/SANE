# `@endblock`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Closes a fixed-address memory region opened by `@startblock`. Everything
declared between `@startblock <address> "<name>"` and `@endblock` is
placed starting at that fixed address, instead of wherever the compiler
would otherwise put it.

## Syntax

    @startblock <address> "<name>"
      <declarations / code>
    @endblock

`@endblock` itself takes no argument.

## Example

```pascal
program EndBlockDemo;

// Place these variables at a fixed address
@startblock $f000 "FixedVars"

var
	fixedCounter : byte = 0;

@endblock

begin
	fixedCounter := 1;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/endblock.ras){ .md-button download }
