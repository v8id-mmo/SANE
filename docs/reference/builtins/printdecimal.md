# `PrintDecimal`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Prints an integer as a fixed-width decimal number at the current screen
cursor position (set with [`MoveTo`](moveto.md)). Auto-init: the first
time `printdecimal(` appears in a file, the compiler automatically
includes the divide-by-10 routine this builtin needs.

## Syntax

    PrintDecimal( <value>, <digit count minus one> );

## Parameters

- `<value>`: the `byte` or `integer` value to print.
- `<digit count minus one>`: a pure, compile-time number one less than
  how many digits to print. `3` prints 4 digits. The output is always
  padded to exactly that many digits, with no leading-zero suppression.

## Example

```pascal
program PrintDecimalDemo;
var
	score : integer;
begin
	clearscreen(key_space,screen_char_loc);
	score := 1234;
	moveto(0,0,hi(screen_char_loc));
	printstring("score:",0,40);
	moveto(7,0,hi(screen_char_loc));
	printdecimal(score,3); // 4 digits: prints "1234"
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/printdecimal.ras){ .md-button download }

## Known limitations

**Using `PrintDecimal` with no [`MoveTo`](moveto.md),
[`PrintString`](printstring.md), or `Tile` call anywhere else
in the whole compiled program fails at the assembly stage**, with an
"unknown operation" error pointing at the routine `PrintDecimal` shares
with cursor-positioned output. This has nothing to do with whether
`MoveTo` is actually reached at runtime: even an unreachable `MoveTo`
call elsewhere in the same compile is enough to fix it. In practice this
rarely comes up, since positioning the cursor with `MoveTo` before
printing anything is already the normal pattern (as in the example
above), but `PrintDecimal` used completely on its own, with no
`MoveTo`/`PrintString`/`Tile` anywhere in the program, hits this.
