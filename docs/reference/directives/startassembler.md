# `@startassembler`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Prepends a raw line of text to the very start of the generated assembly
source. The counterpart to [`@endassembler`](endassembler.md), which
appends text to the very end. Typically used to inject assembler-specific
header text (segment directives, origin markers) that a particular target
assembler expects.

## Syntax

    @startassembler "<text>";

## Parameters

- `<text>`: the raw line of text to prepend to the start of the generated
  `.asm` file, exactly as given (no processing or validation).

## Example

```pascal
program StartAssemblerDemo;

@startassembler "; ---- start of custom header ----"
@endassembler "; ---- end of custom footer ----"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/startassembler.ras){ .md-button download }

## Known limitations

Only one `@startassembler` per compile has any effect: if it appears more
than once in a project, only the last one that gets processed wins,
rather than accumulating multiple lines. The same applies to
[`@endassembler`](endassembler.md).
