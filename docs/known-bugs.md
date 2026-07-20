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

For signed `word`/`integer` values, only the `<` and `<=` operators work.
`>`, `>=`, `=`, and `<>` all fail to compile in the signed case. Signed
`long` (24-bit) comparisons aren't implemented at all, for any operator.

*Reference page: pending (comparison operators haven't been documented
yet).*

### Byte-level signed comparison is suspected to be wrong at the boundaries

**Status:** Suspected, not yet confirmed by testing · **Fixed in:** not
yet fixed

Unlike the word/integer signed comparison path, the byte-level signed
comparison is missing a correction step that's needed to get the right
answer near the boundary between positive and negative values (comparisons
like `-128` against `127`). This has been traced through the code but not
yet actually run and confirmed; it's listed here as a strong suspicion,
not a confirmed bug, until it's been tested for real.

*Reference page: pending.*

### Signed multiplication silently gives the wrong result

**Status:** Open · **Fixed in:** not yet fixed

Multiplying two byte values where at least one is a negative signed number
gives a wrong result, with no compile error or warning. Multiplying two
positive values happens to work, since their bit pattern matches the
unsigned case. A correct signed multiply routine already exists elsewhere
in the compiler's bundled code, it just isn't connected to the `*`
operator.

*Reference page: pending.*

### Signed division isn't implemented at all

**Status:** Open · **Fixed in:** not yet fixed

Division always uses unsigned arithmetic, regardless of whether either
operand is a negative signed value. There's no signed-aware division
routine anywhere in the compiler yet to fall back on.

*Reference page: pending.*

### Mixing a signed byte with a word/integer drops the sign

**Status:** Open · **Fixed in:** not yet fixed

When a `byte` value is combined with a `word`/`integer` value (addition,
subtraction, multiplication), the byte's value should be sign-extended
when it's negative (so `-1` becomes `$FFFF`, not `$00FF`). Right now it's
always zero-extended instead, so any negative byte mixed into a wider
expression produces a wrong result. Confirmed in at least two separate
spots in the code generator; there may be more not yet found.

*Reference page: pending.*

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

*Reference page: pending (`inline` and `procedure` haven't been
documented yet).*

## Builtin auto-initialization

### Auto-initialized builtins only look for usages in the current file

**Status:** Open · **Fixed in:** not yet fixed

A number of builtins (`sine[`, `rand(`, `sqrt(`, `atan2(`, `joystick(`,
and others) automatically insert their own setup call the first time the
compiler spots a matching usage anywhere in the source text, so you don't
have to call the setup routine yourself. That scan only looks at the text
of whichever file is currently being compiled: if the only usage is
inside a unit file brought in with `use`, the scan never sees it, the
setup call never gets inserted, and the
builtin silently doesn't work (for example, `sine[angle]` always returning
`0`). The workaround is to add one real, uncommented reference to the
same pattern in the main file too.

*Reference page: pending.*

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

*Reference page:* [`@bin2inc`](reference/keywords/bin2inc.md)

### `@donotprefix <symbol>` never compiles

**Status:** Open · **Fixed in:** not yet fixed

Unlike its sibling directive `@donotprefixunit` (which takes no argument
and works fine), `@donotprefix <symbolName>` fails to compile in every
configuration tested: the directive reads its symbol-name argument but
never actually consumes it from the token stream, desyncing everything
parsed afterward, the same failure shape as the `case`/`else` bug above.

*Reference page:* [`@donotprefix`](reference/keywords/donotprefix.md)

### `@ignoresystemheaders` has no effect

**Status:** Open · **Fixed in:** not yet fixed

The directive compiles cleanly and doesn't error, but nothing else in the
compiler actually reads the flag it sets. Using it doesn't change the
compiled output in any observable way.

*Reference page:*
[`@ignoresystemheaders`](reference/keywords/ignoresystemheaders.md)

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

### `@raisewarning`'s message never shows up when compiling from the command line

**Status:** Open · **Fixed in:** not yet fixed

The directive itself runs and compilation finishes normally, but the
warning text is never printed anywhere: not to the terminal, not into the
compiled output. It was only ever wired up to be read by the old
graphical editor's own output pane, which no longer exists in this
command-line-only fork. `@raiseerror`, by contrast, does still show its
message and stop compilation, since aborting works through a different
mechanism.

*Reference page:* [`@raisewarning`](reference/keywords/raisewarning.md)

### `@startblock` doesn't notice a missing or nested `@endblock`

**Status:** Open · **Fixed in:** not yet fixed

Opening a new `@startblock` region while a previous one is still open
(no `@endblock` in between) is accepted silently: the active
fixed-address region just switches to the new one, with no error or
warning. The reverse mistake, an `@endblock` with nothing open to close,
does raise a clear error, so this asymmetry is easy to trust past its
actual safety.

*Reference page:* [`@startblock`](reference/keywords/startblock.md)

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
[`@compress`](reference/keywords/compress.md)

## Image/asset import/export directives

### `@importchar` never actually copies the character it's asked to

**Status:** Open · **Fixed in:** not yet fixed

`@importchar` compiles without error and both the source and destination
assets load successfully, but the actual step that copies one character's
data across is unimplemented for every asset type this fork can produce.
The destination file is saved back to disk completely unchanged. Only one
unrelated, non-C64 asset type has a working implementation of this step.

*Reference page:* [`@importchar`](reference/keywords/importchar.md)

### `@exportblackwhite`/`@exportframe` only work for one asset type each

**Status:** Open · **Fixed in:** not yet fixed

Both directives compile without error for any input asset, but silently
produce an empty output file for every asset type except the one each was
actually implemented for (`@exportframe` additionally has a second
implementation that's a dead stub, contributing to the same silent-empty
outcome for the asset types routed through it). There's no warning when
this happens, the build just quietly produces nothing useful.

*Reference pages:*
[`@exportblackwhite`](reference/keywords/exportblackwhite.md),
[`@exportframe`](reference/keywords/exportframe.md)

### `@spritecompiler` never produces any output

**Status:** Open · **Fixed in:** not yet fixed

The directive compiles cleanly and validates that its input file exists,
but never actually generates anything: on a C64 build the underlying
image-processing step it calls is an empty stub, and even on the handful
of other targets where that step does generate something, the result is
computed and then thrown away internally rather than making it into the
compiled output. There is currently no target this fork ships with where
`@spritecompiler` does anything useful.

*Reference page:* [`@spritecompiler`](reference/keywords/spritecompiler.md)

### `@pathtool` never compiles, in any configuration

**Status:** Open · **Fixed in:** not yet fixed

The directive's own work (fitting a curve through the input points and
writing the three output files) runs successfully, but something
afterward leaves the parser out of sync with the rest of the file. The
resulting error is reported far from the actual problem, worded as if a
`begin` were missing rather than pointing at the `@pathtool` line. This
happens no matter where the directive is placed.

*Reference page:* [`@pathtool`](reference/keywords/pathtool.md)

### `@perlinnoise`'s exported data isn't clamped, but its preview image is

**Status:** Open · **Fixed in:** not yet fixed

With a high enough amplitude/power setting, the raw noise bytes written to
the output file can wrap or truncate outside the normal 0-255 range at
some pixels, while the `.png` preview saved alongside it is clamped and
looks completely clean at those same pixels. The preview can't be trusted
to catch an out-of-range setting; only the actual exported data can.

*Reference page:* [`@perlinnoise`](reference/keywords/perlinnoise.md)

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
