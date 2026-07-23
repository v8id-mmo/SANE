# `record`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A fixed collection of named fields grouped under one type, like a
Pascal record or a C struct. The base for [`class`](class.md) (a `record`
that can also declare its own methods); a plain `record` has fields only,
no methods.

## Syntax

    var
        <RecordName> = record
            <field1>, <field2>, ... : <type>;
        end;

        <name> : <RecordName>;
        <name>.<field> := <value>;

## Parameters

- `<RecordName>`: the type name, defined once inside a `var` block, then
  usable as an ordinary type anywhere after (including as an
  [`array`](array.md) element type, or a field's own type for nesting).
- `<field>`: any of the record's declared fields, accessed with `.`.

## Example

```pascal
program RecordDemo;
var
	Point = record
		x, y : byte;
	end;

	p1, p2 : Point;
	points : array[3] of Point;
	i : byte;
begin
	clearscreen(key_space,screen_char_loc);

	p1.x := 10;
	p1.y := 20;

	// whole-record assignment (p2 := p1;) isn't supported, so copy
	// field by field instead (see Known limitations below)
	p2.x := p1.x;
	p2.y := p1.y;

	for i:=0 to 2 do
	begin
		points[i].x := i*10;
		points[i].y := i*5;
	end;

	moveto(0,0,hi(screen_char_loc));
	printstring("p2.x:",0,40);
	moveto(6,0,hi(screen_char_loc));
	printdecimal(p2.x,3);

	moveto(0,1,hi(screen_char_loc));
	printstring("points[2].y:",0,40);
	moveto(13,1,hi(screen_char_loc));
	printdecimal(points[2].y,3);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/record.ras){ .md-button download }

## Known limitations

**Whole-record assignment always fails.** `p2 := p1;` (no field selector
on either side, for two variables of the same record type) fails to
compile with "Cannot assign a record of type '&lt;name&gt;' to a single
variable," for any record shape, `class` included. This isn't a
deliberate restriction: working field-by-field copy code exists in the
compiler for exactly this case, but an earlier, unconditional check
rejects the assignment before that code is ever reached. Copy each field
individually instead, as the example above does.

**A pointer field inside a record/class isn't allowed** on this fork's C64
target; every field must be a plain value type, another record/class
instance, or an array of one.

**An array of records can't use a record type that itself has an array
field.** `array[N] of SomeRecord` fails to compile if `SomeRecord`
contains an array member (a single, non-array instance of the same record
is unaffected). See [`array`](array.md)'s Known limitations; this
restriction doesn't apply to `class`.

`private`/`public` visibility keywords exist but have no working
implementation for record (or class) members; see
[`private`](../keywords/private.md)'s Known limitations. Every field is
effectively public.
