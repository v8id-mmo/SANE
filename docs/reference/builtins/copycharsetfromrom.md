# `CopyCharsetFromRom`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
left interrupts disabled after this builtin ran and never re-enabled
them; SANE re-enables interrupts before returning.

Copies the built-in character ROM font to RAM, so it can be customized
afterward.

## Syntax

    CopyCharsetFromRom( <destination> );

## Parameters

- `<destination>`: where to copy the charset to. A `pointer` variable
  (see Known limitations for why a bare numeric literal doesn't work
  here).

## Example

```pascal
program CopyCharsetFromRomDemo;
var
	dest : ^byte;
begin
	dest := $3000;
	copycharsetfromrom(dest); // copy the ROM charset to RAM at $3000 (see Known limitations)

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/copycharsetfromrom.ras){ .md-button download }

## Known limitations

This builtin has three separate confirmed issues.

**A bare numeric literal destination fails to assemble**, the same
underlying issue as [`Call`](call.md) and [`ClearBitmap`](clearbitmap.md).
`copycharsetfromrom($3000);` emits `sta #$3000,y`, an invalid
instruction, and the build fails at the assembly stage. Always route the
destination through a `pointer` variable instead (as in the example
above).

**It does not copy the full 2048-byte (2KB) character ROM.** The copy
loop is built from 8 chunks that are each supposed to cover one 256-byte
page, but the chunks are only 100 bytes apart instead of 256, so they
heavily overlap and the last one only reaches byte offset 955 of the full
2047-byte range. Well over half the character ROM (roughly everything
past the first 956 bytes) is never copied at all, while the bytes that
are covered get redundantly copied more than once. Anything relying on
this to seed a full custom charset from the stock ROM font will end up
with a RAM copy missing most of its second half.

**In vanilla TRSE, it disables interrupts and never re-enables them.**
`CopyCharsetFromRom` executes `sei` to safely bank out the KERNAL/BASIC
ROM and read the character ROM in their place, but nothing in the
routine turns interrupts back on afterward. A program that calls this
and doesn't separately set up its own interrupt chain (e.g. via
`StartRasterChain`, which does end with a `cli`) silently runs with
interrupts permanently masked from that point on, breaking KERNAL-driven
behavior like keyboard scanning. On vanilla TRSE, call `StartRasterChain`
(or otherwise `cli` explicitly) after using this builtin if the rest of
the program needs interrupts running. :material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`CopyCharsetFromRom` now re-enables interrupts before returning, so this
workaround is no longer necessary on SANE.
