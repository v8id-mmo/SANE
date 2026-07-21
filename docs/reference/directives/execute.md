# `@execute`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that runs an external command-line program and
waits for it to finish, before compilation continues. Useful for invoking
an external asset-conversion tool, packer, or script as part of the build.

## Syntax

    @execute "<program>" "<arguments>"

## Parameters

- `<program>`: path to the executable to run. If it isn't an absolute or
  relative path (no `/` in it), it's resolved the same way a shell would
  resolve a bare command name, via the `PATH` environment variable.
- `<arguments>`: a single string containing all arguments, separated by
  plain spaces (no quoting support for arguments that themselves contain
  spaces).

The program's standard output and standard error are captured but not
shown anywhere in the compiler's own output; there's no way to see it from
a normal build. A non-zero exit code from the program does not fail the
TRSE compile either, compilation just continues.

## Example

```pascal
program ExecuteDemo;

@execute "/bin/echo" "hello from execute"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/execute.ras){ .md-button download }
