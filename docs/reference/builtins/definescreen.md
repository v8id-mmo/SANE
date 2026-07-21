# `DefineScreen`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Defines two zero-page label aliases, `screenmemory` and `colormemory`,
pointing at the current project's configured screen/color memory zero
page locations, so other code can refer to them by name.

## Syntax

    DefineScreen();

## Parameters

None.

## Example

```pascal
program DefineScreenDemo;
begin
	definescreen(); // creates screenmemory and colormemory as usable labels
	poke(screenmemory, 0, 1);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/definescreen.ras){ .md-button download }

Many other builtins (`MoveTo`, `PrintString`, `Tile`) call `DefineScreen`
internally, so `screenmemory`/`colormemory` are often already available
without an explicit call. Calling it directly is only needed if a program
wants to use those labels without otherwise using `moveto`/`printstring`/
`tile`. Calling it more than once has no extra effect, it only defines the
labels the first time.
