# `pointer`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A 16-bit memory address that can be dereferenced to read or write the
value it points to. Can point at a `byte`, `integer`, `long`, or a
`record`/`class` instance. Two equivalent declaration styles exist:
`^<type>` and `pointer of <type>`.

## Syntax

    var
        <name> : ^byte;
        <name> : ^integer;
        <name> : ^long;
        <name> : pointer of byte;
        <name> : pointer of <ClassOrRecordName>;

    <name> := #<variable>;   // point at a variable's address
    <name>^ := <value>;      // write through the pointer
    <value> := <name>^;      // read through the pointer

## Parameters

- `<name>`: the variable's identifier.
- `<type>`: what the pointer targets: `byte`, `integer`, `long`, or a
  named `record`/`class` type. No other target type is accepted.

## Example

```pascal
program PointerDemo;
var
	buffer : array[4] of byte = (10,20,30,40);
	ptr : ^byte;
	ptr2 : pointer of byte;
	i : byte;
	total : integer;
begin
	clearscreen(key_space,screen_char_loc);

	ptr := #buffer;
	total := 0;
	for i:=0 to 3 do
	begin
		total := total + ptr^;
		ptr := ptr + 1;
	end;

	moveto(0,0,hi(screen_char_loc));
	printstring("sum:",0,40);
	moveto(5,0,hi(screen_char_loc));
	printdecimal(total,3);

	// pointer of byte works exactly like ^byte
	ptr2 := #buffer;
	ptr2^ := 99;

	moveto(0,1,hi(screen_char_loc));
	printstring("buffer[0]:",0,40);
	moveto(11,1,hi(screen_char_loc));
	printdecimal(buffer[0],3);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/pointer.ras){ .md-button download }

## Known limitations

**No real pointer-to-pointer support**, despite the language reserving a
`ppointer` keyword for it: `ppointer` isn't actually wired up as a usable
type at all (`var x : ppointer;` fails with "Unknown or illegal type").
The two spellings that look like they should give double indirection
don't work either: `^pointer` is a hard compile error ("Must point to
either byte, integers, long"), and `pointer of pointer` parses
successfully but silently generates the exact same single-level indirect
store as a plain byte pointer, i.e. it's not a real double dereference.
There is currently no way to point at a pointer on this fork's C64
target.
