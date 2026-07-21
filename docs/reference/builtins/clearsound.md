# `ClearSound`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Immediately silences all three SID voices.

## Syntax

    ClearSound();

## Parameters

None.

## Example

```pascal
program ClearSoundDemo;
begin
	clearsound(); // silence all three SID voices

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/clearsound.ras){ .md-button download }

## Known limitations

It writes `0` to each voice's control register (`$D404`, `$D40B`,
`$D412`) only, clearing the gate bit to release any currently-sounding
note; it doesn't touch the volume/filter register or any voice's
frequency/waveform settings.
