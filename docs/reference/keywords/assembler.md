# `assembler`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A procedure modifier that marks the whole procedure body as hand-written
assembler, instead of a normal `begin ... end` block of TRSE statements.
It's a shortcut for writing a procedure that is nothing but a raw
[`asm`](asm.md) block, without the outer `begin`/`end`.

## Syntax

    procedure <name>(); assembler;
    asm("<assembler source>");

## Parameters

None beyond the procedure's own declaration; `assembler` itself takes no
argument.

## Known limitations

An `assembler` procedure does not get the compiler's automatic
`end_procedure_<name>` epilogue label that normal procedures get
(confirmed in `abstractcodegen.cpp`), since the assembler body is expected
to manage its own control flow (typically ending in `rts`). Writing a
procedure body that falls through without an explicit `rts` will fall
through into whatever code follows it in memory.

## Example

```pascal
program AssemblerDemo;

procedure SetBorderBlack(); assembler;
asm("
        lda #$00
        sta $d020
        rts
");

begin
	SetBorderBlack();
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/assembler.ras){ .md-button download }
