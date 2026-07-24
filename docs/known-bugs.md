# Known Bugs

This page lists every confirmed compiler defect found so far, in one
place. Each one is also explained in more detail on the reference page
for the feature it affects, where one already exists; this page is meant
as an index and quick-reference, not a duplicate of the full writeup.

Fixing all of these is one of the project's [goals](goals.md). None are
fixed yet; once one is, it moves to the [changelog](changelog.md) with
the date of the fix, and this entry gets updated to say so.

Individual reference pages sometimes carry their own "Known limitations"
notes that aren't listed here: those are usually clarifications about how
a feature is *meant* to work (easy to get wrong assumptions about, but not
actually broken), rather than confirmed defects. This page is reserved for
the latter.

## Signed arithmetic

### Signed comparisons: only `<` and `<=` are implemented

**Status:** Open · **Fixed in:** not yet fixed

For signed `integer` (16-bit) values, only the `<` and `<=` operators
work. `>`, `>=`, `=`, and `<>` all fail to compile in the signed case.
Signed `long` (24-bit) comparisons aren't implemented at all, for any
operator.

*Reference pages:* [`<`](reference/operators/less-than.md),
[`<=`](reference/operators/less-or-equal.md),
[`>`](reference/operators/greater-than.md),
[`>=`](reference/operators/greater-or-equal.md),
[`=`](reference/operators/equal.md),
[`<>`](reference/operators/not-equal.md)

### Byte-level signed comparison is suspected to be wrong at the boundaries

**Status:** Suspected, not yet confirmed by testing · **Fixed in:** not
yet fixed

Unlike the 16-bit signed comparison path, the byte-level signed comparison
is missing a correction step that's needed to get the right answer near
the boundary between positive and negative values (comparisons like
`-128` against `127`). This has been traced through the code but not yet
actually run and confirmed; it's listed here as a strong suspicion, not a
confirmed bug, until it's been tested for real.

*Reference pages:* [`<`](reference/operators/less-than.md),
[`<=`](reference/operators/less-or-equal.md),
[`>`](reference/operators/greater-than.md),
[`>=`](reference/operators/greater-or-equal.md)

### Signed multiplication silently gives the wrong result

**Status:** Open · **Fixed in:** not yet fixed

Multiplying two byte values where at least one is a negative signed number
gives a wrong result, with no compile error or warning. Multiplying two
positive values happens to work, since their bit pattern matches the
unsigned case. A correct signed multiply routine already exists elsewhere
in the compiler's bundled code, it just isn't connected to the `*`
operator.

*Reference page:* [`*`](reference/operators/multiplication.md)

### Signed division isn't implemented at all

**Status:** Open · **Fixed in:** not yet fixed

Division always uses unsigned arithmetic, regardless of whether either
operand is a negative signed value. There's no signed-aware division
routine anywhere in the compiler yet to fall back on. `mod`/`mod16`
inherit the identical limitation: `mod16` literally shares `/`'s
16-bit-by-8-bit division routine, and `mod`'s own separate 8-bit routine
is unsigned for the same underlying reason.

*Reference pages:* [`/`](reference/operators/division.md),
[`mod`](reference/builtins/mod.md), [`mod16`](reference/builtins/mod16.md)

### Mixing a signed byte with an integer drops the sign

**Status:** Open · **Fixed in:** not yet fixed

When a `byte` value is combined with an `integer` (16-bit) value (addition,
subtraction, multiplication), the byte's value should be sign-extended
when it's negative (so `-1` becomes `$FFFF`, not `$00FF`). Right now it's
always zero-extended instead, so any negative byte mixed into a wider
expression produces a wrong result. Confirmed in at least two separate
spots in the code generator; there may be more not yet found.

*Reference pages:* [`signed`](reference/keywords/signed.md),
[`+`](reference/operators/addition.md),
[`-`](reference/operators/subtraction.md),
[`*`](reference/operators/multiplication.md)

## Procedures & functions

### Inline procedure parameters aren't reliably evaluated

**Status:** Open · **Fixed in:** not yet fixed

For procedures marked `inline`, passing anything more complex than a
plain variable or literal as a parameter (an array index, a pointer
dereference, a computed expression) can misbehave if the parameter is
referenced more than once inside the procedure body: the expression gets
re-evaluated (or re-inserted as raw text) at every use, instead of being
computed once and reused. The reliable workaround is to copy the value
into a plain local variable first, and pass that instead. This is
confirmed specifically for `inline` procedures; regular (non-inline)
procedures use a different, unaffected mechanism.

*Reference pages:* [`inline`](reference/keywords/inline.md),
[`procedure`](reference/keywords/procedure.md)

### `wedge` compiles to exactly the same code as `interrupt`

**Status:** Open · **Fixed in:** not yet fixed

Declaring a procedure with `wedge` instead of `interrupt` produces
identical generated assembly: same body, same trailing interrupt-return
instruction. In standard C64 terminology, a "wedge" specifically means
chaining a new routine onto an already-installed interrupt vector rather
than replacing it, but nothing about the `wedge` declaration keyword
itself does that; the compiler's actual interrupt-vector-chaining
behavior lives entirely in a separate, unrelated set of builtin functions
(`rasterirqwedge()` and friends), usable regardless of which keyword
declared the procedure they're chaining.

*Reference page:* [`wedge`](reference/keywords/wedge.md)

### `return` doesn't exit an interrupt handler correctly

**Status:** Open · **Fixed in:** not yet fixed

Using a plain `return;` for an early exit partway through an `interrupt`
procedure's body doesn't leave the interrupt the same way reaching the
procedure's own closing `end;` does. Every other exit path of the same
handler, including its natural end, exits correctly; only an explicit
`return;` used before that point is affected. Use `ReturnInterrupt`
instead for an early exit from inside an `interrupt` procedure.

*Reference pages:* [`return`](reference/keywords/return.md),
[`ReturnInterrupt`](reference/builtins/returninterrupt.md)

### `ReturnValue` fails on a function that returns `long`

