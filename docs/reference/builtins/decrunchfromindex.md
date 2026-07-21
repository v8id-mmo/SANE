# `DecrunchFromIndex`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Like [`Decrunch`](decrunch.md), but looks up the source address from a
table of addresses instead of taking one directly, useful when a program
needs to decompress one of several different assets picked at runtime
(e.g. one of several level layouts).

## Syntax

    DecrunchFromIndex( <table>, <index> );

## Parameters

- `<table>`: an address table where each entry is one 2-byte (low byte,
  high byte) address of a crunched data block, referenced with `#`.
- `<index>`: which table entry to use (`0` for the first entry, `1` for
  the second, and so on). There's no bounds check: an out-of-range index
  just reads past the table.

## Example

```pascal
program DecrunchFromIndexDemo;
var
	// in a real project each entry would point at an actual Exomizer-crunched
	// block (e.g. one per level); this demo hardcodes two placeholder
	// addresses just to show the table layout
	level_table : array[4] of byte = (
		$00, $90,  // low/high byte of level 0's crunched data address ($9000)
		$00, $95   // low/high byte of level 1's crunched data address ($9500)
	);
	current_level : byte = 0;
begin
	decrunchfromindex(#level_table, current_level);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/decrunchfromindex.ras){ .md-button download }

## Known limitations

Same auto-init note as [`Decrunch`](decrunch.md): although
`decrunchfromindex(` is on the compiler's auto-init trigger list, using it
only from inside a unit file still works correctly, since its "auto-init"
step only ensures the shared decompressor routine's code is included once
rather than performing any runtime setup that could be missed.
