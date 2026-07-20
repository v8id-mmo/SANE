# `buildsinetable`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Fills an array's initializer at compile time with one full cycle of a
sine wave, sized to the array's own element count. A convenience
shorthand for the sine-wave case of [`buildtable`](buildtable.md).

## Syntax

    var
      <name> : array[<count>] of <type> = buildsinetable(<height>);

## Parameters

- `<height>`: the peak-to-peak height of the wave. Internally the
  amplitude used is `<height> / 2`, and each element is computed as
  `sin(i / count * 2*pi) * amplitude + amplitude`, so the generated
  values oscillate between roughly `0` and `<height>`, over `<count>`
  steps (`<count>` being the array's own declared size).

## Example

```pascal
program BuildSineTableDemo;
var
	sinx : array[256] of byte = buildsinetable(127);
	i : byte = 0;

begin
	for i := 0 to 255 do
	begin
		screen_bg_col := sinx[i]&15;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/buildsinetable.ras){ .md-button download }
