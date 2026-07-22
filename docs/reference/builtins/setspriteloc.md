# `SetSpriteLoc`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Points a hardware sprite at its shape data by writing the appropriate
entry in the sprite-pointer table. Needs to be called for every sprite
whose shape data address changes (including animation frames).

## Syntax

    SetSpriteLoc(spriteNum : byte, dataLoc : byte, bank : byte)

## Parameters

- `spriteNum`: which sprite (`0`-`7`) to point.
- `dataLoc`: the sprite's shape data address, divided by 64 (the sprite
  data block size). For data at `$2000`, pass `$2000/64` (`$80`).
- `bank`: which 16KB VIC bank (`0`-`3`) the shape data lives in. Must be
  a compile-time constant.

## Example

```pascal
program SetSpriteLocDemo;
begin
	SetSpriteLoc(0, $80, vic_bank0);   // sprite 0's data at $2000 ($2000/64 = $80)
	sprite_color[0] := light_red;
	togglebit(sprite_bitmask, 0, 1);   // turn sprite 0 on
	SpritePos(100, 100, 0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setspriteloc.ras){ .md-button download }

## Known limitations

Neither argument is actually range-checked. The `bank` argument's own
compile error message claims it "must be constant 0-3", but only "is
this a compile-time constant at all" is enforced, not the 0-3 range
itself; a constant of `4` or higher compiles cleanly and computes a
sprite-pointer address outside the intended table. `spriteNum` has no
range check at all, compile-time or runtime; a value outside `0`-`7`
silently writes past the 8-byte sprite-pointer table into whatever
memory follows it.

Separately, the address this builtin writes to always assumes the
screen is at its *default* location. If [`SetScreenLocation`](setscreenlocation.md)
has moved the screen anywhere else, `SetSpriteLoc` still writes to the
old, default location's sprite-pointer table rather than the real,
currently active one, so the sprite silently doesn't get pointed at the
data you asked for.
