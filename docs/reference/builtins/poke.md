# `Poke`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
rejects a bare numeric literal address outright; SANE fixes it (see
Known limitations below).

Writes a single byte to a memory address, computed as a base address
plus an offset. It can also be used to write one element of an array by
passing the array's address as the base.

## Syntax

    Poke( <address>, <offset>, <value> );

## Parameters

- `<address>`: the base address to write to. A `^`-prefixed literal, a
  named `address` constant, a pointer, an array's address (`#array`), or
  a bare numeric literal (see Known limitations) all work.
- `<offset>`: a byte added to the base address before writing.
- `<value>`: the byte to store at `<address> + <offset>`.

## Example

```pascal
program PokeDemo;
var
	values : array[4] of byte;
begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring("poke demo",0,40);

	poke(^$D020, 0, black); // border color := black

	poke(#values, 2, 42); // same as values[2] := 42;
	moveto(0,1,hi(screen_char_loc));
	printnumber(values[2]);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/poke.ras){ .md-button download }

## Known limitations

**A bare numeric literal address used to fail to compile.** `poke(53280,
0, 0)` failed immediately with "Parameter 0 must be a variable or
address", even though `53280` is `$D020`, a perfectly valid address.
Routing the exact same address through a `^`-prefixed literal
(`poke(^$D020, 0, 0)`), a named `address` constant, or a pointer worked
correctly, as does using an array's address as shown in the example
above. [`Peek`](peek.md), the matching read builtin, had a related but
differently-shaped bug of its own: a bare numeric literal address there
compiled and assembled without complaint, but silently read the wrong
value (see its own Known limitations section).

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
a bare numeric literal address now works correctly here too.
