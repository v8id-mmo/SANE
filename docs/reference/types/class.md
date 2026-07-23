# `class`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A `record` that can also declare its own procedures/functions
alongside its fields, using `this` inside those methods to refer to the
calling instance. Otherwise declared and used exactly like a `record`:
plain fields, array fields, and instances (or arrays of instances) all
work the same way.

## Syntax

    var
        <ClassName> = class
            <field1>, <field2>, ... : <type>;

            procedure <MethodName>(<params>);
            begin
                this.<field> := ...;
            end;
        end;

        <name> : <ClassName>;
        <namePtr> : pointer of <ClassName>;

## Parameters

- `<ClassName>`: the type name, defined once inside a `var` block, then
  usable as an ordinary type anywhere after.
- `this`: inside a method body, refers to the specific instance the
  method was called on.
- A method is called as `<name>.<MethodName>(...)`, or
  `<namePtr>^.<MethodName>(...)` through a pointer.

## Example

```pascal
program ClassDemo;
var
	Actor = class
		hp : byte;
		x, y : byte;

		procedure Init(startHp : byte);
		begin
			this.hp := startHp;
			this.x := 0;
			this.y := 0;
		end;

		procedure TakeDamage(amount : byte);
		begin
			this.hp := this.hp - amount;
		end;
	end;

	hero : Actor;
	heroPtr : pointer of Actor;
begin
	clearscreen(key_space,screen_char_loc);

	hero.Init(100);
	hero.TakeDamage(30);

	moveto(0,0,hi(screen_char_loc));
	printstring("hp after hit:",0,40);
	moveto(14,0,hi(screen_char_loc));
	printdecimal(hero.hp,2);

	// A pointer to the same object reaches the same fields/methods
	heroPtr := #hero;
	heroPtr^.TakeDamage(10);

	moveto(0,1,hi(screen_char_loc));
	printstring("hp via pointer:",0,40);
	moveto(16,1,hi(screen_char_loc));
	printdecimal(hero.hp,2);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/class.ras){ .md-button download }

## Known limitations

There's no inheritance: a `class` can't extend another `class`, so
sharing behavior between related classes means composition (one class
holding a field of another) rather than a base/derived relationship.
This is a scope boundary rather than a bug; nothing about it silently
misbehaves.

Unlike a plain `record`, a `class` is exempt from the "no array field in
an array element type" restriction described on [`array`](array.md)'s
Known limitations: `array[N] of SomeClass` compiles fine even when
`SomeClass` has an array field.

`private`/`public` visibility keywords exist but have no working
implementation for either `record` or `class` members; see
[`private`](../keywords/private.md)'s Known limitations. Every field and
method declared here is effectively public.
