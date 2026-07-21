# `repend`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Closes a `repeat N` inline-assembler unrolling block. This is a separate
feature from the Pascal-level [`repeat`](repeat.md)/[`until`](until.md)
loop: it
operates on raw text inside an [`asm`](asm.md) block, duplicating a
sequence of assembler lines a fixed number of times instead of using a
real runtime loop, useful for hand-optimized, branch-free hot code.

## Syntax

    asm
        repeat <count>
            <lines to duplicate>
        repend
    end;

    asm
        repeat <countX> <countY>
            <lines to duplicate>
        repend
    end;

## Parameters

- `<count>`: how many times to duplicate the lines between `repeat` and
  `repend`. Must be a positive whole number.
- `<countX> <countY>`: the two-dimensional form, duplicating the block
  `countX * countY` times, once per combination.

Inside the duplicated lines, `[i]`, `[i+1]`, `[i-1]`, and similar bracketed
expressions (`[i*2]`, `[i*4]`, `[i*8]`, ...) are replaced with the current
iteration's index each time the block is repeated, so each unrolled copy
can compute its own offset.

## Example

```pascal
program RependDemo;
var
	count : byte;

begin
	asm
		ldx #0
		repeat 5
			inx
		repend
		stx count
	end;

	screen_bg_col := count;
	loop();
end.
```

`inx` is duplicated five times in the generated assembly, so `count` ends
up holding 5.

[:material-download: Download this example](../../assets/examples/repend.ras){ .md-button download }

## Known limitations

**A program, procedure, or variable name that happens to start with the
word "repeat" (case-insensitively) can be mistaken for the start of an
unroll block, even in code that never uses `repeat`/`repend` at all.** The
detection works by scanning every line of the already-generated assembly
text for one that starts with "repeat", rather than checking that the
rest of the line actually looks like a valid `repeat <count>` directive.
A program named, say, `RepeatDemo` produces its own name as a label at the
very top of the generated assembly; since that label's text also starts
with "repeat", it gets misread as an unroll directive, fails to parse a
count out of it, and aborts compilation with a "repeat count must be
either 1 or 2-dimensional" error that has nothing to do with the actual
source. The fix is simple: don't start a program, procedure, or variable
name with "repeat" (case-insensitively). Everything else about `repeat`/
`repend` unrolling, including the example above, works correctly once
that naming collision is avoided.
