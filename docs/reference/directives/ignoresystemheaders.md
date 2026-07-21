# `@ignoresystemheaders`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive intended to suppress automatically-included
system/platform header content from the compiled output.

## Syntax

    @ignoresystemheaders

Takes no arguments.

## Example

```pascal
program IgnoreSystemHeadersDemo;

@ignoresystemheaders

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/ignoresystemheaders.ras){ .md-button download }

## Known limitations

**Currently has no effect.** The directive compiles cleanly (it also
prints a stray debug line to the console, harmless but a little
unexpected), but nothing else in the compiler ever checks the flag it
sets, on the C64 target or otherwise. Using it doesn't change the compiled
output in any observable way.
