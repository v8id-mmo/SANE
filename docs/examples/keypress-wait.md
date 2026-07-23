# Waiting for a keypress

Two related but different patterns: waiting for *any* key, and waiting
for one *specific* key.

## What this uses

- [`getKey`](../reference/builtins/getkey.md) - returns whichever key is
  currently held down, or `0` if none is.
- [`Keypressed`](../reference/builtins/keypressed.md) - checks one named
  key and reports whether it's held down.

```pascal
program KeypressWait;
var
	key : byte = 0;

begin
	clearscreen(key_space,screen_char_loc);
	moveto(4,10,hi(screen_char_loc));
	printstring("press any key to continue...",0,40);

	// getkey() returns 0 until some key is actually held down, so looping
	// until it's non-zero is a simple "wait for any key" pattern.
	repeat
		key := getkey();
	until key<>0;

	clearscreen(key_space,screen_char_loc);
	moveto(4,10,hi(screen_char_loc));
	printstring("thanks! now hold space to quit.",0,40);

	// Keypressed checks one specific, named key instead of "any key at
	// all"; useful once you know exactly which key you're waiting for.
	while (keypressed(KEY_SPACE)=false) do
	begin
	end;

	screen_bg_col := light_green;
	loop();
end.
```

[:material-download: Download this example](../assets/examples/cookbook/keypress-wait.ras){ .md-button download }

## How it works

`getKey` doesn't block by itself, it just returns the current state
immediately, so the `repeat...until key<>0` loop is what actually does
the waiting: it keeps re-reading the keyboard every pass until some key
shows up as pressed. `Keypressed`, further down, works differently: it's
told exactly which key to look for (`KEY_SPACE` here) and only cares
about that one, ignoring every other key entirely. That makes it the
better choice once you know in advance which specific key should
continue the program, rather than accepting whatever key happens to be
pressed first.