**Status:** Open · **Fixed in:** not yet fixed

`ReturnValue` correctly sets and returns a `byte`, `integer`, or
`boolean` value. On a function declared to return `long`, it fails to
assemble instead: the build stops with an error at the point this
builtin's code would run. The plain `<functionName> := <value>;` form
works correctly for a `long`-returning function; only `ReturnValue`
itself is affected.

*Reference page:* [`ReturnValue`](reference/builtins/returnvalue.md)

## Builtin auto-initialization

### `sine[]`'s table-fill only looks for usages in the current file

**Status:** Open · **Fixed in:** not yet fixed

A number of builtins (`sine[`, `rand(`, `sqrt(`, `atan2(`, `joystick(`,
and others) automatically insert a setup call the first time the compiler
spots a matching usage anywhere in the source text, so a program doesn't
have to call the setup routine itself. That text scan only looks at
whichever file is currently being compiled, so in principle a usage that
only appears inside a unit file brought in with `use` could be missed.

In practice, testing each of these individually shows only `sine[]` is
actually affected: its auto-inserted setup call fills a 256-byte lookup
table at program start, and if `sine[` is only ever used from inside a
`use`d unit, that fill never runs and `sine[angle]` always returns `0`.
The other builtins in this same auto-init mechanism don't have this
problem in practice, either because their setup is just a self-contained
routine that gets called directly at each actual use (nothing needs to
run ahead of time), or because a separate check at compile time catches
the missing setup and stops the build with an error rather than silently
producing wrong output. The workaround for `sine[]` is to add one real,
uncommented `sine[...]` usage in the main file too.

*Reference page:* [`@use`](reference/directives/use.md)

### `@ignoremethod`'s argument only matches in lowercase

**Status:** Open · **Fixed in:** not yet fixed

`@ignoremethod <name>` is meant to opt a named `init...` routine out of
the automatic-initialization scan described above, so a program can call
that routine itself instead. Writing `<name>` in the routine's normally
documented casing, matching how it's written everywhere else (for example
`@ignoremethod initGetKey`), silently fails to match, and the automatic
insertion stays active alongside the program's own explicit call. For
most `init...` routines this doubling is harmless. For `initGetKey`
specifically it isn't: the build fails outright with a duplicate-symbol
assembly error. Writing the argument in all-lowercase (`@ignoremethod
initgetkey`) works correctly.

*Reference page:* [`@ignoremethod`](reference/directives/ignoremethod.md)

## Loops

### `for`/`fori` always run at least once, and can wrap around instead of skipping

**Status:** Open · **Fixed in:** not yet fixed

Both loop forms only check whether they're done *after* running the loop
body, never before the first pass. So a loop whose end value is already
behind its start value, `for i:=5 to 0 do ...` for instance, doesn't just
skip the loop: it runs the body once, then keeps counting up and wrapping
around the full byte range before it happens to land back on the end
value, running far more times than intended.

*Reference pages:* [`for`](reference/keywords/for.md),
[`fori`](reference/keywords/fori.md)

### `unroll` always treats a `fori` loop's end value as exclusive

**Status:** Open · **Fixed in:** not yet fixed

Adding `unroll` to a `for` loop expands it into repeated, literal copies
of the body at compile time instead of a runtime loop. On a `fori` loop,
which is normally inclusive of its end value, `unroll` silently switches
it back to `for`'s exclusive behavior: `fori i:=0 to 3 unroll do ...`
only emits copies for `i = 0, 1, 2`, dropping the `i = 3` pass a
non-unrolled `fori` loop always runs. A plain, non-unrolled `fori` loop is
unaffected and correctly includes the end value.

*Reference page:* [`unroll`](reference/keywords/unroll.md)

## Preprocessor directives

### `case ... else <single statement>; end;` desyncs the parser

**Status:** Open · **Fixed in:** not yet fixed

A `case` statement whose `else` branch is a single statement (not wrapped
in its own `begin...end`) fails to compile, but the reported error points
at the very end of the file instead of at the actual problem, since the
parser loses track of one `end` and everything after it shifts by one.
Wrapping the `else` branch in `begin ... end` works around it.

*Reference page:* [`case`](reference/keywords/case.md)

### `absolute` isn't accepted on pointer declarations

**Status:** Open · **Fixed in:** not yet fixed

`absolute` and `at` are meant to be interchangeable ways to place a
variable at a fixed memory address, and are, for plain variables. On a
pointer declaration, though, only `at` is actually recognized; `absolute`
is silently not accepted there.

*Reference page:* [`absolute`](reference/keywords/absolute.md)

### `@bin2inc`'s own output can't be `@include`d in the same compile

**Status:** Open · **Fixed in:** not yet fixed

A file that both generates an include file with `@bin2inc` and
`@include`s that same file in the same compile fails on a clean build,
even though `@bin2inc` runs first. The generated file only becomes
`@include`-able starting from the next compile onward. The workaround is
to generate it with one compile first, then `@include` it from a separate
compile.

*Reference page:* [`@bin2inc`](reference/directives/bin2inc.md)

### `@vbmcompilechunk`'s own output can't be `@include`d in the same compile

**Status:** Open · **Fixed in:** not yet fixed

The same issue as `@bin2inc` above, confirmed separately for this
directive: a file that both runs `@vbmcompilechunk` and `@include`s the
file it just generated fails on a clean build, even though
`@vbmcompilechunk` runs first. The workaround is the same: generate the
file with one compile first, then `@include` it from a separate compile.

*Reference page:* [`@vbmcompilechunk`](reference/directives/vbmcompilechunk.md)

### `@donotprefix <symbol>` never compiles

**Status:** Open · **Fixed in:** not yet fixed

Unlike its sibling directive `@donotprefixunit` (which takes no argument
and works fine), `@donotprefix <symbolName>` fails to compile in every
configuration tested: the directive reads its symbol-name argument but
never actually consumes it from the token stream, desyncing everything
parsed afterward, the same failure shape as the `case`/`else` bug above.

*Reference page:* [`@donotprefix`](reference/directives/donotprefix.md)

