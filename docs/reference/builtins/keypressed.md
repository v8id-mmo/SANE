# `Keypressed`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Directly scans the keyboard matrix for one specific key and reports
whether it's currently held down. Unlike [`getKey`](getkey.md), which
waits for and returns whichever key is pressed, `Keypressed` checks a
single, named key you already know you're looking for, and returns
immediately either way. The result behaves as a `boolean`, so it can be
compared directly with `true`/`false` as well as used as a plain `0`/`1`
byte.

## Syntax

    <boolean> := Keypressed( <key constant> )

## Parameters

- `<key constant>`: one of the `KEY_*` constants (`KEY_SPACE`, `KEY_A`,
  `KEY_0`, and so on), written directly, not through a variable. Any
  other value is a compile-time error.

## Returns

`true`/`1` if the key is currently held down, `false`/`0` otherwise.

## Example

```pascal
program KeypressedDemo;
var
	pressed : byte;
begin
	clearscreen(key_space,screen_char_loc);
	pressed := keypressed(KEY_SPACE);
	moveto(0,0,hi(screen_char_loc));
	printdecimal(pressed,3);

	while (keypressed(KEY_SPACE)=false) do begin
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/keypressed.ras){ .md-button download }
