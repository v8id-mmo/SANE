# `Loop`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

An infinite loop that does nothing but keep spinning at the same
instruction. The standard way to end a C64 program's `begin...end.` block:
without it, execution would fall off the end of `main` into whatever
memory follows, usually crashing or resetting the machine.

## Syntax

    Loop();

## Parameters

None.

## Example

```pascal
program LoopDemo;
begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring("hello, sane!",0,40);

	loop(); // spins in place forever, keeping the program alive
end.
```

[:material-download: Download this example](../../assets/examples/loop.ras){ .md-button download }
