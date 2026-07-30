# `@raisewarning`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
never shows the warning message when compiling from the command line;
SANE fixes this, see Known limitations below.

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

**When compiling from the command line, the warning message used to never
be shown anywhere.** The directive ran and compilation finished normally
(this example does compile successfully), but the message text wasn't
printed to the terminal, written to a log, or included in the compiled
output. It was only ever wired up to be read from the original graphical
editor's own output console, which doesn't exist in this command-line-only
fork. This was different from `@raiseerror`/`@error`, whose abort message
does still reach the console, since aborting works through a separate
mechanism.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
a successful CLI compile now prints every queued warning (including
`@raisewarning`'s own message) to the terminal at the end of the compile,
the same way a failed compile's error message already reached it.
