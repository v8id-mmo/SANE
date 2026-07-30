# `Peek`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
silently returns the wrong value for a bare numeric literal address; SANE
fixes it (see Known limitations below).

Reads a single byte from a memory address, computed as a base address
plus an offset, and returns it. It can also be used to read one element
out of an array by passing the array's address as the base.

## Syntax

    <byte> = Peek( <address>, <offset> )

## Parameters

- `<address>`: the base address to read from. A `^`-prefixed literal, a
  named `address` constant, a pointer, an array's address (`#array`), or
  a bare numeric literal (see Known limitations) all work.
- `<offset>`: a byte added to the base address before reading.

## Returns

The byte value stored at `<address> + <offset>`.

## Example

```pascal
program PeekDemo;
var
	values : array[4] of byte = (10,20,30,40);
	v : byte;
begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring("border color:",0,40);
	v := peek(^$D020, 0); // current border color register
	moveto(15,0,hi(screen_char_loc));
	printnumber(v);

	moveto(0,1,hi(screen_char_loc));
	printstring("values[2]:",0,40);
	v := peek(#values, 2); // same as v := values[2];
	moveto(11,1,hi(screen_char_loc));
	printnumber(v);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/peek.ras){ .md-button download }

## Known limitations

**A bare numeric literal address used to silently return the wrong
value**, a related but differently-shaped issue from the one affecting
[`Poke`](poke.md) and several other builtins ([`Call`](call.md),
[`ClearBitmap`](clearbitmap.md), and more): `peek(53280, 0)` compiled and
assembled without any error, unlike those builtins, but the value
returned was not what was actually stored at address 53280 (`$D020`) -
the read silently did the wrong thing instead of failing loudly. Routing
the same address through a `^`-prefixed literal, a named `address`
constant, or a pointer worked correctly, as does using an array's address
as shown in the example above.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
a bare numeric literal address now reads the correct value too.
