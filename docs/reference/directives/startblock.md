# `@startblock`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Opens a fixed-address memory region. Everything declared between
`@startblock <address> "<name>"` and [`@endblock`](endblock.md) is placed
starting at that fixed address, instead of wherever the compiler would
otherwise put it.

## Syntax

    @startblock <address> "<name>"
      <declarations / code>
    @endblock

## Parameters

- `<address>`: the fixed address to place everything in the block at
  (hex, e.g. `$f000`, or decimal).
- `<name>`: a label for the block, doesn't need to be unique.

## Example

```pascal
program StartBlockDemo;

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

[:material-download: Download this example](../../assets/examples/startblock.ras){ .md-button download }

## Known limitations

**Starting a new block before closing the previous one with `@endblock`
is not detected.** The compiler silently switches to the new block
instead of raising an error, unlike the reverse case
([`@endblock`](endblock.md) without a matching `@startblock` does fail
with a clear error). A forgotten `@endblock`, or a `@startblock` nested
inside another one, won't be flagged; it just silently changes which
fixed address everything after it gets placed at, which can be confusing
to track down if it happens by accident.
