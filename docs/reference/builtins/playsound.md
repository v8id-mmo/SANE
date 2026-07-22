# `PlaySound`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Sets up one SID voice and plays a note on it in a single call: volume,
frequency, envelope (attack/decay, sustain/release), and waveform. A
convenience wrapper around writing the SID's registers directly.

## Syntax

    PlaySound( <channel>, <volume>, <freq hi>, <attack/decay>, <sustain/release>, <waveform 1>, <waveform 2> );

## Parameters

- `<channel>`: which SID voice to use, a compile-time constant
  (`SID_CHANNEL1`, `SID_CHANNEL2`, or `SID_CHANNEL3`).
- `<volume>`: master volume (0-15). This is the SID's single shared
  volume register, so it affects all three voices, not just this one.
- `<freq hi>`: the high byte of the voice's frequency register.
- `<attack/decay>`: packed attack (high nibble) / decay (low nibble)
  envelope value.
- `<sustain/release>`: packed sustain (high nibble) / release (low
  nibble) envelope value.
- `<waveform 1>`: a waveform constant (`SID_SAW`, `SID_TRI`,
  `SID_PULSE`, `SID_NOISE`), typically combined with `+1` to also set the
  gate bit and trigger the note (see Known limitations).
- `<waveform 2>`: a second waveform value, written right after the first
  (see Known limitations).

## Example

```pascal
program PlaySoundDemo;
begin
	moveto(0,0,hi(screen_char_loc));
	printstring("playing a sound",0,40);
	playsound(SID_CHANNEL1,
		13,           // volume
		20,           // frequency, high byte
		0*16+0,       // attack/decay
		3*16+12,      // sustain/release
		1+SID_SAW,    // waveform+gate (see Known limitations)
		SID_SAW);     // waveform actually applied
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/playsound.ras){ .md-button download }

## Known limitations

**The two waveform parameters both write the exact same SID control
register, one right after the other, with nothing in between.** The
second write always overwrites the first before it can have any
observable effect, so only the last waveform parameter's value ever
actually reaches the chip. In the example above, `1+SID_SAW` (waveform
plus the gate bit, normally what triggers a note's attack phase) is
written and then immediately overwritten by the plain `SID_SAW` that
follows it, so the gate bit never ends up set. In practice, use the
final (seventh) parameter for whatever waveform value you actually want
applied, and don't rely on the sixth parameter having any effect.
