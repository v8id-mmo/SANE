# Examples

Longer, worked example programs, combining several keywords/builtins
into one practical recipe rather than showing just one feature in
isolation. Every example on this site, whether here or on individual
keyword/builtin/operator pages, is compiled with the real CLI as a smoke
test before publishing.

- [Hello World: printing to the screen](hello-world.md): clear the
  screen, set colors, and print a message at a given position.
- [Showing a live counter or score](score-counter.md): a loop that
  redraws a changing decimal number on screen.
- [Moving a sprite with the joystick](joystick-sprite-move.md): read the
  joystick each frame and move a sprite around the screen.
- [Waiting for a keypress](keypress-wait.md): wait for any key, then
  wait for one specific named key.
- [Detecting when two sprites touch](sprite-collision.md): move a
  sprite with the joystick and check it against a fixed target.
- [Simple color raster bars](raster-bars.md): a chained raster
  interrupt painting bands of background color down the screen.
- [A simple dice-roll mini-game](dice-roll-game.md): press a key to
  roll a random die and compare it against your last roll.
- [Normalizing and comparing strings](string-handling.md): convert a
  string's case before comparing it with an exact byte match.
- [A score table with records and arrays](score-table.md): a small
  fixed data table, printed in full and then scanned for the highest
  value.
- [Writing a custom BASIC loader line](custom-basic-loader.md): replace
  the automatic "10 SYS" stub with a hand-built BASIC line of your own.
- [Loading a file from disk with the KERNAL](kernal-file-load.md): the
  three-call `SETLFS`/`SETNAM`/`LOAD` sequence for loading a named file
  into memory at runtime.
- [A simple sprite multiplexer](sprite-multiplex.md): a raster split
  reuses two hardware sprites to draw four independently falling
  objects.
- [Reading a 1351 mouse](mouse-read.md): decode the SID POT registers'
  wrapping motion counter into a moving sprite and a button read.
- [Smooth horizontal scrolling, both directions](smooth-scroll.md): a
  fine-scroll register plus a coarse character-shift step, kept
  symmetric so neither direction flickers or stalls.
- [Streaming a file into multiple memory regions](kernal-stream-load.md):
  `OPEN`/`CHKIN`/`CHRIN` to split one file's contents across several
  destination addresses.
- [A sprite that changes role over time](sprite-state-machine.md): one
  hardware sprite as a crosshair, then a bullet, then an explosion,
  driven by game state rather than raster position.
- [The classic open-border effect](open-border.md): a two-line raster
  handoff removes the top and bottom screen border for the whole frame.
