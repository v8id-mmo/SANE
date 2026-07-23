# `address`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A 16-bit memory location: a hardware register, a fixed data address, or
anywhere else in the C64's address space that a program needs to name.
Unlike `integer`, which holds an ordinary numeric value,
`address` is meant to identify *where* something lives, most often passed
straight into builtins like [`Peek`](../builtins/peek.md)/
[`Poke`](../builtins/poke.md) instead of being read or written as a value
in its own right.

## Syntax

    const <name> : address = <address value>;

## Parameters

- `<name>`: the constant's identifier.
- `<address value>`: a 16-bit numeric literal, usually written in
  hexadecimal (`$D020`).

## Example

```pascal
program AddressDemo;
var
	const borderReg : address = $D020;
	const backgroundReg : address = $D021;
	readBack : byte;
begin
	clearscreen(key_space,screen_char_loc);

	// A named address constant, not a bare numeric literal, is the
	// reliable way to pass a fixed memory location to a builtin.
	Poke(borderReg, 6, 0);
	Poke(backgroundReg, 6, 0);

	// Reading it back proves it's the same location, not just a number
	readBack := Peek(borderReg, 0);
	moveto(0,0,hi(screen_char_loc));
	printstring("border reg now:",0,40);
	moveto(17,0,hi(screen_char_loc));
	printdecimal(readBack,2);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/address.ras){ .md-button download }

## Known limitations

**`address` only works declared as a `const`.** Declaring one as a plain
`var`, with or without an initial value, and whether or not it's ever
referenced anywhere in the program, fails to compile with a codegen error
("Could not find variable 'ADDRESS'"). Every real usage of this type,
including in this fork's own tutorials, declares it as `const`; there is
currently no working way to have a mutable, runtime-assignable `address`
variable. If a location genuinely needs to change at runtime, use a
`pointer` instead, which supports normal assignment.

Separately, a bare numeric literal address passed directly to several
builtins ([`Call`](../builtins/call.md),
[`ClearBitmap`](../builtins/clearbitmap.md), and others) fails to
assemble; a named `address` constant like the ones above works correctly
in every one of those cases, which is why this pattern (naming the
address first, then passing the name) is the safe default rather than
just a style preference.
