# `Call`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Calls a machine-code routine at a given address and returns to the next
statement once it executes an `rts`. Unlike calling a TRSE-declared
`procedure`, this is for jumping into a raw address, such as a fixed
KERNAL routine or a routine reached through a function pointer.

## Syntax

    Call( <address> );

## Parameters

- `<address>`: the routine to call. A named `address` constant or a
  `pointer` variable (see Known limitations for why a bare numeric
  literal doesn't work here).

## Example

```pascal
program CallDemo;
var
	udtimPtr : ^byte;
	const udtim : address = $ffea; // KERNAL UDTIM: bumps the jiffy clock, then RTS

begin
	screen_bg_col := blue;

	call(udtim); // direct call to a fixed address

	udtimPtr := $ffea;
	call(udtimPtr); // same routine, called indirectly through a pointer

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/call.ras){ .md-button download }

## Known limitations

**A bare numeric literal address passed directly to `Call` fails to
assemble.** `call($ffea);` emits `jsr #$ffea`, an invalid instruction
(`jsr` doesn't have an immediate addressing mode), and the build fails at
the assembly stage with an "opcode type not implemented" error rather
than a clear compiler diagnostic. Wrap the literal in a named `address`
constant first (as in the example above) to work around this.
