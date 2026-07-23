# `StrGetFromIndex`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reads one "word" back out of a buffer previously produced by
[`StrSplit`](strsplit.md), by its position.

## Syntax

    <pointer> = StrGetFromIndex( <buffer>, <index> )

## Parameters

- `<buffer>`: a buffer built by `StrSplit` (a run of null-separated
  substrings), passed as an address (`#bufferVar`).
- `<index>`: which substring to fetch, counting from `0` for the first
  one. Requesting an index past the last substring actually present in
  the buffer has no defined result, since there is no length to check
  against, just whatever bytes happen to follow in memory.

## Returns

A `pointer` to the start of the requested substring, still
zero-terminated in place inside `<buffer>` (usable directly with
[`PrintString`](printstring.md), `StrCmp`, etc, no copying needed).

## Example

```pascal
program StrGetFromIndexDemo;
var
	source : string = "SANE IS FUN";
	splitbuf : array[16] of byte;
	part : pointer;
begin
	clearscreen(key_space,screen_char_loc);

	strsplit(#source,#splitbuf,key_space);

	part := strgetfromindex(#splitbuf,0);
	moveto(0,0,hi(screen_char_loc));
	printstring(part,0,40); // "SANE"

	part := strgetfromindex(#splitbuf,1);
	moveto(0,1,hi(screen_char_loc));
	printstring(part,0,40); // "IS"

	part := strgetfromindex(#splitbuf,2);
	moveto(0,2,hi(screen_char_loc));
	printstring(part,0,40); // "FUN"

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/strgetfromindex.ras){ .md-button download }
