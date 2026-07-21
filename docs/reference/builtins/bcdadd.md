# `BcdAdd`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Adds one BCD (binary-coded decimal) number to another, in place. Each byte
of a BCD number holds two decimal digits, which makes it convenient for
things like score counters, since the raw bytes print as decimal digits
directly (see [`BcdPrint`](bcdprint.md)) without a separate binary-to-decimal
conversion step.

## Syntax

    BcdAdd( <address 1>, <address 2>, <digit pairs> );

## Parameters

- `<address 1>`: the BCD number to add to; holds the result afterwards.
- `<address 2>`: the BCD number to add.
- `<digit pairs>`: how many bytes (digit pairs) long both numbers are; must
  be a compile-time constant.

Both numbers must be the same length, stored least-significant byte
first.

## Example

```pascal
program BcdAddDemo;
var
	score: array[] of byte = ($12,$34,$56); // BCD for 563412
	points: array[] of byte = ($01,$00,$00); // BCD for 000001

begin
	DefineScreen();
	clearscreen(key_space,screen_char_loc);
	screenmemory := screen_char_loc;

	BcdAdd(#score, #points, 3); // score becomes 563413

	moveto(0,2,hi(screen_char_loc));
	BcdPrint(#score, 3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/bcdadd.ras){ .md-button download }

## Known limitations

None found. Confirmed working by compiling the example above and reading
the generated code: it uses the 6502's decimal mode (`sed`/`cld`) to add
matching byte pairs directly, which is exactly what BCD addition needs.
