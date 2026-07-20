# `@bin2inc`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that converts a binary file into a TRSE source file
declaring a byte array with the same contents, so raw binary data (a
sprite sheet, a compressed asset, etc.) can be brought into a program as an
ordinary array via `@include`.

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

`@bin2inc`'s output file cannot be `@include`d in the *same* compile that
generates it. Confirmed by testing: on a clean build, `@include "<output
file>"` fails with "Could not open file for inclusion", because the
include-resolution pass reads from disk before `@bin2inc` has written the
file (`Parser::PreprocessIncludeFiles`'s file lookup runs independently of
`Parser::PreprocessSingle`'s handling of `@bin2inc`, and does not see its
in-memory result). Generate the include file with one project first
(`@bin2inc` alone, as in the example above), then `@include` it from a
separate `.ras`/`.tru` file, or check the generated file into the project
ahead of time.
