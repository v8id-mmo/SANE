# `@copyfile`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that copies a file within the project directory.
Useful for staging a copy of an asset before another build directive
(such as [`@addcpmheader`](addcpmheader.md)) modifies it in place, without
touching the original.

## Syntax

    @copyfile "<source>" "<destination>";

## Parameters

- `<source>`: path (relative to the project directory) of the file to
  copy. Compilation fails with an error if it doesn't exist.
- `<destination>`: path to copy it to. If a file already exists there, it
  is overwritten.

## Example

```pascal
program CopyFileDemo;

@copyfile "sample_data.bin" "sample_data_copy.bin"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/copyfile.ras){ .md-button download }
(also needs [`sample_data.bin`](../../assets/examples/sample_data.bin) in
the same folder)
