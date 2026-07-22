# `disassemble`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Marks a point in the program where, when run under the VICE emulator,
execution pauses and the VICE monitor opens showing a disassembly
starting at that address. Like [`AddBreakpoint`](addbreakpoint.md), each
call gets its own label with a matching entry in the generated VICE
symbols file, so multiple calls in the same program are each
individually addressable.

## Syntax

    disassemble();

## Parameters

None.

## Example

```pascal
program DisassembleDemo;
var
	i : byte;

begin
	clearscreen(key_space,screen_char_loc);
	i := 0;
	disassemble(); // execution pauses here in VICE's monitor, showing disassembly
	i := i + 1;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(i,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/disassemble.ras){ .md-button download }
