# `Swap`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Exchanges the values of two `byte` variables in place.

## Syntax

    Swap( <a>, <b> );

## Parameters

- `<a>`: a plain `byte` variable, not an expression or array element.
- `<b>`: same restriction as `<a>`.

## Example

```pascal
program SwapDemo;
var
	a : byte = 5;
	b : byte = 9;
begin
	clearscreen(key_space,screen_char_loc);

	moveto(0,0,hi(screen_char_loc));
	printdecimal(a,3); // 5
	moveto(0,1,hi(screen_char_loc));
	printdecimal(b,3); // 9

	swap(a,b);

	moveto(0,2,hi(screen_char_loc));
	printdecimal(a,3); // 9
	moveto(0,3,hi(screen_char_loc));
	printdecimal(b,3); // 5

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/swap.ras){ .md-button download }
