# Writing a custom BASIC loader line

Every compiled SANE program normally starts with an automatic "10 SYS
&lt;address&gt;" BASIC line, generated behind the scenes so a `.prg` loaded
with `LOAD"NAME",8,1` and `RUN` jumps straight into the machine code. This
recipe turns that automatic line off and replaces it with a hand-built one
instead, byte for byte, the same trick real C64 loaders and intros use to
show their own message (a title, a build date, a credit) when the program
is `LIST`ed in BASIC before it's run.

## What this uses

- [`@projectsettings`](../reference/directives/projectsettings.md) with
  `"ignorebasicsysstart"` - turns off the automatic BASIC line entirely.
- [`@projectsettings`](../reference/directives/projectsettings.md) with
  `"startaddress"` - sets where the real program actually starts, which
  the hand-written line's `SYS` call has to point at.
- [`array`](../reference/types/array.md) of
  [`byte`](../reference/types/byte.md) placed with
  [`at`](../reference/keywords/at.md) - lays the BASIC line down at the
  exact memory address BASIC expects it.

```pascal
program CustomBasicLoader;

// SANE normally writes its own "10 SYS <startaddress>" line ahead of every
// compiled program. These two settings turn that automatic line off, so a
// hand-written BASIC line (declared as a raw byte array below) can take
// its place instead.
@projectsettings "ignorebasicsysstart" 1
@projectsettings "startaddress" $0820

var
	// A hand-built BASIC program, byte for byte: line 10, "SYS 2080", then
	// a REM comment that shows up when this program is LISTed in BASIC.
	// 2080 decimal is $0820, the startaddress above.
	basicLoader : array[25] of byte = (
		$18, $08,                                          // link to the next BASIC line (the end-of-program marker below)
		$0a, $00,                                          // line number: 10
		$9e,                                                // SYS token
		$32, $30, $38, $30,                                // "2080" as PETSCII digits
		$3a,                                                // ":"
		$8f,                                                // REM token
		$20,                                                // " "
		$48, $45, $4c, $4c, $4f, $20, $53, $41, $4e, $45,  // "HELLO SANE"
		$00,                                                // end of this line
		$00, $00                                            // end of BASIC program
	) at $0801;

begin
	clearscreen(key_space,screen_char_loc);
	moveto(1,1,hi(screen_char_loc));
	printstring("custom basic loader ran",0,24);
	loop();
end.
```

[:material-download: Download this example](../assets/examples/cookbook/custom-basic-loader.ras){ .md-button download }

## How it works

A BASIC program in memory is a chain of lines, each one starting with a
2-byte pointer to the next line, a 2-byte line number, then the tokenized
line contents, ending in a zero byte. The chain itself ends when a line's
"next line" pointer is `$0000`. The array above builds exactly one such
line by hand at `$0801` (where C64 BASIC programs always begin): its
pointer field points at the two trailing zero bytes, its line number is
10, `$9e` is the tokenized `SYS` keyword followed by the PETSCII digits
`"2080"`, then a `:` and `$8f` (the tokenized `REM` keyword) starts a
comment that runs to the end of the line, here `"HELLO SANE"`. Because
`ignorebasicsysstart` is set, SANE never writes its own competing line at
`$0801`, so this one is free to occupy that space instead. `startaddress`
still has to match the digits typed after `SYS`, since that's the actual
address BASIC's `RUN` (via this line's `SYS` call) jumps to once it hands
off to machine code; get the two out of sync and `SYS` calls into the
middle of nowhere. Typing `LIST` on a real C64 (or in VICE) after loading
this program shows the custom line, `REM` comment and all, instead of the
usual bare `SYS` stub.