### `@ignoresystemheaders` has no effect

**Status:** Open · **Fixed in:** not yet fixed

The directive compiles cleanly and doesn't error, but nothing else in the
compiler actually reads the flag it sets. Using it doesn't change the
compiled output in any observable way.

*Reference page:*
[`@ignoresystemheaders`](reference/directives/ignoresystemheaders.md)

### `@use KrillsLoader` requires one exact casing/spacing, or it fails

**Status:** Open · **Fixed in:** not yet fixed

After parsing the directive's three address values, the compiler
regenerates what it considers the "correct" textual form of the line and
checks whether that exact string appears verbatim in the source file. In
practice this means the directive name has to be written exactly
`KrillsLoader` (capitalized just so), even though every other directive in
the language is matched case-insensitively; a lowercase `krillsloader`
with the identical, valid address values fails to compile.

*Reference page:* [`krillsloader`](reference/keywords/krillsloader.md)

### No compiler warning is ever shown when compiling from the command line

**Status:** Open · **Fixed in:** not yet fixed

This isn't specific to any one directive: every warning the compiler
produces goes silent when compiled from the command line, not just
`@raisewarning`'s. The directive (or the built-in check that triggers a
warning) runs and compilation finishes normally, but the warning text is
never printed anywhere: not to the terminal, not into the compiled
output. For example, calling `getKey()` internally queues a deprecation
notice, but it never surfaces either. It was only ever wired up to be
read by the old graphical editor's own output pane, which no longer
exists in this command-line-only fork. `@raiseerror`, by contrast, does
still show its message and stop compilation, since aborting works
through a different mechanism.

*Reference pages:* [`@raisewarning`](reference/directives/raisewarning.md),
[`getKey`](reference/builtins/getkey.md)

### `@startblock` doesn't notice a missing or nested `@endblock`

**Status:** Open · **Fixed in:** not yet fixed

Opening a new `@startblock` region while a previous one is still open
(no `@endblock` in between) is accepted silently: the active
fixed-address region just switches to the new one, with no error or
warning. The reverse mistake, an `@endblock` with nothing open to close,
does raise a clear error, so this asymmetry is easy to trust past its
actual safety.

*Reference page:* [`@startblock`](reference/directives/startblock.md)

## Compression

### `compressed`/`@compress` output can't be decompressed at runtime

**Status:** Open · **Fixed in:** not yet fixed

Both the `compressed` variable flag and the `@compress` build directive
shrink data using LZ4 compression, but there is currently no builtin that
can decompress LZ4 data from within a running program. The only builtin
decompressor (`decrunch()`) only understands a completely different
format (Exomizer) and only accepts a different kind of input to begin
with. On top of that, `compressed` and `@compress` don't even produce the
same LZ4 container as each other, so they aren't interchangeable either.
Right now, the only working "compress at build time, decompress at
runtime" path is pre-compressing data offline with an external tool and
loading it with `decrunch()`, not `compressed`/`@compress`.

*Reference pages:* [`compressed`](reference/keywords/compressed.md),
[`@compress`](reference/directives/compress.md)

## Image/asset import/export directives

### `@importchar` never actually copies the character it's asked to

**Status:** Open · **Fixed in:** not yet fixed

`@importchar` compiles without error and both the source and destination
assets load successfully, but the actual step that copies one character's
data across is unimplemented for every asset type this fork can produce.
The destination file is saved back to disk completely unchanged. Only one
unrelated, non-C64 asset type has a working implementation of this step.

*Reference page:* [`@importchar`](reference/directives/importchar.md)

### `@exportblackwhite`/`@exportframe` only work for one asset type each

**Status:** Open · **Fixed in:** not yet fixed

Both directives compile without error for any input asset, but silently
produce an empty output file for every asset type except the one each was
actually implemented for (`@exportframe` additionally has a second
implementation that's a dead stub, contributing to the same silent-empty
outcome for the asset types routed through it). There's no warning when
this happens, the build just quietly produces nothing useful.

*Reference pages:*
[`@exportblackwhite`](reference/directives/exportblackwhite.md),
[`@exportframe`](reference/directives/exportframe.md)

### `@spritecompiler` never produces any output

**Status:** Open · **Fixed in:** not yet fixed

The directive compiles cleanly and validates that its input file exists,
but never actually generates anything: on a C64 build the underlying
image-processing step it calls is an empty stub, and even on the handful
of other targets where that step does generate something, the result is
computed and then thrown away internally rather than making it into the
compiled output. There is currently no target this fork ships with where
`@spritecompiler` does anything useful.

*Reference page:* [`@spritecompiler`](reference/directives/spritecompiler.md)

### `@pathtool` never compiles, in any configuration

**Status:** Open · **Fixed in:** not yet fixed

The directive's own work (fitting a curve through the input points and
writing the three output files) runs successfully, but something
afterward leaves the parser out of sync with the rest of the file. The
resulting error is reported far from the actual problem, worded as if a
`begin` were missing rather than pointing at the `@pathtool` line. This
happens no matter where the directive is placed.

*Reference page:* [`@pathtool`](reference/directives/pathtool.md)

### `@perlinnoise`'s exported data isn't clamped, but its preview image is

**Status:** Open · **Fixed in:** not yet fixed

With a high enough amplitude/power setting, the raw noise bytes written to
the output file can wrap or truncate outside the normal 0-255 range at
some pixels, while the `.png` preview saved alongside it is clamped and
looks completely clean at those same pixels. The preview can't be trusted
to catch an out-of-range setting; only the actual exported data can.

*Reference page:* [`@perlinnoise`](reference/directives/perlinnoise.md)

## Object model

### `private`/`public` are reserved but completely non-functional

**Status:** Open · **Fixed in:** not yet fixed

Both keywords are reserved (so a field or method can't be named `private`
or `public`), but neither is actually read anywhere while parsing a
`class`/`record` body. Writing a visibility section the way the keywords'
names suggest fails to compile immediately, rather than being accepted
and ignored. Every class/record member is effectively public; there is
currently no way to mark one private.

