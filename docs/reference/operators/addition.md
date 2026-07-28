# `+` (Addition)

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
zero-extended a negative `signed byte` mixed into a wider expression
instead of sign-extending it; SANE fixes it.

Adds two numeric values together.

## Syntax

    <a> + <b>

## Parameters

- `<a>`, `<b>`: numeric values (`byte`, `integer`, or `long`), unsigned or
  `signed`.

## Returns

The sum. The result stays at whichever width is wider: the operands' own
declared type, or, when the sum is assigned straight into a variable, that
variable's type (see the widening note below).

## Example

```pascal
program AdditionDemo;
var
	a : byte = 200;
	b : byte = 100;
	sum : integer;

begin
	clearscreen(key_space,screen_char_loc);
	sum := a + b;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(sum,5);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/addition.ras){ .md-button download }

## Known limitations

- **Assigning a `byte + byte` sum directly into a wider variable widens it
  correctly**, as in the example above (`200 + 100 = 300`, which doesn't
  fit in a `byte`, but `sum` correctly ends up `300` because it's declared
  `integer`). This only happens when assigning straight into a variable of
  the wider type; a `byte + byte` sum used any other way (assigned to
  another `byte`, passed as a `byte` parameter, or used inside a larger
  expression with nothing wider around it) stays 8-bit and silently wraps
  on overflow instead (`200 + 100` would come out as `44`, not `300`).
- **In vanilla TRSE, mixing a negative `signed byte` into a wider
  expression zero-extends instead of sign-extending its value**, the same
  limitation described on the [`signed`](../keywords/signed.md) page: a
  `-1` byte widened into an `integer` comes out as `255` (`$00FF`)
  instead of `-1` (`$FFFF`). Same-width addition (`signed byte + signed
  byte`, or `signed integer + signed integer`) is unaffected; the problem
  is specific to combining a negative byte with an already-wider operand
  in the same expression.  
  :material-check-decagram:
  **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
  a negative `signed byte` mixed into a wider expression is now
  sign-extended correctly.
