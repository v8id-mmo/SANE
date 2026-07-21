# `BcdSub`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Subtracts one BCD (binary-coded decimal) number from another, in place.
See [`BcdAdd`](bcdadd.md) for what a BCD number is and why it's useful for
things like score counters.

## Syntax

    BcdSub( <address 1>, <address 2>, <digit pairs> );

## Parameters

- `<address 1>`: the BCD number to subtract from; holds the result
  afterwards.
- `<address 2>`: the BCD number to subtract.
- `<digit pairs>`: how many bytes (digit pairs) long both numbers are;
  must be a compile-time constant.

Both numbers must be the same length, stored least-significant byte
first.

## Example

```pascal
program BcdSubDemo;
var
	score: array[] of byte = ($12,$34,$56); // BCD for 563412
	points: array[] of byte = ($01,$00,$00); // BCD for 000001

begin
	DefineScreen();
	clearscreen(key_space,screen_char_loc);
	screenmemory := screen_char_loc;

	BcdSub(#score, #points, 3); // score becomes 563411

	moveto(0,2,hi(screen_char_loc));
	BcdPrint(#score, 3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/bcdsub.ras){ .md-button download }

## Known limitations

Like plain binary subtraction, subtracting a larger BCD number from a
smaller one wraps around rather than going negative; there is no
separate sign handling.
