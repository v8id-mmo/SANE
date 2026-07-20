# `krillsloader`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

A C64-only argument to `@use`, not a directive of its own. It sets up
Krill's loader, a well-known third-party C64 fastloader/installer, bundling
the loader and installer binaries into the build and making them available
to the `InitKrill`/`KrillLoad`/`KrillLoadCompressed` builtins at runtime,
for loading additional data or code from disk after the program has
started.

## Syntax

    @use KrillsLoader <loaderAddress> <loaderOrgAddress> <installerAddress>

The casing and spacing shown above must be followed exactly; see Known
limitations.

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

**The line has to match a very specific, regenerated form of itself,
character for character, or the build fails.** After parsing the
directive's three addresses, the compiler reconstructs what it considers
the "correct" textual form of the line (fixed capitalization
`KrillsLoader`, each address as a `$`-prefixed 4-digit hex number, single
spaces) and checks whether that exact string appears verbatim in the
source file. If it doesn't, compilation fails with: *"Something went wrong
with the krill loader implementation: please make sure that the loader
line is exactly of the following format (including spaces and letter
cases etc)"*, followed by the one exact form that would be accepted.

Concretely, this means writing the directive with a different (but
otherwise valid and case-insensitive-everywhere-else) casing, such as
`@use krillsloader $0200 $2000 $3000` (lowercase `krillsloader`), fails
outright, even though the three address values are identical to the
accepted form. Always copy the exact casing and spacing shown in the
Syntax section above.
