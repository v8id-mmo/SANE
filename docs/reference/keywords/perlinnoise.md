# `@perlinnoise`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

A build-time directive that fills a raw binary file with 2D coherent
("Perlin-style") noise, the same kind of compile-time data generation as
[`buildsinetable`](buildsinetable.md)/[`buildtable2d`](buildtable2d.md),
but for a full 2D noise field instead of a mathematical function. Meant
for things like procedurally generated terrain, cloud/fire textures, or
organic-looking fade patterns.

## Syntax

    @perlinnoise "<output file>" <width> <height> <octaves> <scaleX> <scaleY> <persistence> <amplitude> [<power>];

## Parameters

- `<output file>`: path to write the raw noise bytes to (`width * height`
  bytes, one per pixel). A `.png` preview image is also saved alongside it
  automatically, at `<output file>.png`, purely for visual inspection.
- `<width>`, `<height>`: dimensions of the generated noise field.
- `<octaves>`: how many layers of noise to combine; more octaves add finer
  detail on top of the base pattern.
- `<scaleX>`, `<scaleY>`: how stretched the noise pattern is along each
  axis.
- `<persistence>`: how much each additional octave contributes, as a
  whole number that gets divided by 100 (so `170` means a persistence of
  `1.7`).
- `<amplitude>`: overall brightness scale of the output. See Known
  limitations before pushing this high.
- `<power>` (optional): a whole number divided by 1000 (so `1000` means a
  power of `1.0`, the default if omitted), applied as an exponent to shape
  the noise curve before scaling by amplitude.

## Example

```pascal
program PerlinNoiseDemo;
var

@perlinnoise "noise.bin" 40 25 2 1 1 170 140
	noiseData : incbin("noise.bin");
	i : byte;

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/perlinnoise.ras){ .md-button download }

## Known limitations

**The exported byte data isn't clamped to the 0-255 range, but the `.png`
preview image is.** If `<amplitude>`/`<power>` push a pixel's computed
value above 255 or below 0, that pixel's real, compiled-in byte silently
wraps/truncates instead of clamping, while the preview image next to it is
clamped and looks perfectly clean. This means the preview can be
misleading: it's possible for the `.png` to look completely fine while the
actual noise data compiled into the program has wrapped-around, incorrect
values at the same pixels. Keep amplitude/power conservative, and don't
rely on the preview alone to judge whether the output range is safe.
