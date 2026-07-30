# `CopyFullScreen`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
fails to assemble a bare numeric literal address; SANE fixes it (see
Known limitations below).

Copies an entire 1000-byte C64 text screen (40x25 characters, or the
matching color RAM) from one address to another in one call.

## Syntax

    CopyFullScreen( <source>, <destination> );

## Parameters

- `<source>`: where to copy from.
- `<destination>`: where to copy to.

Both parameters accept a `^`-prefixed address literal, a named `address`
constant, a `pointer` variable, or a bare numeric literal (see Known
limitations).

## Example

```pascal
program CopyFullScreenDemo;
begin
	// duplicate the visible screen into a second, off-screen char buffer
	copyfullscreen(^$0400, ^$4400);

	// and its color RAM alongside it
	copyfullscreen(^$D800, ^$4400+1000);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/copyfullscreen.ras){ .md-button download }

## Known limitations

A bare numeric literal for either `source` or `destination` used to fail
to assemble, the same underlying issue as
[`Call`](call.md)/[`ClearBitmap`](clearbitmap.md)/
[`CopyCharsetFromRom`](copycharsetfromrom.md).
`copyfullscreen($0400, $4400);` emitted `sta #$4400 + $0,x`, an invalid
instruction, and the build failed at the assembly stage. Routing both
addresses through a `^`-prefixed literal, a named `address` constant, or a
pointer/variable instead (as in the example above) was the workaround.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
a bare numeric literal now assembles correctly for either parameter too.
