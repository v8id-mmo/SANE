# `InitKrill`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
left interrupts disabled after `InitKrill` ran and never re-enabled them;
SANE re-enables interrupts before returning.

Installs Krill's loader into memory, ahead of using
[`KrillLoad`](krillload.md) or
[`KrillLoadCompressed`](krillloadcompressed.md) to load data or code from
disk. Unlike the `init...`
routines paired with an auto-init trigger, `InitKrill` is always called
explicitly by the program; it isn't part of the automatic-initialization
scan mechanism.

## Syntax

    InitKrill();

Requires `krillsloader` to have been pulled in first, with `@use
KrillsLoader <loaderAddress> <loaderOrgAddress> <installerAddress>`.

## Example

```pascal
program InitKrillDemo;

// KrillsLoader bundles Krill's loader/installer binaries into the build.
// InitKrill installs the loader into memory and is always called
// explicitly; it isn't part of the auto-init scan mechanism.
@use KrillsLoader $0200 $2000 $3000

begin
	InitKrill();
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initkrill.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, `InitKrill` disables interrupts (`sei`) as part of
installing the loader and does not turn them back on afterward**; a
program that needs interrupts running (for a raster IRQ, for example)
has to re-enable them itself once the install is done. :material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`InitKrill` now re-enables interrupts before returning, on every exit
path, so this is no longer necessary on SANE.
