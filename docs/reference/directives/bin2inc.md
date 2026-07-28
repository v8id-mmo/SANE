# `@bin2inc`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
can't `@include` `@bin2inc`'s own output in the same compile that
generates it; SANE fixes this, see Known limitations below.

A build-time directive that converts a binary file into a TRSE source file
declaring a byte array with the same contents, so raw binary data (a
sprite sheet, a compressed asset, etc.) can be brought into a program as an
ordinary array via [`@include`](include.md).

## Syntax

    @bin2inc "<input file>" "<output file>" <array name>;

## Parameters

- `<input file>`: path to the binary file to convert.
- `<output file>`: path to write the generated TRSE source to.
- `<array name>`: the identifier the generated `var ... : array[...] of
  byte = (...)` declaration will use.

## Example

```pascal
program Bin2IncDemo;

@bin2inc "sample_data.bin" "sample_data.inc" mySampleData

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/bin2inc.ras){ .md-button download }
(also needs [`sample_data.bin`](../../assets/examples/sample_data.bin) in
the same folder)

## Known limitations

**In vanilla TRSE, `@bin2inc`'s output file cannot be [`@include`](include.md)d
in the *same* compile that generates it.** On a clean build, `@include
"<output file>"` fails with "Could not open file for inclusion", even
though `@bin2inc` appears earlier in the same file. The workaround is to
generate the include file with one project first (`@bin2inc` alone, as in
the example above), then `@include` it from a separate `.ras`/`.tru` file,
or check the generated file into the project ahead of time. :material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`@bin2inc` and `@include` can now appear in the same compile that
generates the included file; the workaround is no longer needed.
