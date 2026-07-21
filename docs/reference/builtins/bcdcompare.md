# `BcdCompare`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Compares two BCD (binary-coded decimal) numbers and reports whether the
first is larger than the second. See [`BcdAdd`](bcdadd.md) for what a BCD
number is.

## Syntax

    <boolean> = BcdCompare( <address 1>, <address 2>, <digit pairs> );

## Parameters

- `<address 1>`: the first BCD number.
- `<address 2>`: the second BCD number.
- `<digit pairs>`: how many bytes (digit pairs) long both numbers are;
  must be a compile-time constant.

Both numbers must be the same length, stored least-significant byte
first.

## Returns

`true` if `<address 1>` is strictly larger than `<address 2>`; `false` if
it's smaller than or equal to it.

## Example

```pascal
program BcdCompareDemo;
var
	score: array[] of byte = ($12,$34,$56); // BCD for 563412
	highscore: array[] of byte = ($15,$34,$56); // BCD for 563415

begin
	DefineScreen();
	clearscreen(key_space,screen_char_loc);
	screenmemory := screen_char_loc;

	moveto(0,2,hi(screen_char_loc));
	if (BcdCompare(#score,#highscore,3)) then
		printstring("NEW HIGH SCORE",0,0)
	else
		printstring("NO NEW RECORD",0,0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/bcdcompare.ras){ .md-button download }
