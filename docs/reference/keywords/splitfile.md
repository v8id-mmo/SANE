# `@splitfile`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that splits a binary file into two separate files
at a given byte offset. Useful for breaking a large asset into pieces
that need to be loaded or placed separately (across two memory banks, for
instance), without needing an external tool.

## Syntax

    @splitfile "<input file>" "<output file 1>" "<output file 2>" <split position>

## Parameters

- `<input file>`: path to the binary file to split.
- `<output file 1>`: path to write the first part to (bytes before the
  split position).
- `<output file 2>`: path to write the second part to (bytes from the
  split position onward).
- `<split position>`: the byte offset to split at. Must be smaller than
  the input file's size, compilation fails with an error otherwise.

## Example

```pascal
program SplitFileDemo;

@splitfile "sample_data.bin" "sample_data_part1.bin" "sample_data_part2.bin" 4

begin
	loop();
end.
```

`sample_data.bin` is 8 bytes long, so this produces a 4-byte
`sample_data_part1.bin` and a 4-byte `sample_data_part2.bin`.

[:material-download: Download this example](../../assets/examples/splitfile.ras){ .md-button download }
(also needs [`sample_data.bin`](../../assets/examples/sample_data.bin) in
the same folder)
