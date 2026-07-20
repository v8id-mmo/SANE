# `program`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Opens every top-level `.ras`/`.pas` source file, giving the compiled
program a name. Mandatory: every source file must start with one.

## Syntax

    program <name>;

    <declarations>

    begin
        <statements>
    end.

The name is followed by a semicolon, then the rest of the file (variable/
procedure declarations, then the top-level `begin ... end.` block). Note
the trailing `.` rather than `;` on the final `end` of the program's own
block, that's what marks the end of the whole file.

## Parameters

- `<name>`: the program's name. Any valid identifier; it doesn't need to
  match the filename.

## Example

```pascal
program ProgramDemo;

begin
	screen_bg_col := black;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/program.ras){ .md-button download }

## Known limitations

The name isn't purely cosmetic: it's emitted as a real label at the very
start of the generated assembly output, so it does show up in the
compiled `.asm`/debug output. Because of this, a name that happens to
start with the word "repeat" (case-insensitive), such as `RepeatDemo`,
can be misread by an unrelated part of the assembler as the start of an
inline-assembler unrolling block, causing a confusing compile failure
that has nothing to do with the program's actual code. See
[`repend`](repend.md)'s Known limitations for the full explanation; simply
avoiding that one word as a name prefix sidesteps it entirely.