*Reference page:* [`private`](reference/keywords/private.md)

### Whole-record assignment always fails

**Status:** Open · **Fixed in:** not yet fixed

Assigning one record (or class) variable directly to another of the same
type, with no field selector on either side, always fails to compile
with an error saying a record can't be assigned to a single variable.
This happens for every record/class shape, not just ones with array
fields. Field-by-field assignment works and is the only way around it for
now: copy each field individually instead of the whole value at once.

*Reference page:* [`record`](reference/types/record.md)

## Types

### A non-`const` `address` variable is completely unusable

**Status:** Open · **Fixed in:** not yet fixed

Every real usage of the `address` type declares it as a `const`. Declaring
one as a plain `var` instead fails to compile with a codegen error, with
or without an initial value, and whether or not the variable is ever
referenced anywhere in the program. Reading it, writing to it, and
passing it to a builtin all fail the same way. Use `const` for a fixed
memory location, or `pointer` for something that genuinely needs to
change at runtime.

*Reference page:* [`address`](reference/types/address.md)

## Branch optimization

### `onpage`/`offpage` have gaps on `case` and `repeat...until`, and no safety net when forcing `onpage`

**Status:** Open · **Fixed in:** not yet fixed

`onpage`/`offpage` on a `case` statement parse without error but have no
effect on the generated code either way. Neither keyword can be used on a
`repeat...until` loop at all: writing one there desyncs the parser instead
of applying the override, even though the code generator has full,
working support for both directions in that spot. And on `if`/`while`/
`for`, forcing `onpage` (the short-branch direction) skips the size check
that normally decides automatically, so forcing it on a block that turns
out too large produces a broken branch with no warning.

*Reference pages:* [`onpage`](reference/keywords/onpage.md),
[`offpage`](reference/keywords/offpage.md)

## Inline assembler

### A program, procedure, or variable name starting with "repeat" can trigger an unrelated unrolling error

**Status:** Open · **Fixed in:** not yet fixed

The inline-assembler unrolling feature (`repeat N` / `repend`) is
detected by scanning the generated assembly line by line for anything
that starts with the word "repeat", rather than checking for the actual
"repeat, followed by a number" shape. A program, procedure, or variable
whose name happens to start with those same letters (`RepeatDemo`, for
example) produces a line in the generated assembly that starts the same
way, so it gets mistaken for the start of an unrolling block. Compilation
then fails with a count-parsing error that has nothing to do with the
actual source, even in a project that never uses `repeat`/`repend`
unrolling at all. The ordinary Pascal `repeat...until` loop is unaffected
by this and works correctly on its own; only the name collision with the
unrelated assembler feature causes the failure.

*Reference pages:* [`repeat`](reference/keywords/repeat.md),
[`repend`](reference/keywords/repend.md)

## Bitwise operators

### Signed right shift is always a logical shift, never arithmetic

**Status:** Open · **Fixed in:** not yet fixed

Shifting a negative signed value right with `shr`/`>>` gives a wrong
(positive) result instead of preserving the sign. The shift always fills
the vacated high bits with `0`, the same way it would for an unsigned
value, rather than replicating the sign bit the way a proper arithmetic
right shift needs to. A `signed byte` holding `-8`, shifted right by one,
produces `124` instead of the mathematically correct `-4`.

*Reference page:* [`shr`](reference/operators/shift-right.md)

### `long` bitwise AND/OR/XOR silently miscompute the result with a non-trivial right-hand operand

**Status:** Open · **Fixed in:** not yet fixed

`&`, `|`, and `xor`/`^` between two 24-bit `long` values work correctly
when the right-hand side is a plain variable. As soon as the right-hand
side is a more complex expression (an addition, for example), two
separate things go wrong at once: the top byte of the result isn't
combined with the operator at all, it's simply overwritten with the
right-hand expression's own top byte; and the middle byte can come out
one off from the correct value, because of leftover state from evaluating
the right-hand expression bleeding into the result.

*Reference pages:* [`&`](reference/operators/bitwise-and.md),
[`|`](reference/operators/bitwise-or.md), [`xor`](reference/operators/xor.md)

### `xor` used to combine two conditions always evaluates true

**Status:** Open · **Fixed in:** not yet fixed

Writing `xor` between two parenthesized conditions, like
`(a>5) xor (b<3)`, compiles without any error, but the resulting
condition always behaves as true, no matter what either side actually
evaluates to; the `else` branch of an `if` using this pattern becomes
unreachable. Both conditions are evaluated correctly, but the step that's
supposed to combine them with `xor` and branch on the result is missing:
only `and`/`or` are actually wired up to combine two conditions this way.
Plain bitwise `xor`/`^` between two numeric values is unaffected and
works correctly; this only affects `xor` written between two parenthesized
conditions.

*Reference page:* [`xor`](reference/operators/xor.md)

## Logical operators

### `not` on a wider-than-byte value only complements the low byte

**Status:** Open · **Fixed in:** not yet fixed

`not` on an `integer` or `long` value should flip every bit, but only the
low byte actually gets flipped; the upper byte(s) pass straight through
unchanged instead of being complemented too. `not` on an `integer`
holding `$00FF` should give `$FF00`, but actually gives `$0000`. `not` on
a plain `byte` is unaffected and works correctly.

*Reference page:* [`not`](reference/operators/not.md)

### `not` can't negate a comparison the way it looks like it should

**Status:** Open · **Fixed in:** not yet fixed

Writing `not (a > 5)`, with the comparison in parentheses, fails to
compile at all. Writing it without the parentheses, `not a > 5`, does
compile, but silently means something different from what it looks like:
it computes `not a` (a bitwise complement) first, and only then compares
that complemented value against `5`, instead of negating the result of
`a > 5`. For `a = 10`, this reads as `(not 10) > 5`, which comes out
true, the opposite of the intended `not (10 > 5)`, which should be false.
`not`
directly in front of a plain boolean value or variable (not a
comparison), like `if not someFlag then`, is unaffected and works
correctly.

