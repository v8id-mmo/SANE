# `@deletefile`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that deletes a file within the project directory,
if it exists.

## Syntax

    @deletefile "<file>";

## Parameters

- `<file>`: path (relative to the project directory) of the file to
  delete. Unlike [`@copyfile`](copyfile.md), it is **not** an error if the
  file doesn't exist: `@deletefile` silently does nothing in that case.

## Example

```pascal
program DeleteFileDemo;

@copyfile "sample_data.bin" "sample_data_temp.bin"
@deletefile "sample_data_temp.bin"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/deletefile.ras){ .md-button download }
(also needs [`sample_data.bin`](../../assets/examples/sample_data.bin) in
the same folder)
