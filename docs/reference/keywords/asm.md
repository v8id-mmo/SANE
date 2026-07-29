# `asm`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE's assembler has no opcode-table entry for `php`/`plp`; SANE adds
both.

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

**In vanilla TRSE, the assembler's opcode table has no entry for `php`
(push processor status) or `plp` (pull processor status), unlike every
other legal 6502 mnemonic.** `asm(" php ");`/`asm(" plp ");` fail with
"Unknown opcode: php"/"Unknown opcode: plp" at the assembly stage. This
is a standing gap in vanilla TRSE's own upstream, not a fork regression.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
the opcode table now includes both mnemonics, so `php`/`plp` assemble
correctly.

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
