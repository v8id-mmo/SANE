# `record`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE always fails to compile a whole-record assignment (`p2 := p1;`);
SANE fixes it for plain `record` (see Known limitations below).

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

	// whole-record assignment: copies every field at once
	p2 := p1;

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

**In vanilla TRSE, whole-record assignment always fails.** `p2 := p1;`
(no field selector on either side, for two variables of the same record
type) fails to compile there with "Cannot assign a record of type
'&lt;name&gt;' to a single variable," for any `record` shape. This isn't a
deliberate restriction: working field-by-field copy code exists in the
compiler for exactly this case, but an earlier, unconditional check
rejects the assignment before that code is ever reached. Copying each
field individually, as `p2.x := p1.x; p2.y := p1.y;`, works there too, and
remains the only way to copy a `class` (see below).

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
whole-record assignment now compiles and copies every field, for a plain
`record` (used in the example above). This fix doesn't cover `class`:
`p2 := p1;` for two `class` variables compiles without error in both
vanilla TRSE and SANE, but silently does nothing - it does not copy any
fields, and there is no warning that it didn't. This is a separate, still
open, defect; copy each field individually for a `class`, the same way a
`record` needed to before this fix.

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
