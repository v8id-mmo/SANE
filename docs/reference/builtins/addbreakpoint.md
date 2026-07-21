# `AddBreakpoint`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Inserts a debugger breakpoint at the point in the program where it's
called. When the compiled program is run under the VICE emulator, hitting
this point halts execution and drops into the VICE monitor, so registers,
memory, and the disassembly can be inspected right there.

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

## Known limitations

None found. Confirmed working end-to-end by compiling and inspecting the
generated VICE symbols file: each `AddBreakpoint()` call gets its own
unique label in the compiled program, and the compiler emits a matching
`break <address>` line for it in the `.sym` file passed to VICE, so the
breakpoint is real and address-accurate, not just a compiled-in no-op.
