# `CopyFullScreen`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Copies an entire 1000-byte C64 text screen (40x25 characters, or the
matching color RAM) from one address to another in one call.

## Syntax

    CopyFullScreen( <source>, <destination> );

## Parameters

- `<source>`: where to copy from.
- `<destination>`: where to copy to.

Both parameters accept a `^`-prefixed address literal, a named `address`
constant, or a `pointer` variable (see Known limitations for why a bare
numeric literal doesn't work here).

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

A bare numeric literal for either `source` or `destination` fails to
assemble, the same underlying issue as
[`Call`](call.md)/[`ClearBitmap`](clearbitmap.md)/
[`CopyCharsetFromRom`](copycharsetfromrom.md).
`copyfullscreen($0400, $4400);` emits `sta #$4400 + $0,x`, an invalid
instruction, and the build fails at the assembly stage. Always route both
addresses through a `^`-prefixed literal, a named `address` constant, or a
pointer/variable instead (as in the example above).
