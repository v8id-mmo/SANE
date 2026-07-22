# `FLD`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Performs one or more lines of an "FLD" (Flexible Line Distance) raster
effect: each pass advances the vertical fine-scroll register by one line,
stretching the screen border/display area vertically by a line before
snapping back. A classic demo-scene effect, normally called once per
frame from inside a raster interrupt handler.

## Syntax

    FLD( <count>, <mode> );

## Parameters

- `<count>`: how many lines of the effect to run.
- `<mode>`: a pure constant number, `0` or `1`, selecting which of two
  fixed `$D011` bit patterns each line is combined with.

## Example

```pascal
program FldDemo;
begin
	screen_bg_col := black;
	while (true) do
	begin
		waitforverticalblank();
		fld(32,0);
	end;
end.
```

[:material-download: Download this example](../../assets/examples/fld.ras){ .md-button download }

## Known limitations

`FLD`'s loop always runs its body at least once before checking the
count, so passing a count of `0` doesn't skip the effect: the counter
wraps around instead, and the effect actually runs 256 times.
