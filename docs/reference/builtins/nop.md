# `Nop`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Inserts a run of `nop` (no-operation) instructions directly into the
generated assembly. The count must be known at compile time; it isn't a
runtime loop, each `nop` is a separate instruction.

## Syntax

    Nop( <count> );

## Parameters

- `<count>`: a pure, compile-time constant number of `nop` instructions
  to insert. `Nop(0)` inserts none.

## Example

```pascal
program NopDemo;
begin
	moveto(0,0,hi(screen_char_loc));
	printstring("inserting 3 nops",0,40);
	nop(3); // same as asm(" nop nop nop ");
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/nop.ras){ .md-button download }
