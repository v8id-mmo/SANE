# `Rand`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Generates a random byte in a given inclusive range, using the SID chip's
noise generator as an entropy source, and stores it in a variable.
Auto-init: the first time `rand(` appears in a file, the compiler
automatically includes the setup routine this builtin needs (arming the
SID's noise waveform for random reads).

## Syntax

    Rand( <low>, <high>, <result> );

## Parameters

- `<low>`: the inclusive lower bound of the random range.
- `<high>`: the inclusive upper bound of the random range.
- `<result>`: a `byte` variable to store the generated value in.

## Example

```pascal
program RandDemo;
var
	r : byte;
begin
	clearscreen(key_space,screen_char_loc);
	rand(0,99,r); // random value in [0,99]
	moveto(0,0,hi(screen_char_loc));
	printstring("random:",0,40);
	moveto(8,0,hi(screen_char_loc));
	printdecimal(r,1); // 2 digits
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/rand.ras){ .md-button download }

## Known limitations

**`Rand` is flagged internally as scheduled for deprecation in favor of
`Random()`**, a different builtin with its own initialization and
calling convention (not yet documented on this site). That deprecation
notice, like every other compiler warning, never actually gets shown
when compiling from the command line, so nothing about using `Rand`
today visibly signals this. `Rand` itself still works correctly; this is
purely a heads-up that its replacement is the recommended long-term
choice.

The smaller the `<low>`-`<high>` range, the slower this builtin runs
(it retries until it lands a value in range), and generating random
numbers while music is also playing through the SID chip interferes
with the music. Precomputing a table of random values once at the start
of a program, rather than calling `Rand` repeatedly during time-critical
code, avoids both issues.
