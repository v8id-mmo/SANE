# `CreateAddressTable`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Builds a table of 16-bit addresses in memory (or in an `integer` array),
starting at a given address and incrementing by a fixed amount for each
entry. The classic use is building a table of the start address of every
row on the screen, so [`AddressTable`](addresstable.md) can then turn an
(x, y) position into a real screen address without repeated
multiplication.

## Syntax

    CreateAddressTable( <address>, <start value>, <increment>, <entry count> );

## Parameters

- `<address>`: where to store the table; a fixed memory address or an
  `integer` array (passed by reference with `#arrayname`).
- `<start value>`: the first entry's value (a constant address or number).
- `<increment>`: how much larger each following entry is than the last
  (a `byte`).
- `<entry count>`: how many entries to build (a `byte`).

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

None found. Confirmed working by compiling the example above; each
of the 25 diagonal characters lands at a distinct, correctly-spaced screen
position when the generated table is used through
[`AddressTable`](addresstable.md).
