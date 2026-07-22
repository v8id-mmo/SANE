# `PrintString`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Prints a zero-terminated string at the current screen cursor position
(set with [`MoveTo`](moveto.md)), starting a given number of characters
into the string and stopping after a maximum number of characters,
whichever comes first. Works with both a `string` variable and a
double-quoted string literal. Auto-init: the first time `moveto(`,
`printstring(`, or `tile(` appears in a file, the compiler automatically
includes the cursor-positioning and string-printing routines both
builtins need.

## Syntax

    PrintString( <text>, <start offset>, <max length> );

## Parameters

- `<text>`: a `string` variable, or a double-quoted string literal.
- `<start offset>`: how many characters into `<text>` to start printing
  from (`0` prints from the beginning).
- `<max length>`: the maximum number of characters to print. Printing
  also stops early at `<text>`'s own zero terminator, whichever limit is
  hit first.

## Example

```pascal
program PrintStringDemo;
var
	text : string = "HELLO WORLD";
begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring(text,0,40); // whole string

	moveto(0,1,hi(screen_char_loc));
	printstring(text,6,40); // shifted 6 chars in: "WORLD"

	moveto(0,2,hi(screen_char_loc));
	printstring("LITERAL STRING",0,7); // capped to 7 chars: "LITERAL"
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/printstring.ras){ .md-button download }
