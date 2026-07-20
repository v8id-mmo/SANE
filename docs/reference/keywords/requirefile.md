# `@requirefile`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that checks a file exists before compilation is
allowed to continue. Useful for a project that depends on an
auto-generated asset (compressed data, a converted image, and similar):
instead of failing later with a confusing "file not found" from whatever
actually reads it, this stops compilation immediately with a clear,
custom message pointing at the missing build step.

## Syntax

    @requirefile "<file>" "<message>"

## Parameters

- `<file>`: path to the file to check for, relative to the project
  directory. Compilation fails immediately if it doesn't exist.
- `<message>`: a custom message appended to the error, telling the
  developer what to do about it (e.g. which build step to run first).

## Example

```pascal
program RequireFileDemo;

@requirefile "requirefile_data.bin" "Please run the required build step before compiling this program."

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/requirefile.ras){ .md-button download }
(also needs
[`requirefile_data.bin`](../../assets/examples/requirefile_data.bin) in
the same folder)
