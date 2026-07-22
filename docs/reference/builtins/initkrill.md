# `InitKrill`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Installs Krill's loader into memory, ahead of using `KrillLoad` or
`KrillLoadCompressed` to load data or code from disk. Unlike the `init...`
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

`InitKrill` disables interrupts (`sei`) as part of installing the loader
and does not turn them back on afterward; a program that needs interrupts
running (for a raster IRQ, for example) has to re-enable them itself once
the install is done.
