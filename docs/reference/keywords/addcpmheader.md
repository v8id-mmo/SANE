# `@addcpmheader`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that prepends a 2-byte length header to a binary
file on disk: low byte `size & 127`, high byte `size / 128`. This is the
header format some CP/M-derived loaders expect before the actual file
data.

## Syntax

    @addcpmheader "<file>";

`<file>` is modified in place: its previous contents are read, the 2-byte
header is inserted at the very start, and the file is rewritten.

## Parameters

- `<file>`: path (relative to the project directory) of the binary file to
  add the header to.

## Example

```pascal
program AddCpmHeaderDemo;

@copyfile "sample_data.bin" "sample_data_hdr.bin"
@addcpmheader "sample_data_hdr.bin"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/addcpmheader.ras){ .md-button download }
(also needs [`sample_data.bin`](../../assets/examples/sample_data.bin) in
the same folder)
