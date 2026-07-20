# `stack`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A modifier on a procedure/function parameter that passes it through the
real 6502 hardware stack, instead of TRSE's normal fixed-memory-location
parameter passing. This is what makes working recursion possible: TRSE
normally gives each parameter one fixed address, so a recursive call
clobbers the same location its own caller is still using. A `stack`
parameter gets a genuine, separate slot per call instead.

## Syntax

    function <name>(<param> : byte stack) : <returnType>;
    ...
    end;

## Parameters

- `<param>`: the parameter to pass on the stack. Must be declared as
  `byte`, no other type is accepted.

## Example

```pascal
program StackDemo;

var
	i,j,k : byte;

function Factorial(p : byte stack) : byte;
begin
	if (p>1) then
		p:=p*Factorial(p-1);
	Factorial:=p;
end;

begin
	clearscreen(key_space,screen_char_loc);
	moveto(5,3,hi(screen_char_loc));
	for j:=1 to 6 do
	begin
		k:=Factorial(j);
		printdecimal(k,2);
		screenmemory += screen_width*2;
	end;
	loop();
end.
```

Each recursive call to `Factorial` needs its own copy of `p`; without
`stack`, every call would read and write the same fixed address and the
recursion would break.

[:material-download: Download this example](../../assets/examples/stack.ras){ .md-button download }

## Known limitations

- **Only `byte` parameters can be flagged `stack`.** Attempting it on
  `integer`, `word`, `long`, an array, a pointer, or any other type fails
  to compile with `Stack parameters can currently only be 'byte'`.
- **`stack` is only valid on a procedure/function parameter, not on an
  ordinary `var` declaration.** Using it outside a parameter list fails
  to compile.
