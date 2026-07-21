# `AddBreakpoint`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Inserts a debugger breakpoint at the point in the program where it's
called. When the compiled program is run under the VICE emulator, hitting
this point halts execution and drops into the VICE monitor, so registers,
memory, and the disassembly can be inspected right there. Each call gets
its own unique label, with a matching `break <address>` line in the
generated VICE symbols file, so multiple breakpoints in the same program
are each individually addressable.

## Syntax

    AddBreakpoint();

## Parameters

None.

## Example

```pascal
program AddBreakpointDemo;
var
	i : byte;

begin
	clearscreen(key_space,screen_char_loc);
	i := 0;
	AddBreakpoint(); // execution halts here in VICE, dropping into the monitor
	i := i + 1;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(i,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/addbreakpoint.ras){ .md-button download }
