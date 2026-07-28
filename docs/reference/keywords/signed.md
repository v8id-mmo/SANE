# `signed`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE's
signed comparisons, signed multiplication/division, and byte-to-word
widening were all incomplete or wrong for a negative value; SANE fixes
all of them.

A variable declaration modifier that marks a numeric variable as holding a
signed value (negative numbers allowed), rather than the default
unsigned interpretation. It changes how comparisons, arithmetic, and
type-widening code the compiler generates for that variable behave, not
just how it's displayed or checked.

## Syntax

    var
        <name> : signed <type>;

The modifier goes before the base type in the declaration.

## Parameters

- `<type>`: the numeric base type being marked signed: `byte`, `integer`
  (16-bit), or `long` (24-bit).

## Example

```pascal
program SignedDemo;
var
	dx : signed byte;

begin
	dx := -5;
	if (dx < 0) then
		screen_bg_col := black
	else
		screen_bg_col := white;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/signed.ras){ .md-button download }

## Known limitations

In vanilla TRSE, signed arithmetic and comparisons are unevenly
implemented, and this is the modifier that switches a variable into all
of those code paths at once:

- **Signed comparison was incomplete for 16-bit values.** For a `signed
  integer`, only [`<`](../operators/less-than.md) and
  [`<=`](../operators/less-or-equal.md) were implemented; every other
  comparison operator ([`>`](../operators/greater-than.md),
  [`>=`](../operators/greater-or-equal.md), [`=`](../operators/equal.md),
  [`<>`](../operators/not-equal.md)) threw a compile error instead of
  producing wrong code. Signed comparison for a `signed long` wasn't
  implemented at all; any comparison operator errored out.
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  all six comparison operators now work on both `signed integer` and
  `signed long`.
- **Byte-level signed comparison was unverified at the extremes**, such as
  comparing `-128` and `127`, because the generated code didn't correct
  for 6502 signed-overflow the way the 16-bit `<`/`<=` case did.
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  the byte-level path now gets the same overflow correction, so it's
  correct at every boundary too.
- **Signed multiplication ([`*`](../operators/multiplication.md)) silently
  gave the wrong result for a negative operand widened to a wider
  type.** The multiply routine wired up behind `*` was always the
  unsigned one, regardless of whether either operand was `signed`.
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  a `byte * byte` product widened to an `integer` now correctly accounts
  for the sign of a negative operand.
- **Signed division ([`/`](../operators/division.md)) wasn't implemented
  at all.** Division always used unsigned arithmetic, ignoring the
  `signed` modifier entirely. :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  `mod` and `mod16` (any width), and `/` when the quotient widens to an
  `integer`, now all follow C-style truncating signed division semantics.
  A plain `byte / byte` division that stays a `byte` result is still
  unsigned only, in both TRSE and SANE; see [`/`](../operators/division.md)'s
  Known limitations.
- **Mixing a `signed byte` into a wider expression (`integer`) always
  zero-extended instead of sign-extending.** A negative signed byte
  widened to a 16-bit value should keep its negative value (e.g. `-1`
  becomes `$FFFF`), but instead came out as the small positive value the
  raw bit pattern represents (`$FF` becomes `$00FF`, i.e. 255).
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  a negative `signed byte` mixed into a wider expression is now
  sign-extended correctly.
- **Signed right shift ([`shr`/`>>`](../operators/shift-right.md)) always
  fills in `0`s instead of preserving the sign.** Shifting a negative
  signed value right gives a wrong, positive result rather than a proper
  arithmetic shift; a `signed byte` holding `-8`, shifted right by one,
  comes out as `124` instead of `-4`. Shifting a non-negative signed value
  is unaffected. Still open in both TRSE and SANE.
