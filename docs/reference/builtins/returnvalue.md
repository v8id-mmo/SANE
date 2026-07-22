# `ReturnValue`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Sets a [`function`](../keywords/function.md)'s return value and exits
immediately, in one call. This differs from the normal
`<functionName> := <value>;` way of setting a function's return value
(see the `function` page): that assignment alone doesn't exit, so
reaching it doesn't skip whatever statements come after it in the same
block. `ReturnValue` is for an early exit from deep inside a function,
for example partway through a loop, once the result is already known
and the rest of the function has nothing left to do.

## Syntax

    ReturnValue( <value> )

## Parameters

- `<value>`: an expression matching the enclosing function's declared
  return type (`byte`, `integer`, or `boolean`; see Known limitations
  for `long`).

## Example

```pascal
program ReturnValueDemo;
var
	data : array[8] of byte = (5,3,9,0,7,1,2,4);
	result : byte;

function FindFirstZero() : byte;
var
	i : byte;
begin
	for i := 0 to 7 do begin
		if (data[i] = 0) then
			returnvalue(i); // set the return value and exit right here

	end;
	returnvalue(255); // none found
end;

begin
	result := FindFirstZero();
	moveto(0,0,hi(screen_char_loc));
	printstring("first zero at:",0,40);
	moveto(15,0,hi(screen_char_loc));
	printdecimal(result,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/returnvalue.ras){ .md-button download }

## Known limitations

`ReturnValue` correctly returns a `byte`, `integer`, or `boolean` value.
On a `function` declared to return `long`, it fails to assemble instead
of returning the value: the build stops with an "opcode not implemented
or illegal" error at the `lda` this builtin emits. The plain
`<functionName> := <value>;` form works correctly for `long` return
values; only `ReturnValue` specifically is affected.
