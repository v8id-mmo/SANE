# `Call`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
fails to assemble a bare numeric literal address; SANE fixes it (see
Known limitations below).

Calls a machine-code routine at a given address and returns to the next
statement once it executes an `rts`. Unlike calling a TRSE-declared
`procedure`, this is for jumping into a raw address, such as a fixed
KERNAL routine or a routine reached through a function pointer.

## Syntax

    Call( <address> );

## Parameters

- `<address>`: the routine to call. A named `address` constant, a
  `pointer` variable, or a bare numeric literal (see Known limitations)
  all work.

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

**A bare numeric literal address passed directly to `Call` used to fail
to assemble.** `call($ffea);` emitted `jsr #$ffea`, an invalid instruction
(`jsr` doesn't have an immediate addressing mode), and the build failed at
the assembly stage with an "opcode type not implemented" error rather
than a clear compiler diagnostic. Wrapping the literal in a named
`address` constant first (as in the example above) was the workaround.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
a bare numeric literal address now assembles correctly too, emitting the
same `jsr $ffea` form a named constant always did.