*Reference page:* [`not`](reference/operators/not.md)

## Builtins

### `Lo`, `Hi`, and `bankbyte` are all a silent no-op on a `long` value

**Status:** Open · **Fixed in:** not yet fixed

`Lo`, `Hi`, and `bankbyte` correctly return the low, high, and third
(bits 16-23) byte of a `pointer` value. On a `long` value, this fork's
other 24-bit type, all three produce no code at all: the destination
variable ends up holding whatever was already in the processor's
accumulator at that point in the program, not any byte of the `long`
value. There's no error or warning, the assignment just silently does the
wrong thing. All three share one underlying implementation, so this isn't
three separate bugs, just one gap that happens to surface under three
different names.

*Reference pages:* [`Lo`](reference/builtins/lo.md),
[`Hi`](reference/builtins/hi.md), [`bankbyte`](reference/builtins/bankbyte.md)

### `Abs` only negates the low byte of a `long` value

**Status:** Open · **Fixed in:** not yet fixed

`Abs` correctly returns the absolute value of a negative `byte` or
`integer`. On a `long` value it silently falls back to the plain `byte`
logic: it checks the sign bit of the wrong byte (the low byte instead of
the high byte, where a 24-bit value's sign actually lives) and, even when
that happens to trigger, only negates that one byte, leaving the other two
completely unchanged.

*Reference page:* [`Abs`](reference/builtins/abs.md)

### `CopyBytesShift`'s rotate-right mode never actually rotates

**Status:** Open · **Fixed in:** not yet fixed

`CopyBytesShift` supports four modes: shift left, shift right, rotate
left, and rotate right. Rotate left works correctly at any shift amount.
Rotate right instead silently behaves exactly like plain shift right at
every shift amount, including a single shift: the bit that falls off the
bottom is simply discarded and a `0` is always shifted in from the top,
instead of the discarded bit wrapping back around to the top the way a
real rotate should. Rotating `%10000001` right by one gives `%11000000`
in a correct rotate, but this builtin gives `%01000000`.

*Reference page:* [`CopyBytesShift`](reference/builtins/copybytesshift.md)

### A literal numeric address fails for a handful of builtins

**Status:** Open · **Fixed in:** not yet fixed

Passing a bare numeric address literal (e.g. `$ffea`) directly as an
argument to `Call`, `ClearBitmap`, `CopyCharsetFromRom`, `CopyFullScreen`,
`CopyHalfScreen`, or `TransformColors` compiles without any error, but
fails at the assembly stage right afterward, with an "opcode not
implemented" error. The
generated instruction ends up in an invalid form (an addressing mode that
doesn't exist for that instruction) because the literal gets formatted
the same way it would be for loading it into a register, not for using it
as a memory address. Routing the exact same address through a named
constant, a `^`-prefixed literal, or a pointer/variable works correctly
in every case.

`Poke` has the same symptom (a bare numeric literal address fails, a
named constant/`^`-prefixed literal/pointer all work) but fails earlier
and more clearly, with a plain "must be a variable or address" error at
compile time rather than a confusing assembly-stage failure. `Peek`, the
matching read builtin, is unaffected either way: a bare numeric literal
address works correctly there.

*Reference pages:* [`Call`](reference/builtins/call.md),
[`ClearBitmap`](reference/builtins/clearbitmap.md),
[`CopyCharsetFromRom`](reference/builtins/copycharsetfromrom.md),
[`CopyFullScreen`](reference/builtins/copyfullscreen.md),
[`CopyHalfScreen`](reference/builtins/copyhalfscreen.md),
[`TransformColors`](reference/builtins/transformcolors.md),
[`Poke`](reference/builtins/poke.md)

### `CopyCharsetFromRom` only copies part of the character ROM

**Status:** Open · **Fixed in:** not yet fixed

`CopyCharsetFromRom` is meant to copy the full 2048-byte character ROM
font to RAM in one call. Its copy loop is built from 8 chunks that are
each supposed to cover one non-overlapping 256-byte page, but they're
actually spaced only 100 bytes apart, so they heavily overlap each other
and the last chunk stops well short of the end. Well over half of the
character ROM is never copied at all, while the bytes that are covered
get copied several times over.

*Reference page:*
[`CopyCharsetFromRom`](reference/builtins/copycharsetfromrom.md)

### `CopyCharsetFromRom` disables interrupts and never turns them back on

**Status:** Open · **Fixed in:** not yet fixed

`CopyCharsetFromRom` disables interrupts partway through (needed to
safely bank in the character ROM for reading) but never re-enables them
afterward. There is no interrupt re-enable instruction anywhere in the
generated program for a call to this builtin. Any program that calls this
and doesn't separately set up its own interrupt handling afterward will
silently run with interrupts permanently off from that point on, breaking
keyboard input and other interrupt-driven behavior.

*Reference page:*
[`CopyCharsetFromRom`](reference/builtins/copycharsetfromrom.md)

### `CopyImageColorData` silently accepts an invalid bank number

**Status:** Open · **Fixed in:** not yet fixed

`CopyImageColorData`'s bank parameter is meant to be 1, 2, or 3. Passing
any other value (0, or 4 and above) compiles and assembles without any
error or warning, but silently produces the exact same addresses as bank
0, not an error and not the (nonexistent) address an out-of-range bank
number would suggest.

*Reference page:*
[`CopyImageColorData`](reference/builtins/copyimagecolordata.md)

### `CreateInteger` and `CreatePointer` are the same builtin under two names

**Status:** Open · **Fixed in:** not yet fixed

`CreatePointer` sounds like it should build a result usable as a
`pointer`, distinct from `CreateInteger`. In practice the two compile to
byte-for-byte identical assembly: both always put the high byte in the Y
register, and neither ever loads, stores, or touches the X register.
Assigning the result of `CreatePointer` to a `pointer` variable produces
exactly the same code as assigning `CreateInteger`'s result to an
`integer` variable.

*Reference pages:* [`CreateInteger`](reference/builtins/createinteger.md),
[`CreatePointer`](reference/builtins/createpointer.md)

### `FillFast` writes one byte more than it's told to

**Status:** Open · **Fixed in:** not yet fixed

`FillFast(address, value, count)` is meant to fill exactly `count` bytes,
the same as the plain `Fill` builtin. `Fill` does that correctly, but
`FillFast`'s loop always runs one extra time, so it actually writes
`count + 1` bytes, silently overwriting one byte past the range the
caller asked for every time it's used.

*Reference page:* [`FillFast`](reference/builtins/fillfast.md)

### `FLD` runs 256 times instead of 0 when given a count of 0

**Status:** Open · **Fixed in:** not yet fixed

`FLD(count, mode)` is meant to repeat one step of the effect `count`
times. Its loop always executes the step at least once before checking
the count, so passing a count of 0 doesn't skip the effect: the counter
wraps around instead, and the step ends up running 256 times.

*Reference page:* [`FLD`](reference/builtins/fld.md)

### `InitKrill` disables interrupts and never turns them back on

**Status:** Open · **Fixed in:** not yet fixed

`InitKrill` disables interrupts partway through installing Krill's
loader into memory but never re-enables them afterward, the same gap as
`CopyCharsetFromRom` above, in a separate routine. A program that needs
interrupts running once the loader is installed (a raster IRQ, for
example) has to re-enable them itself.

*Reference page:* [`InitKrill`](reference/builtins/initkrill.md)

### `LeftBitShift`/`RightBitShift` always rotate, never actually shift

**Status:** Open · **Fixed in:** not yet fixed

Both builtins are named and used as a "shift" across a block of 8-row
character/bitmap data, `num` bytes wide. At every width, including the
simplest case (a single byte, 8 rows), the bit that shifts off one end of
the block doesn't get dropped the way a real shift would drop it: it
reappears at the opposite end instead. That's a rotate, not a shift, with
no way to ask for the non-wrapping version. It's usable behavior (one of
the bundled tutorials leans on the wraparound on purpose for a scrolling
effect), just not what the name promises.

*Reference page:* [`LeftBitShift`](reference/builtins/leftbitshift.md)

### `MemCpy`/`MemCpyFast` copy 256 bytes instead of 0 when given a runtime count of 0

**Status:** Open · **Fixed in:** not yet fixed

Both builtins are meant to copy exactly `count` bytes. Their copy loops
only check whether they're done *after* copying a byte, never before the
first pass, the same "always runs at least once" shape as `FLD`'s count-of-0
case above. So if `count` is a runtime value that happens to be 0 (not a
literal `0` written in the source), neither one copies zero bytes: both
wrap all the way around and copy a full 256 bytes instead, silently
overwriting whatever memory follows the destination. `MemCpyUnroll`/
`MemCpyUnrollReverse` don't have this problem, since their count has to be
a fixed value known at compile time, and a compile-time 0 there correctly
produces no copy at all.

*Reference pages:* [`MemCpy`](reference/builtins/memcpy.md),
[`MemCpyFast`](reference/builtins/memcpyfast.md)

### `min`/`max` compare bytes as unsigned, with no signed handling at all

**Status:** Open · **Fixed in:** not yet fixed

`min`/`max` pick the smaller/larger of two `byte` values using a plain
unsigned comparison. On a `signed byte`, any pair straddling the sign
boundary comes out wrong: `min(-1, 1)` returns `1` instead of `-1`,
because `-1`'s bit pattern is unsigned-larger than `1`'s. This is a
stricter gap than the signed-comparison operators above: those at least
attempt a signed-aware branch, even if it's imperfect at the boundary;
`min`/`max` don't attempt signed handling at all.

*Reference pages:* [`min`](reference/builtins/min.md),
[`max`](reference/builtins/max.md)

### `PrintNumber`/`PrintDecimal` fail unless `MoveTo`, `PrintString`, or `Tile` is also used somewhere

**Status:** Open · **Fixed in:** not yet fixed

Using `PrintNumber` or `PrintDecimal` with no `MoveTo`, `PrintString`, or
`Tile` call anywhere else in the whole compiled program fails at the
assembly stage with an "unknown operation" error. Adding a single
`MoveTo` (or `PrintString`/`Tile`) call anywhere in the same compile,
whether or not it's the one that actually runs at that point in the
program, is enough to make the exact same `PrintNumber`/`PrintDecimal`
call work. In practice this rarely bites, since real programs almost
always call `MoveTo` to position the cursor before printing anything
anyway, but `PrintNumber`/`PrintDecimal` used on their own, with nothing
else positioning the screen cursor anywhere in the program, hits this.

*Reference pages:* [`PrintNumber`](reference/builtins/printnumber.md),
[`PrintDecimal`](reference/builtins/printdecimal.md),
[`MoveTo`](reference/builtins/moveto.md)

### `PlaySound`'s two waveform parameters both write the same register

**Status:** Open · **Fixed in:** not yet fixed

`PlaySound` takes two separate "waveform" parameters, meant to set the
sound chip's control register twice: once to trigger the note and once
to release it. Both are written to the exact same register back to back
with nothing in between, so the first write is immediately overwritten
by the second before it can have any effect. Only the second waveform
parameter's value ever actually reaches the sound chip; the first is
silently discarded every time.

*Reference page:* [`PlaySound`](reference/builtins/playsound.md)

### `RasterIRQWedge`'s KERNAL-vector mode never compiles

**Status:** Open · **Fixed in:** not yet fixed

`RasterIRQWedge` takes the same hardware-vector-or-KERNAL-vector mode
parameter `RasterIRQ` does. The hardware-vector mode works; the
KERNAL-vector mode always fails to compile, with an error stating
outright that it isn't implemented. Every real usage of this builtin, in
this fork's own bundled tutorials included, uses the hardware-vector
mode for exactly this reason. `RasterIRQ` itself has no such gap; both
modes work there.

*Reference page:* [`RasterIRQWedge`](reference/builtins/rasterirqwedge.md)

### `ScrollX`/`ScrollY` don't range-check their own input value

**Status:** Open · **Fixed in:** not yet fixed

Both builtins expect a value from `0` to `7`. Both correctly mask the
VIC-II register's *existing* contents before combining in the new value,
but neither masks the value passed in. A value outside `0`-`7` gets
OR'd straight into the register, silently flipping unrelated bits:
for `ScrollX`, the 38/40-column select or multicolor-mode bits of the
scroll register; for `ScrollY`, the 24/25-row select, display-enable, or
extended-color-mode bits of its register. Programs that keep their own
scroll counter masked to `0`-`7` before calling either builtin never hit
this; nothing inside the builtin itself enforces the range.

`ScrollY` has a second, independent quirk: every call unconditionally
clears the raster-compare high bit of its register, regardless of the
value passed in. If a raster interrupt has been set up on a line at or
past 256 (which needs that high bit set), calling `ScrollY()` afterward
silently disarms it.

Both builtins also depend on a specific project setting
(`temp_zeropages`) being non-empty; if it's blank, both silently do
nothing at all; no error, no assembly emitted for the call.

*Reference pages:* [`ScrollX`](reference/builtins/scrollx.md),
[`ScrollY`](reference/builtins/scrolly.md)

### `SetBank` writes the whole banking register unmasked

**Status:** Open · **Fixed in:** not yet fixed

`SetBank` selects which 16KB region the VIC-II reads video data from by
writing to a CIA chip register that also carries the serial (IEC) bus
and RS-232 output lines in its other bits. `SetBank` writes its value
straight to that register with no read-modify-write step, so every call
also forces those other lines low as a side effect. This is harmless in
the overwhelming majority of programs, since disk/tape activity has
normally already finished by the time `SetBank` gets called, but it's a
real hazard for any custom fastloader or serial-bus code that calls
`SetBank` while a transfer might still be active.

*Reference page:* [`SetBank`](reference/builtins/setbank.md)

### `SetBitmapMode` overwrites its whole register instead of changing one bit

**Status:** Open · **Fixed in:** not yet fixed

Switching into bitmap mode should only need to change one bit of the
relevant VIC-II register. Every sibling mode-toggle builtin
(`SetTextMode`, `SetMultiColorMode`, `SetRegularColorMode`) correctly
changes only the bit(s) it needs to, leaving everything else in the
register alone. `SetBitmapMode` instead overwrites the entire register
with one fixed value. In practice this silently resets the vertical
fine-scroll value to a fixed default and clears the raster-compare high
bit, so calling `SetBitmapMode` after a `ScrollY` call, or after arming a
raster interrupt on a line at or past 256, undoes part of that earlier
setup with no warning.

*Reference page:* [`SetBitmapMode`](reference/builtins/setbitmapmode.md)

### `SetMemoryConfig(1, 0, 0)` silently writes a different value than requested

**Status:** Open · **Fixed in:** not yet fixed

`SetMemoryConfig` takes three arguments and computes a byte value from
them to write to the CPU's memory-configuration port. For exactly one
combination of arguments, `(1, 0, 0)`, which also happens to be by far
the most common way this builtin gets called in practice, the compiler
silently substitutes a different value for the third argument before
computing the byte it writes, rather than using the value actually
passed in. This particular substitution doesn't change which ROM/RAM
ends up mapped in, so most programs never notice, but it does mean the
exact byte value ends up different from what a plain reading of the
three arguments would predict, which matters for any code that reads
that port back directly and compares it against an expected value.

*Reference page:* [`SetMemoryConfig`](reference/builtins/setmemoryconfig.md)

### `SpritePos` with sprite number 8 or higher corrupts VIC-II registers

**Status:** Open · **Fixed in:** not yet fixed

`SpritePos` expects a sprite number from `0` to `7`, matching the eight
hardware sprites. That range isn't enforced anywhere. If the sprite
number is a compile-time constant of `8` or higher, the position writes
don't land on a nonexistent ninth sprite, they land squarely on two core
VIC-II registers instead: the sprite-MSB register (which tracks each
sprite's 9th X-position bit) and the VIC-II's main control register
(screen on/off, text/bitmap mode, Y-scroll, and the raster-compare high
bit). Calling `SpritePos(x, y, 8)` silently corrupts core display state
on every call instead of failing to compile.

*Reference page:* [`SpritePos`](reference/builtins/spritepos.md)

### `SetSpriteLoc` doesn't range-check its own bank or sprite-number arguments

**Status:** Open · **Fixed in:** not yet fixed

`SetSpriteLoc`'s own compile error message for its bank argument says it
"must be constant 0-3", but only "is this actually a constant" gets
checked, not whether the constant is inside that range. A bank value of
`4` or higher compiles cleanly and computes an address outside the
sprite-pointer table it's meant to target. Its sprite-number argument has
no range check at all, so a value outside the real `0`-`7` hardware range
silently writes past the 8-byte sprite-pointer table into whatever memory
follows it, again with no error.

*Reference page:* [`SetSpriteLoc`](reference/builtins/setspriteloc.md)

### `EnableRasterIRQ` (and `StartRasterChain`) overwrite the whole VIC-II control register, and can't reach raster lines past 255

**Status:** Open · **Fixed in:** not yet fixed

`EnableRasterIRQ` is meant to turn on the raster-interrupt source, a
single-bit change in one register. It does that correctly, but
immediately follows it with an unconditional overwrite of the VIC-II's
entire main control register with one fixed value, the same "hardcoded
overwrite instead of a masked change" shape already documented for
`SetBitmapMode` above. This silently resets the vertical fine-scroll
value and turns off bitmap/extended-color mode, regardless of anything
set up beforehand. `StartRasterChain` calls `EnableRasterIRQ` internally
as part of its own one-call setup, so it inherits the exact same side
effect.

That fixed value also always clears the raster-compare high bit rather
than setting it, and `RasterIRQ` (the builtin that actually arms a
raster line) never sets that bit either. Between the two, there's
currently no way to trigger a raster interrupt on a line at or past 256
through `RasterIRQ`, `EnableRasterIRQ`, or `StartRasterChain`; only lines
`0`-`255` work.

*Reference pages:* [`EnableRasterIRQ`](reference/builtins/enablerasterirq.md),
[`RasterIRQ`](reference/builtins/rasterirq.md),
[`StartRasterChain`](reference/builtins/startrasterchain.md)

### `RasterIRQ`, `RasterIRQWedge`, and `StartIRQWedge` crash the compiler on a bad argument instead of erroring

**Status:** Open · **Fixed in:** not yet fixed

Three related builtins skip validating an argument that's used
unconditionally right after, so a malformed call doesn't produce a
compile error, it crashes the compiler process itself:

- `RasterIRQ`, and by extension `StartRasterChain` (which calls it
  internally): passing something other than an interrupt procedure
  reference as the first argument.
- `RasterIRQWedge`: the same gap on its first argument, plus no check
  that its mode argument is a compile-time constant.
- `StartIRQWedge`: no check that its one argument is a compile-time
  constant. Its sibling `StartIRQ` correctly rejects a non-constant
  argument with a clean compile error; `StartIRQWedge` doesn't do the
  same check.

*Reference pages:* [`RasterIRQ`](reference/builtins/rasterirq.md),
[`RasterIRQWedge`](reference/builtins/rasterirqwedge.md),
[`StartIRQWedge`](reference/builtins/startirqwedge.md),
[`StartRasterChain`](reference/builtins/startrasterchain.md)

### `Sqrt` silently compiles to nothing if not enough zero-page scratch is configured

**Status:** Open · **Fixed in:** not yet fixed

`Sqrt` needs 4 of the project's internal zero-page scratch slots to hold
its working state while it computes. The shipped default project
settings always provide all 4, so this doesn't affect a normal project,
but if a project's settings provide fewer than 4, a call to `Sqrt`
silently compiles to no code at all, with no compiler error pointing at
the missing setting.

*Reference page:* [`Sqrt`](reference/builtins/sqrt.md)

### `SetSpriteLoc` assumes the screen is still at its default location

**Status:** Open · **Fixed in:** not yet fixed

The sprite-pointer table always lives at a fixed offset from wherever
screen memory currently starts. `SetSpriteLoc` doesn't compute that
offset from the screen's actual, currently configured location; it
always assumes the *default* one. If a program moves the screen with
`SetScreenLocation` and also uses sprites, `SetSpriteLoc` keeps writing
to the old, default location's sprite-pointer table rather than the
real one, silently leaving sprites pointed at the wrong (or stale)
shape data, with no error.

*Reference pages:* [`SetSpriteLoc`](reference/builtins/setspriteloc.md),
[`SetScreenLocation`](reference/builtins/setscreenlocation.md)

### `Wait(0)` spins through a near-256-iteration loop instead of returning immediately

**Status:** Open · **Fixed in:** not yet fixed

`Wait` is meant to busy-loop for a given number of iterations before
returning. The generated loop always counts down at least once before
checking whether it's reached zero, so calling it with a count of `0`
underflows immediately and spins through nearly the full 256-iteration
range instead of doing nothing. The same "runs the body at least once"
shape shows up elsewhere in this fork too (`FOR`/`FORI`, `FLD`,
`MemCpy`/`MemCpyFast` with a runtime count of `0`).

*Reference page:* [`Wait`](reference/builtins/wait.md)

### `ToggleBit` with a constant bit index runs its work twice

**Status:** Open · **Fixed in:** not yet fixed

`ToggleBit` has two internal code paths: a fast one for when the bit
index is a compile-time constant, and a slower general one for when it's
a variable or expression. When the bit index actually is a constant, the
compiler generates the fast path correctly, but then falls through and
also generates the slow path right after it, recomputing and reapplying
the same set/clear a second time. The end result is still correct
(setting or clearing the same bit twice has no further effect), but
every call with a literal bit index, the common case, ends up roughly
twice the code size and twice the execution time it needs to be.

*Reference page:* [`ToggleBit`](reference/builtins/togglebit.md)

## Project files and build tooling

### A missing settings file reports a successful exit code

**Status:** Open · **Fixed in:** not yet fixed

Compiling with no `settings=` argument, when the CLI's own fallback
location for a settings file also doesn't have one, prints an error and
compiles nothing at all, but the process still reports a successful
exit code, the same one a real, successful compile returns. A build
script or CI job that only checks the exit code, rather than reading
the printed output, would report this as a passing build.

*Reference page:* [Project & Settings Files](project-files.md)

### `output_file=` has no effect in the normal project compile mode

**Status:** Open · **Fixed in:** not yet fixed

`output_file=` is meant to rename the produced binary. It only actually
does that when assembling a `.asm` file directly, outside of a full
project compile; in the normal project-compile mode, it's accepted on
the command line but silently changes nothing, with no error or warning
that it had no effect.

*Reference page:* [Project & Settings Files](project-files.md)

### Shipped C64 project templates spell two of their own settings wrong

**Status:** Open · **Fixed in:** not yet fixed

Every general-purpose C64 project template this fork ships (including
the downloadable project bundle used to compile examples on this site)
contains two settings under the wrong key name, so setting them has no
effect at all: the whole-program compression toggle, and two of the
four settings that override the default load address/header behavior
(only the custom-load-address override actually works in an affected
template; the other two silently stay off). A handful of more
specialized templates carry the correct key names too, alongside the
wrong ones, so compression and all four overrides do work there.
Setting either one from inside a program's own source, rather than by
hand-editing the project file, always uses the correct key name and
isn't affected by this.

*Reference page:* [Project & Settings Files](project-files.md)

### A settings-file key that looks like it removes unused symbols does nothing

**Status:** Open · **Fixed in:** not yet fixed

The settings file (as opposed to the project file) contains a key that
reads exactly like the on/off switch for removing unused
variables/procedures from a compile. It isn't; that key is never read
anywhere. The real switch lives in the project file instead, under a
different, similarly-named key.

*Reference page:* [Project & Settings Files](project-files.md)
