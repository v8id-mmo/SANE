# `@setcompressionweights`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Tunes the perceptual similarity check that
[`@exportcompressed`](exportcompressed.md) uses when deciding whether two
characters/tiles look close enough to be merged into one reused entry.
Three separate weights let you push the comparison toward caring more
about overall brightness, fine structural detail, or contrast when it
scores how "close" two characters are.

## Syntax

    @setcompressionweights <luminosity> <structure> <contrast>

## Parameters

- `<luminosity>`: how much overall brightness difference counts toward
  "these two characters are different", 0-100.
- `<structure>`: how much fine-detail/edge structure difference counts,
  0-100.
- `<contrast>`: how much contrast difference counts, 0-100.

All three are treated as percentages (divided by 100 internally) and feed
into the same similarity score `@exportcompressed`'s `<compression>`
threshold parameter is compared against, so this directive only matters
when used together with `@exportcompressed`.

## Example

```pascal
program SetCompressionWeightsDemo;

@setcompressionweights 100 100 100

@exportcompressed "sample_sprite.flf" "sample_sprite_compressed.bin" 0 0 8 8 25

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setcompressionweights.ras){ .md-button download }
(also needs
[`sample_sprite.flf`](../../assets/examples/sample_sprite.flf) in the
same folder)
