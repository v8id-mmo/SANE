# `@endassembler`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Appends a raw line of text to the very end of the generated assembly
source. The counterpart to `@startassembler`, which prepends text to the
very start. Typically used to inject assembler-specific header/footer
text (segment directives, end-of-file markers) that a particular target
assembler expects.

## Syntax

    @endassembler "<text>";

## Parameters

- `<text>`: the raw line of text to append to the end of the generated
  `.asm` file, exactly as given (no processing or validation).

## Example

```pascal
program EndAssemblerDemo;

@startassembler "; ---- start of custom header ----"
@endassembler "; ---- end of custom footer ----"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/endassembler.ras){ .md-button download }
