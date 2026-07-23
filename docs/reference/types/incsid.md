# `incsid`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes a `.sid` music file directly at assemble time and reads its
header to expose the tune's real init/play addresses as ready-made
constants. The variable name given in the declaration itself is just a
placeholder; the symbols actually used elsewhere in the program are
auto-generated from the declaration's position in the file (see Parameters
below).

## Syntax

    var
        <name> : incsid("<file>.sid", <headerShift>);

## Parameters

- `<name>`: a placeholder identifier; not itself used to access the tune's
  code. Every `incsid` declaration in a file is numbered in source order
  starting at 1, and that number is what the generated constant names use.
- `<file>.sid`: path to the SID music file, resolved relative to the
  project file's own directory.
- `<headerShift>`: how many bytes to shift past the SID file's own header
  before the raw music data begins (varies by file; `2` is a common value).
- **Generated constants**: `sidfile_<n>_init` and `sidfile_<n>_play` (`<n>`
  matching this declaration's 1-based position), read directly from the
  SID file's own header. Pass `sidfile_<n>_init` to
  [`InitSid`](../builtins/initsid.md), and [`Call`](../builtins/call.md)
  `sidfile_<n>_play` once per frame (typically from inside a raster
  interrupt) to actually hear the music.

## Example

```pascal
program IncSidDemo;
var
	tune : incsid("courier.sid", 2);

interrupt PlayMusic();
begin
	startirq(0);
	call(sidfile_1_play);
	CloseIRQ();
end;

begin
	InitSid(sidfile_1_init);
	RasterIRQ(PlayMusic(), $ff, 0);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/incsid.ras){ .md-button download }
(also needs [`courier.sid`](../../assets/examples/courier.sid) in the same
folder)
