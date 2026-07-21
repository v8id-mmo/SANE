# `@addemulatorparam`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Adds a custom command-line parameter that gets passed to the emulator when
running this project, without having to change the emulator settings
globally.

## Syntax

    @addemulatorparam "<parameter>";

## Parameters

- `<parameter>`: the raw command-line flag to add, exactly as the emulator
  expects it.

## Example

```pascal
program AddEmulatorParamDemo;

// Adds the "-nothrottle" command to the emulator's launch parameters
@addemulatorparam "-nothrottle"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/addemulatorparam.ras){ .md-button download }
