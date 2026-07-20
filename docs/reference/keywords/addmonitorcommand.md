# `@addmonitorcommand`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Adds a VICE monitor command that runs automatically once the program is
loaded in the emulator. Useful for scripting emulator behavior on run,
such as automatically saving memory to a file and quitting, which is how
this fork's own `units/global/unittests/` test suite reports its results
(see `Publish/tutorials/C64/UnitTests/unittests.ras`).

## Syntax

    @addmonitorcommand "<vice monitor command>";

## Parameters

- `<vice monitor command>`: a command in VICE's own monitor syntax.

## Example

```pascal
program AddMonitorCommandDemo;

@addmonitorcommand "print \"hello from the vice monitor\""

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/addmonitorcommand.ras){ .md-button download }
