# `asm`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Inserts raw assembler source directly into the compiled program. Use it
when you need an instruction the language doesn't expose, or to
hand-optimize a hot loop.

## Syntax

    asm("<assembler source>");

The string is inserted into the generated `.asm` file more or less
verbatim (after resolving any TRSE variable/label names referenced inside
it). It can span multiple lines inside the same string.

## Parameters

- `<assembler source>`: one or more lines of 6502 assembler, as a string
  literal.

## Known limitations

The first column of each line is treated as a label position, not part of
the mnemonic. Indent every real instruction so it doesn't start in column
one, or it will be parsed as a label. This also means plain, unqualified
"implied" opcodes such as `dec` or `inc` (valid only on the accumulator on
later 6502 variants, not the base C64 6502) still need an explicit operand,
same as writing the same instruction directly in a `.asm` file.

## Example

```pascal
program AsmDemo;

begin
	asm("  lda #$01");
	asm("
        lda #$10
        sta $fb
mylabel dec $fb
        lda $fb
        cmp #$05
        bcs mylabel
");
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/asm.ras){ .md-button download }
