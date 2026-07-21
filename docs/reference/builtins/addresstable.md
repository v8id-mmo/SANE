# `AddressTable`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Looks up an address from a table built by
[`CreateAddressTable`](createaddresstable.md), selected by a Y offset
(the table entry index) with an optional X offset added on top. The
common use is turning an (x, y) screen position into a real screen
address, using a table of per-row start addresses.

## Syntax

    <address> = AddressTable( <address>, <x offset>, <y offset> );

## Parameters

- `<address>`: the table to read from, same value passed as the first
  argument to [`CreateAddressTable`](createaddresstable.md).
- `<x offset>`: added to the looked-up row address (a `byte`).
- `<y offset>`: which table entry (row) to look up (a `byte`).

## Returns

The 16-bit address at `<y offset>` in the table, plus `<x offset>`.

## Example

```pascal
program AddressTableDemo;
var
	rowAddr : array[25] of integer;
	i : byte;

begin
	DefineScreen();
	clearscreen(key_space,screen_char_loc);

	CreateAddressTable(#rowAddr, screen_char_loc, 40, 25); // 25 row start addresses, 40 bytes apart

	fori i := 0 to 24 do
	begin
		screenmemory := AddressTable(#rowAddr, i, i); // diagonal: column i of row i
		screenmemory[0] := 65 + i; // plot 'A', 'B', 'C', ...
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/addresstable.ras){ .md-button download }

## Known limitations

None found. Confirmed working by compiling the example above and
verifying the generated code correctly scales the Y offset (multiplying
by 2, since each table entry is a 16-bit address) before indexing the
table.
