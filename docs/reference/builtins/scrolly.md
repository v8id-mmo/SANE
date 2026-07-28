# `ScrollY`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
never masked its own input value, unconditionally cleared the
raster-compare high bit on every call, and silently did nothing if
`temp_zeropages` wasn't configured; SANE fixes all three.

Sets the VIC-II's vertical fine-scroll value, used to smoothly scroll
the screen up or down in single-pixel steps.

## Syntax

    ScrollY(y : byte)

## Parameters

- `y`: the new vertical scroll value, `0` to `7`.

## Example

```pascal
program ScrollYDemo;
var
	y : byte;
begin
	clearscreen(key_space, screen_char_loc);
	y := 0;
	repeat
		y := (y + 1) & 7;
		ScrollY(y);
		Wait(2);
	until false;
end.
```

[:material-download: Download this example](../../assets/examples/scrolly.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, `ScrollY` only masks the VIC-II register's *existing*
contents before writing the new value in; it never masks the value you
pass it.** On vanilla TRSE, always mask your own scroll counter to `0`-`7`
(e.g. `y & 7`) before calling `ScrollY`, since a value outside that range
gets OR'd straight into the register, silently flipping the 24/25-row-select,
display-enable, or extended-color-mode bits that live in the same
register.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`ScrollY` now masks its own input value to `0`-`7` before combining it
in, so an out-of-range value can no longer flip those bits.

**In vanilla TRSE, every call to `ScrollY` also unconditionally clears
the raster-compare high bit of that same register, regardless of what
value you pass.** If a raster interrupt has been set up on a line at or
past 256 (which needs that high bit set), calling `ScrollY` afterward on
vanilla TRSE silently disarms it.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`ScrollY` no longer disturbs the raster-compare high bit, so a raster
interrupt armed on a line at or past 256 survives a later `ScrollY` call.

**In vanilla TRSE, `ScrollY` also depends on the compiling project's
`temp_zeropages` setting being non-empty; every shipped project template
already populates this, but if it's blank, `ScrollY` silently does
nothing at all, with no compiler error.**

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
compiling a call to `ScrollY` with `temp_zeropages` blank now fails with
a clear error instead of silently doing nothing.
