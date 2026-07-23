# `StrToUpper`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Converts every lowercase ASCII letter in a zero-terminated string to
uppercase, in place. The mirror image of [`StrToLower`](strtolower.md).

## Syntax

    StrToUpper( <text> );

## Parameters

- `<text>`: a `string` variable (passed with `#`) or a `pointer` already
  holding a string's address. Only bytes in the `a`-`z` range are
  changed; every other byte is left untouched.

## Example

```pascal
program StrToUpperDemo;
var
	text : string = "hello world";
begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring(#text,0,40); // "hello world"

	strtoupper(#text);
	moveto(0,1,hi(screen_char_loc));
	printstring(#text,0,40); // "HELLO WORLD"

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/strtoupper.ras){ .md-button download }
