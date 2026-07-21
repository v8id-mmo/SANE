# `BcdIsEqual`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Compares two BCD (binary-coded decimal) numbers and reports whether they
are exactly equal. See [`BcdAdd`](bcdadd.md) for what a BCD number is.

## Syntax

    <boolean> = BcdIsEqual( <address 1>, <address 2>, <digit pairs> );

## Parameters

- `<address 1>`: the first BCD number.
- `<address 2>`: the second BCD number.
- `<digit pairs>`: how many bytes (digit pairs) long both numbers are;
  must be a compile-time constant.

Both numbers must be the same length, stored least-significant byte
first.

## Returns

`true` if both numbers are exactly equal, `false` otherwise.

## Example

```pascal
program BcdIsEqualDemo;
var
	score: array[] of byte = ($12,$34,$56); // BCD for 563412
	target: array[] of byte = ($12,$34,$56); // BCD for 563412

begin
	DefineScreen();
	clearscreen(key_space,screen_char_loc);
	screenmemory := screen_char_loc;

	moveto(0,2,hi(screen_char_loc));
	if (BcdIsEqual(#score,#target,3)) then
		printstring("TARGET REACHED",0,0)
	else
		printstring("KEEP GOING",0,0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/bcdisequal.ras){ .md-button download }

## Known limitations

None found. Confirmed working by compiling the example above and reading
the generated code: it compares every digit-pair byte and only reports
equal if none of them differ.
