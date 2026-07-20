# `function`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a procedure that returns a value. Otherwise behaves like an
ordinary procedure: same parameter syntax, same `forward`/`inline`/
`assembler` modifiers.

## Syntax

    function <name>(<params>) : <returnType>;
    begin
        <statements>;
        <name> := <value>;
    end;

The return value is set by assigning to the function's own name inside its
body, Pascal-style, not with a `return <value>` statement (`return` on its
own just exits the current procedure/function early, without setting a
value).

## Parameters

- `<name>`: the function's name; also used as the "variable" the return
  value is assigned to.
- `<params>`: same parameter syntax as `procedure`.
- `<returnType>`: the type of the returned value. Only `byte`, `integer`,
  `boolean`, and `long` are currently supported as return types.

## Example

```pascal
program FunctionDemo;

function Double(x : byte) : byte;
begin
	Double := x + x;
end;

begin
	screen_bg_col := Double(5);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/function.ras){ .md-button download }
