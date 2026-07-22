# `SetMemoryConfig`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Configures the CPU's memory-configuration port to bank BASIC and/or
KERNAL ROM in or out, replacing them with plain RAM, and to make the I/O
area visible or not. Almost every non-trivial C64 program calls this
early on to reclaim RAM from underneath the ROMs.

## Syntax

    SetMemoryConfig(io, kernal, basic : byte)

## Parameters

- `io`: `1` to keep the I/O area (`$D000`-`$DFFF`) visible, `0` to
  replace it with RAM.
- `kernal`: `1` to keep KERNAL ROM mapped in, `0` to replace it with RAM.
- `basic`: `1` to keep BASIC ROM mapped in, `0` to replace it with RAM.

All three arguments must be compile-time constants.

## Example

```pascal
program SetMemoryConfigDemo;
begin
	SetMemoryConfig(1, 0, 0);   // IO visible, KERNAL and BASIC banked out
	clearscreen(key_space, screen_char_loc);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setmemoryconfig.ras){ .md-button download }

## Known limitations

For exactly one combination of arguments, `(1, 0, 0)`, which also happens
to be by far the most common way this builtin gets called in practice,
the compiler silently substitutes a different value for the `basic`
argument before computing the byte it writes, rather than using the
value actually passed in. This particular substitution doesn't change
which ROM/RAM ends up mapped in, so most programs never notice, but it
does mean the exact byte value written ends up different from what a
plain reading of the three arguments would predict. This matters if your
own code later reads that port back directly and compares it against an
expected value.
