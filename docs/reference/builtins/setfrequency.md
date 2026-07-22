# `SetFrequency`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Sets the coarse pitch of one SID sound channel, for updating a note's
frequency after it's already been started with
[`PlaySound`](playsound.md).

## Syntax

    SetFrequency(channel : byte, freqHi : byte)

## Parameters

- `channel`: which SID voice to update, a compile-time constant: one of
  the shipped `SID_CHANNEL1`, `SID_CHANNEL2`, or `SID_CHANNEL3` constants.
- `freqHi`: the new frequency value, `0`-`255`.

## Example

```pascal
program SetFrequencyDemo;
var
	freq : byte;
begin
	PlaySound(SID_CHANNEL1, 15, 100, 0*16+0, 14*16+9, 1+SID_TRI, SID_TRI);
	freq := 100;
	repeat
		freq := freq + 1;
		SetFrequency(SID_CHANNEL1, freq);
		Wait(1);
	until freq = 255;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setfrequency.ras){ .md-button download }

## Known limitations

`SetFrequency` only sets a SID voice's coarse (high-byte) frequency
register; there's no way through this builtin to also set the low byte,
so pitch changes are limited to 256 discrete steps rather than the SID
chip's full 16-bit frequency resolution.
