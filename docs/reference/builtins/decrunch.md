# `Decrunch`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Decompresses an Exomizer-crunched block of data that immediately follows
an `IncBin`'d block in memory, unpacking it in place.

## Syntax

    Decrunch( <source> );

## Parameters

- `<source>`: an `IncBin`-declared variable holding the crunched data,
  referenced with `#` (e.g. `#myCrunchedData`).

## Example

```pascal
program DecrunchDemo;
var
	// in a real project, sample_data.bin would be actual data pre-crunched
	// with the Exomizer tool; any binary blob compiles here, since Decrunch
	// just needs a valid IncBin block to locate
	packed_data : incbin("sample_data.bin");
begin
	decrunch(#packed_data);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/decrunch.ras){ .md-button download }
(also needs [`sample_data.bin`](../../assets/examples/sample_data.bin) in
the same folder)

## Known limitations

`Decrunch` is auto-initialized (the compiler includes the Exomizer
decompressor routine the first time it sees `decrunch(` or
`decrunchfromindex(` in the source), but unlike some other
auto-initialized builtins, it isn't affected by the `@use`d-unit-file
auto-init scan gap: calling it only from inside a unit file still works
correctly. Its "auto-init" doesn't need a runtime setup call at all, the
decompressor routine is called directly by name at every call site; the
auto-init step only makes sure the routine's code gets included exactly
once, and that inclusion is triggered independently by each file's own
text, unit files included.
