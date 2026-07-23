# Hello World: printing to the screen

The traditional first program: clear the screen, pick some colors, and
print a message at a specific spot.

## What this uses

- [`ClearScreen`](../reference/builtins/clearscreen.md) - wipes the
  screen to a known blank state before drawing anything.
- [`screen_bg_col`/`screen_fg_col`](../reference/constants.md#screen-and-vic-ii-registers) -
  pre-declared variables for the background/text colors.
- [`MoveTo`](../reference/builtins/moveto.md) - positions the text
  cursor.
- [`PrintString`](../reference/builtins/printstring.md) - prints text at
  the cursor position.

```pascal
program HelloWorld;
var
	// The message we'll print. A plain "string" variable works just as
	// well as a double-quoted literal passed directly to PrintString.
	message : string = "HELLO, C64!";

begin
	// Wipe the screen first so we start from a known, blank state.
	clearscreen(key_space,screen_char_loc);

	// screen_bg_col/screen_fg_col are real variables the compiler
	// pre-declares for you; assigning to them changes the border-free
	// background and text colors immediately.
	screen_bg_col := blue;
	screen_fg_col := light_blue;

	// MoveTo positions the text cursor (column, row); PrintString then
	// prints starting from that position.
	moveto(8,12,hi(screen_char_loc));
	printstring(message,0,40);

	loop(); // keep the program running so the screen stays visible
end.
```

[:material-download: Download this example](../assets/examples/cookbook/hello-world.ras){ .md-button download }

## How it works

`ClearScreen` fills the whole text screen with the space character, so
the program always starts from a blank slate no matter what was on
screen before. Setting `screen_bg_col` and `screen_fg_col` changes the
background and text colors immediately, the same way they'd look if set
from a project's default settings, just done here at runtime instead.

`MoveTo` takes a column (0-39) and a row (0-24) and moves the text
cursor there; nothing is printed until `PrintString` is called
afterward, starting from wherever the cursor was last placed. The final
`loop()` is just an infinite `jmp` back to itself, so the finished
screen stays visible instead of the machine falling through to
whatever comes after the program in memory.
