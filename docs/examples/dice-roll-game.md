# A simple dice-roll mini-game

Press a key to roll a random die and see whether it beat your last roll.
A small, complete loop showing random numbers driving actual game logic,
not just a one-off printed value.

## What this uses

- [`Rand`](../reference/builtins/rand.md) - generates the die roll in a
  fixed `1`-`6` range.
- [`getKey`](../reference/builtins/getkey.md) - detects a keypress to
  trigger each roll, and its release so one press is one roll.
- [`if`/`else`](../reference/keywords/if.md) - compares the new roll
  against the previous one.

```pascal
program DiceRollGame;
var
	roll, previous : byte;
	key : byte;

begin
	clearscreen(key_space,screen_char_loc);
	previous := 0;

	moveto(0,0,hi(screen_char_loc));
	printstring("press any key to roll the die",0,40);

	repeat
		// Wait for a fresh keypress before rolling again.
		repeat
			key := getkey();
		until key<>0;

		rand(1,6,roll); // a new die roll, 1-6 inclusive

		moveto(0,2,hi(screen_char_loc));
		printstring("roll:",0,40);
		moveto(6,2,hi(screen_char_loc));
		printdecimal(roll,1);

		moveto(0,3,hi(screen_char_loc));
		if (previous=0) then
			printstring("first roll!            ",0,40)
		else if (roll>previous) then
			printstring("higher than last time! ",0,40)
		else if (roll<previous) then
			printstring("lower than last time.  ",0,40)
		else
			printstring("same as last time.     ",0,40);

		previous := roll;

		// Wait for the key to be released so one press doesn't register
		// as several rolls in a row.
		repeat
			key := getkey();
		until key=0;
	until false;
end.
```

[:material-download: Download this example](../assets/examples/cookbook/dice-roll-game.ras){ .md-button download }

## How it works

`Rand(1, 6, roll)` stores a fresh random value into `roll` each time
it's called, always inclusive of both `1` and `6`. The outer `repeat`
loop runs forever; each pass first waits for a keypress with its own
inner `repeat...until key<>0` loop, rolls the die, compares the new
result against whatever was rolled last time, and then waits again for
the key to actually be released (`until key=0`) before looping back
around. That release check is what stops one held-down key from
scrolling through dozens of rolls in a fraction of a second. The
messages passed to `PrintString` are all padded to the same length with
trailing spaces, so a shorter message fully overwrites a longer one
that printed there before it.
