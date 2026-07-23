# `PrintNumber`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Prints a byte as a 2-character hexadecimal number at the current screen
cursor position (set with [`MoveTo`](moveto.md)), despite the plain
"number" name. For a decimal display, use
[`PrintDecimal`](printdecimal.md) instead. Auto-init: the first time
`printnumber(` or `printstring(` appears in a file, the compiler
automatically includes the shared string-printing routine both builtins
need.

## Syntax

    PrintNumber( <value> );

## Parameters

- `<value>`: the `byte` value to print, shown as two hexadecimal digits.

## Example

```pascal
program PrintNumberDemo;
var
	health : byte;
begin
	clearscreen(key_space,screen_char_loc);
	health := 64;
	moveto(0,0,hi(screen_char_loc));
	printstring("health (hex):",0,40);
	moveto(14,0,hi(screen_char_loc));
	printnumber(health); // prints "40" (64 in hexadecimal)
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/printnumber.ras){ .md-button download }

## Known limitations

**Using `PrintNumber` with no [`MoveTo`](moveto.md),
[`PrintString`](printstring.md), or `Tile` call anywhere else
in the whole compiled program fails at the assembly stage**, with an
"unknown operation" error. This has nothing to do with whether `MoveTo`
is actually reached at runtime: even an unreachable `MoveTo` call
elsewhere in the same compile is enough to fix it. In practice this
rarely comes up, since positioning the cursor with `MoveTo` before
printing anything is already the normal pattern (as in the example
above), but `PrintNumber` used completely on its own, with no
`MoveTo`/`PrintString`/`Tile` anywhere in the program, hits this.
