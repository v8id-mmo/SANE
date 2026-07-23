# Detecting when two sprites touch

Moves one sprite around with the joystick and checks whether it's
touching a second, stationary sprite, a common early step toward
anything with pickups, hazards, or enemies.

## What this uses

- [`SpritePos`](../reference/builtins/spritepos.md) - positions both
  sprites.
- [`Joystick`](../reference/builtins/joystick.md) - moves the player
  sprite around.
- [`IsOverlapping`](../reference/builtins/isoverlapping.md) - checks
  whether the two sprites are within a set distance of each other.

```pascal
program SpriteCollision;
var
	// Sprite 0: a fixed target sitting in the middle of the screen.
	targetX : integer = 160;
	targetY : byte = 100;

	// Sprite 1: the one you move with the joystick.
	playerX : integer = 24;
	playerY : byte = 50;

	touching : byte;

begin
	clearscreen(key_space,screen_char_loc);

	sprite_color[0] := yellow;
	sprite_color[1] := light_red;
	togglebit(sprite_bitmask,0,1);
	togglebit(sprite_bitmask,1,1);

	SpritePos(targetX,targetY,0); // the target never moves again after this

	repeat
		joystick(1);

		if (joystickleft=1) then playerX := playerX - 2;
		if (joystickright=1) then playerX := playerX + 2;
		if (joystickup=1) then playerY := playerY - 2;
		if (joystickdown=1) then playerY := playerY + 2;

		SpritePos(playerX,playerY,1);

		// Treat the two sprites as "touching" once they're within 12
		// pixels of each other on both the X and Y axis.
		touching := IsOverlapping(playerX,playerY,targetX,targetY,12);
		if (touching=1) then
			screen_bg_col := red
		else
			screen_bg_col := black;

		wait(2);
	until false;
end.
```

[:material-download: Download this example](../assets/examples/cookbook/sprite-collision.ras){ .md-button download }

## How it works

`IsOverlapping` isn't a true circular hit-test; it checks the horizontal
gap and the vertical gap between the two points independently, and
reports a hit only when both are within the given distance. That's
usually close enough for a square-ish collision box and is far cheaper
to compute than real distance math, which is why it's the natural first
tool to reach for here. The background color is used as the visible
"hit" signal for simplicity: it flips to red the moment the two sprites
are close enough, and back to black the moment they're not, checked
fresh on every pass through the loop.
