# `CopyHalfScreen`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Copies a given number of full 40-column screen rows from one address to
another, column by column. Useful for split-screen effects where only
part of the screen needs to change, rather than the whole 1000-byte
screen `CopyFullScreen` copies.

## Syntax

    CopyHalfScreen( <source>, <destination>, <lines>, <inverted>, <invertedX> );

## Parameters

- `<source>`: where to copy from.
- `<destination>`: where to copy to.
- `<lines>`: how many 40-column rows to copy. Must be a literal constant
  number, not a variable.
- `<inverted>`: `0` copies rows top-to-bottom; `1` copies them
  bottom-to-top. Must be a literal constant number, not a variable.
- `<invertedX>`: `0` walks columns 0 to 39; `1` walks them 40 down to 0.
  Must be a literal constant number, not a variable.

`<source>` and `<destination>` accept a `^`-prefixed address literal, a
named `address` constant, or a `pointer` variable (see Known limitations
for why a bare numeric literal doesn't work here).

## Example

```pascal
program CopyHalfScreenDemo;
begin
	// copy just the top 12 rows from an off-screen buffer to the visible
	// screen, leaving the bottom 13 rows (e.g. a status bar) untouched
	copyhalfscreen(^$4400, ^$0400, 12, 0, 0);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/copyhalfscreen.ras){ .md-button download }

## Known limitations

A bare numeric literal for `source` or `destination` fails to assemble,
the same underlying issue as [`Call`](call.md)/
[`ClearBitmap`](clearbitmap.md)/[`CopyCharsetFromRom`](copycharsetfromrom.md)/
[`CopyFullScreen`](copyfullscreen.md). `copyhalfscreen($0400, $4400, 12,
0, 0);` emits `sta #$4400 + 0 -1 ,x`, an invalid instruction, and the
build fails at the assembly stage. Always route both addresses through a
`^`-prefixed literal, a named `address` constant, or a pointer/variable
instead (as in the example above).

Separately, although `<lines>`, `<inverted>`, and `<invertedX>` are
documented as plain byte parameters, all three actually have to be
literal constant numbers; passing a variable for any of them fails to
compile with a "must be a constant number" error.
