# `@endmacro`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Closes a `@macro` block. `@macro`/`@endmacro` define a compile-time text
generator written in **JavaScript**, not TRSE itself: the code between them
runs once, at compile time, and produces real TRSE source text, which the
compiler then parses as if it had been typed there directly.

## Syntax

    @macro "<name>" <paramCount>
        <JavaScript code, using write()/writeln() to emit TRSE source text>
    @endmacro

    // elsewhere:
    @<name>(<arg0>, <arg1>, ...)

## Parameters

- `<name>`: the identifier used to invoke the macro later, as `@<name>(...)`.
- `<paramCount>`: how many arguments the macro takes. Inside the JavaScript
  body, they're available as the variables `p0`, `p1`, ... up to
  `p<paramCount - 1>`.
- The body itself is plain JavaScript. `write(text)`/`writeln(text)` append
  `text` (plus a newline for `writeln`) to the TRSE source the compiler will
  parse next, right where the macro was invoked.

`@endmacro` itself takes no argument; it just marks where the JavaScript
body ends.

## Example

```pascal
program EndMacroDemo;

@macro "setbgcolor" 1
	writeln('screen_bg_col := '+p0+';');
@endmacro

var
	j : byte;

begin
	@setbgcolor("black")
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/endmacro.ras){ .md-button download }
