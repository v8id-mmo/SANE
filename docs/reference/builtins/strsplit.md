# `StrSplit`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Copies a string into a destination buffer, replacing every occurrence of
a chosen delimiter byte with a zero terminator. The result is a run of
back-to-back null-separated "words" that [`StrGetFromIndex`](strgetfromindex.md)
can then read back out one at a time.

## Syntax

    StrSplit( <source>, <destination>, <delimiter> );

## Parameters

- `<source>`: the string to split, passed as an address (`#stringVar`).
  Must be a plain array/string variable, not an expression.
- `<destination>`: the buffer to write the split result into, also
  passed as an address (`#bufferVar`). Must be at least as large as
  `<source>` (one byte per source character, plus the final terminator);
  it does not need any relation to `<source>`'s own declared size beyond
  that.
- `<delimiter>`: the byte value to split on, e.g. `key_space` (32) to
  split on spaces. Must be a plain constant or variable, not an
  expression.

## Example

```pascal
program StrSplitDemo;
var
	source : string = "SANE IS FUN";
	splitbuf : array[16] of byte;
	part : pointer;
begin
	clearscreen(key_space,screen_char_loc);

	// Replaces every space in "source" with a zero terminator inside
	// "splitbuf", so it becomes 3 back-to-back null-separated words.
	strsplit(#source,#splitbuf,key_space);

	// StrGetFromIndex reads a word back out by its 0-based position.
	part := strgetfromindex(#splitbuf,0);
	moveto(0,0,hi(screen_char_loc));
	printstring(part,0,40); // "SANE"

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/strsplit.ras){ .md-button download }
