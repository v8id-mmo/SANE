# `invert`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A type flag for `cstring` variables that sets the high bit on every
character's byte value at compile time, producing PETSCII reverse-video
(inverted) text without needing to invert it at runtime.

## Syntax

    var
      <name> : cstring invert = "<text>";

## Parameters

None; `invert` is a bare flag with no argument of its own, written right
after the `cstring` type.

## Example

```pascal
program InvertDemo;
var
	message : cstring invert = "HELLO WORLD";

begin
	printstring(message,0,0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/invert.ras){ .md-button download }

## Known limitations

Only allowed on `cstring` declarations; using it on any other type is a
compile error.
