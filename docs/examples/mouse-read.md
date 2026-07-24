# Reading a 1351 mouse

The 1351 mouse doesn't report an absolute cursor position: it continuously
feeds a wrapping 6-bit motion counter into the SID's paddle inputs, one
axis per POT register, and it's up to your own code to compare each new
reading against the last one to recover how far, and which way, it
moved. This recipe reads both axes correctly, moves a sprite with them,
and reads the mouse's left button off the joystick port it shares wiring
with.

## What this uses

- [`Peek`](../reference/builtins/peek.md)/[`Poke`](../reference/builtins/poke.md) -
  read the SID POT registers and set up the CIA data-direction registers.
- [`SpritePos`](../reference/builtins/spritepos.md) - moves the pointer
  sprite to the tracked position.
- Unsigned `byte` comparisons throughout, on purpose (see How it works).

```pascal
program MouseRead;

var
	const paddleSelect : address = $dc00;
	const potXReg       : address = $d419;
	const potYReg       : address = $d41a;
	const ciaButtons   : address = $dc01;

	mouseX : integer = 160;
	mouseY : byte = 100;
	lastPotX : byte = 0;
	lastPotY : byte = 0;
	raw, diff : byte;
	buttonPressed : boolean;

procedure initMouse();
begin
	poke(^$dc02,0,$c0);       // CIA1 port A DDR: bits 6-7 output (paddle select), rest input
	poke(^$dc03,0,$00);       // CIA1 port B DDR: all input (buttons/pot lines)
	poke(paddleSelect,0,$40); // select paddle/mouse pair 1 (control port 1)
end;

// A 1351 mouse reports motion as a continuously wrapping 6-bit counter on
// SID's POTX/POTY, not an absolute position: each frame the new raw
// reading is compared against last frame's to recover how far, and which
// way, it moved. Written entirely with unsigned byte comparisons on
// purpose, to sidestep this fork's own known limitations with signed
// comparisons.
procedure pollMouse();
begin
	raw := peek(potXReg,0);
	diff := (raw - lastPotX) & $7f;
	lastPotX := raw;
	if diff >= 64 then mouseX := mouseX - (128-diff)
	else mouseX := mouseX + diff;

	raw := peek(potYReg,0);
	diff := (raw - lastPotY) & $7f;
	lastPotY := raw;
	if diff >= 64 then mouseY := mouseY + (128-diff)  // Y is inverted at the hardware level
	else mouseY := mouseY - diff;

	if mouseX < 24 then mouseX := 24;
	if mouseX > 320 then mouseX := 320;
	if mouseY < 50 then mouseY := 50;
	if mouseY > 229 then mouseY := 229;

	buttonPressed := (peek(ciaButtons,0) & 16) = 0; // fire/left button, active low
end;

begin
	clearscreen(key_space,screen_char_loc);
	initMouse();

	sprite_color[0] := white;
	togglebit(sprite_bitmask,0,1);

	repeat
		pollMouse();
		SpritePos(mouseX,mouseY,0);
		if buttonPressed then sprite_color[0] := light_red else sprite_color[0] := white;
		wait(1);
	until false;
end.
```

[:material-download: Download this example](../assets/examples/cookbook/mouse-read.ras){ .md-button download }

## How it works

`initMouse` sets up CIA #1's data-direction registers so port A's top two
bits (`$dc02`, bits 6-7) are outputs and port B (`$dc03`) is entirely
input, then writes `$40` to `$dc00` to select "paddle pair 1", which is
what routes the mouse's analog motion signal (plugged into control port
1) into the SID's `POTX`/`POTY` inputs at `$d419`/`$d41a`. Those two
registers each hold an 8-bit value, but the mouse hardware only ever
moves it within a 6-bit range before wrapping, so `pollMouse` has to
recover the actual step from the *difference* between this frame's raw
reading and last frame's: `(raw - lastPotX) & $7f` masks that difference
down to a 7-bit magnitude, and a result of `64` or higher means the true
step was negative (the counter wrapped backward), recovered as
`128 - diff`. `Y` is inverted at the hardware level, so its two branches
are the mirror image of `X`'s. Every comparison here (`diff >= 64`,
the boundary clamps) is deliberately done on a plain unsigned `byte`
rather than reaching for a `signed` type: this fork's signed comparison
operators only fully support `<`/`<=` today, and this sign-magnitude
technique (an 8-bit hardware convention going back to the 1351's own
official driver) sidesteps that limitation entirely rather than working
around it. The button read follows the same convention as reading a
joystick's fire button: bit 4 of `$dc01`, active low.
