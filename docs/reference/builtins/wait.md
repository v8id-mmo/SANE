# `Wait`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Busy-waits for a fixed number of iterations, burning CPU cycles without
doing anything else. A simple, imprecise delay; for delays synced to the
screen's own timing, see [`WaitForRaster`](waitforraster.md) /
[`WaitForVerticalBlank`](waitforverticalblank.md) /
[`WaitNoRaster`](waitnoraster.md) instead.

## Syntax

    Wait( <count> );

## Parameters

- `<count>`: a `byte` value. Roughly `<count> * 5` CPU cycles are spent
  spinning (see Known limitations for what `0` actually does).

## Example

```pascal
program WaitDemo;
var
	delay : byte = 200;
begin
	screen_bg_col := black;
	while (true) do
	begin
		screen_bg_col := white;
		wait(delay);
		screen_bg_col := black;
		wait(delay);
	end;
end.
```

[:material-download: Download this example](../../assets/examples/wait.ras){ .md-button download }

## Known limitations

**`Wait(0)` doesn't skip the wait, it wraps around to a near-maximum
one.** The generated loop always decrements its counter at least once
before checking it, so a `<count>` of `0` underflows on the very first
pass and ends up spinning through the full 256-iteration range instead
of returning immediately. This is the same "loop body runs at least
once" shape as other counted loops in this fork ([`FOR`](../keywords/for.md),
`FLD`, `MemCpy`'s runtime count of `0`): to get an actual no-op delay,
skip the call entirely rather than passing `0`.
