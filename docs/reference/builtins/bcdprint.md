# `BcdPrint`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Prints a BCD (binary-coded decimal) number as decimal digits directly to
the screen, at the current `screenmemory` location. See
[`BcdAdd`](bcdadd.md) for what a BCD number is; this is the display
counterpart to [`BcdAdd`](bcdadd.md)/[`BcdSub`](bcdsub.md)/
[`BcdCompare`](bcdcompare.md)/[`BcdIsEqual`](bcdisequal.md).

## Syntax

    BcdPrint( <address>, <digit pairs> );

## Parameters

- `<address>`: the BCD number to print.
- `<digit pairs>`: how many bytes (digit pairs) long the number is; must
  be a compile-time constant.

## Example

```pascal
program BcdPrintDemo;
var
	score: array[] of byte = ($12,$34,$56); // BCD for 563412

begin
	DefineScreen();
	clearscreen(key_space,screen_char_loc);
	screenmemory := screen_char_loc;

	moveto(0,2,hi(screen_char_loc));
	BcdPrint(#score, 3); // prints "563412"
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/bcdprint.ras){ .md-button download }

## Known limitations

`screenmemory` needs to be set to a real screen address before calling
`BcdPrint` (as in the example, via `moveto`, not yet documented on this
site, or a direct assignment), otherwise it prints wherever
`screenmemory` last happened to point at.
