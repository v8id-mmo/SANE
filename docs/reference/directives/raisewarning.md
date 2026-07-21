# `@raisewarning`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Emits a custom compile-time warning without stopping compilation, unlike
[`@raiseerror`](raiseerror.md)/[`@error`](error.md), which abort. Meant for
flagging a questionable but non-fatal setup, such as a `@define` combination
that's technically allowed but probably not intended.

## Syntax

    @raisewarning "<message>"

## Parameters

- `<message>`: the warning text. Compilation continues normally right
  after it.

## Example

```pascal
program RaiseWarningDemo;

@raisewarning "This is a compile-time warning, not an error."

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/raisewarning.ras){ .md-button download }

## Known limitations

**When compiling from the command line, the warning message is never
actually shown anywhere.** The directive runs and compilation finishes
normally (this example does compile successfully), but the message text
itself isn't printed to the terminal, written to a log, or included in the
compiled output. It was only ever wired up to be read from the original
graphical editor's own output console, which doesn't exist in this
command-line-only fork. This is different from `@raiseerror`/`@error`,
whose abort message does still reach the console, since aborting works
through a separate mechanism. In practice, `@raisewarning` currently has
no observable effect at all when compiling via the CLI.
