# `krillsloader`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
rejects this directive's own keyword casing (e.g. lowercase
`krillsloader`) even with otherwise-valid addresses; SANE matches it
case-insensitively, like every other directive keyword.

A C64-only argument to `@use`, not a directive of its own. It sets up
Krill's loader, a well-known third-party C64 fastloader/installer, bundling
the loader and installer binaries into the build and making them available
to the [`InitKrill`](../builtins/initkrill.md),
[`KrillLoad`](../builtins/krillload.md), and
[`KrillLoadCompressed`](../builtins/krillloadcompressed.md) builtins at
runtime, for loading additional data or code from disk after the program
has started.

## Syntax

    @use KrillsLoader <loaderAddress> <loaderOrgAddress> <installerAddress>

The spacing shown above (single spaces, no extras) must be followed
exactly; see Known limitations. Casing doesn't matter (`krillsloader`
works too).

## Parameters

- `<loaderAddress>`: where the loader itself is installed. Must be one of
  the addresses the bundled loader binaries are built for: `$0200`, or
  `$1000` through `$B000` in `$1000` steps.
- `<loaderOrgAddress>`: the resident loader binary's own origin address.
- `<installerAddress>`: where the installer is placed. Must be one of the
  addresses the bundled installer binaries are built for: `$1000` through
  `$B000` in `$1000` steps.

Whether disk access happens on track 18 or track 19 is controlled
separately, by the project's `use_track_19` setting.

## Example

```pascal
program KrillsLoaderDemo;

@use KrillsLoader $0200 $2000 $3000

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/krillsloader.ras){ .md-button download }

## Known limitations

**The line has to match a very specific, regenerated form of itself, or
the build fails.** After parsing the directive's three addresses, the
compiler reconstructs what it considers the "correct" textual form of the
line (each address as a `$`-prefixed hex number, single spaces) and
locates that exact text in the source file to splice the generated
loader/installer declarations into. If it can't find a match, compilation
fails with: *"Something went wrong with the krill loader implementation:
please make sure that the loader line is exactly of the following format
(spaces matter, letter case doesn't)"*, followed by the one exact form
that would be accepted.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
in vanilla TRSE, that reconstructed form used a fixed capitalization
(`KrillsLoader`), so writing the directive with any other casing (such as
`@use krillsloader $0200 $2000 $3000`, lowercase `krillsloader`) failed
outright even though the three address values were identical to the
accepted form - the only directive in the language whose keyword wasn't
matched case-insensitively. SANE now locates the directive's line
case-insensitively too, matching every other directive.

**Spacing still matters.** The line must still use exactly the spacing
shown in the Syntax section above (single spaces, no extras) - only the
keyword's letter casing is tolerant now, not its spacing.
