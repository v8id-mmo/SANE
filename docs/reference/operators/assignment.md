# `:=` (Assignment)

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Stores the value of an expression into a variable.

## Syntax

    <variable> := <expression>;

## Parameters

- `<variable>`: the destination to store into.
- `<expression>`: the value to compute and store.

## Returns

Not applicable; `:=` is a statement, not an expression that produces a
value itself.

## Example

```pascal
program AssignmentDemo;
var
	w : integer = 300;
	b : byte;

begin
	clearscreen(key_space,screen_char_loc);
	b := w;
	moveto(0,2,hi(screen_char_loc));
	printdecimal(b,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/assignment.ras){ .md-button download }

## Known limitations

Assigning between two variables of the same declared type works exactly
as expected. Assigning a narrower value into a wider variable (`byte`
into `integer`, for example) auto-widens correctly, the same way the
[arithmetic operators](addition.md) do.

- **Assigning a wider value into a narrower variable truncates silently,
  keeping only the low byte(s), with no overflow warning.** As in the
  example above, an `integer` holding `300` assigned into a `byte`
  variable doesn't clamp or error, it just keeps the low byte: `300`
  ($012C) becomes `44` ($2C), the value's high byte is simply dropped.
  Confirmed by reading the generated code: only the source value's low
  byte is ever loaded and stored into the narrower destination.
- **Chained assignment isn't supported.** `a := b := 5;` is a compile
  error (not silently misinterpreted); each assignment needs to be its
  own statement.
- Assigning a variable to itself (`a := a;`) is recognized and optimized
  away entirely: it emits no code at all. Harmless, but worth knowing if
  you're looking for a statement's generated code and it appears to be
  missing.

Array element and record field assignment have their own separate
semantics beyond plain scalar assignment; those belong on the array and
record type pages rather than here.
