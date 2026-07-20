# `signed`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

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

- `<type>`: the numeric base type being marked signed, typically `byte`,
  `word`, or `integer`.

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

Signed arithmetic and comparisons are unevenly implemented, and this is
the modifier that switches a variable into all of those code paths at
once:

- **Signed comparison is incomplete for 16-bit values.** For a `signed
  word`/`integer`, only `<` and `<=` are implemented; every other
  comparison operator (`>`, `>=`, `=`, `<>`) throws a compile error
  instead of producing wrong code. Signed comparison for a `signed long`
  isn't implemented at all, any comparison operator errors out.
- **Byte-level signed comparison is suspected wrong at the extremes**,
  such as comparing `-128` and `127`, because the generated code doesn't
  correct for 6502 signed-overflow the way the 16-bit `<`/`<=` case does.
  This hasn't been confirmed by running it, just inferred from the
  generated code, but the risk is real enough to flag: don't rely on
  signed byte comparison right at the type's boundary values without
  testing it yourself first. The example above (`dx < 0`) sits well away
  from that boundary and is unaffected.
- **Signed multiplication (`*`) silently gives the wrong result for a
  negative operand.** The multiply routine actually wired up behind `*`
  is always the unsigned one, regardless of whether either operand is
  `signed`. It happens to give the right answer when both operands are
  positive, since the bit pattern matches the unsigned case, but is wrong
  as soon as either one is negative, with no warning or error.
- **Signed division (`/`) isn't implemented at all.** Division always
  uses unsigned arithmetic, ignoring the `signed` modifier entirely.
- **Mixing a `signed byte` into a wider expression (word/integer) always
  zero-extends instead of sign-extending.** A negative signed byte widened
  to a word should keep its negative value (e.g. `-1` becomes `$FFFF`),
  but instead comes out as the small positive value the raw bit pattern
  represents (`$FF` becomes `$00FF`, i.e. 255). This affects addition,
  subtraction, and multiplication between a `signed byte` and a wider
  type.

None of the above needs the buggy path to be avoided entirely: unsigned
usage, positive-only signed values, and 16-bit `<`/`<=` comparisons all
work correctly. It's specifically negative-operand multiplication,
any signed division, mixed-width arithmetic with a negative byte, and
every signed 16-bit comparison other than `<`/`<=` that currently produce
wrong results.
