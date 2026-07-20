# `volatile`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A variable declaration modifier that stops the post-optimizer from
removing or merging accesses to that variable. Needed for a variable that
changes outside the compiler's view of normal program flow, such as one
written by an [`interrupt`](interrupt.md) handler and read from the main
loop: without it, the optimizer can see a load as redundant (because
nothing in the visible code path between two reads changed it) and strip
it, even though the value could have changed via the interrupt in the
meantime.

## Syntax

    var
        <name> : volatile <type>;

The modifier goes before the base type in the declaration, the same
position as [`signed`](signed.md).

## Parameters

- `<type>`: the base type being marked volatile.

## Example

```pascal
program VolatileDemo;
var
	frameCounter : volatile byte = 0;

interrupt UpdateFrame();
begin
	frameCounter := frameCounter + 1;
end;

begin
	screen_bg_col := frameCounter;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/volatile.ras){ .md-button download }
