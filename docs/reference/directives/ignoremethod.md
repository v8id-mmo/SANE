# `@ignoremethod`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Opts a named `init...` routine out of TRSE's automatic initialization scan.
Several builtins (`sine[`, `rand(`, `sqrt(`, `joystick(`, and others)
normally get an automatic call to their matching `init...` routine inserted
at program start, the first time the compiler spots the triggering pattern
anywhere in the source text. `@ignoremethod` suppresses that automatic
insertion, for programs that want to call the `init...` routine themselves
instead (for example, to control exactly when it runs).

## Syntax

    @ignoremethod <initRoutineName>

## Parameters

- `<initRoutineName>`: the name of the `init...` routine to exclude from
  auto-initialization, not the triggering builtin's own name (for example,
  `initsinetable` to stop `sine[...]` usages from auto-inserting that call;
  writing `sine` here has no effect, since it doesn't match the name the
  compiler actually checks against). See Known limitations below for a
  casing requirement on this argument.

## Example

```pascal
program IgnoreMethodDemo;

// Normally, the first "sine[" usage anywhere in the source would
// auto-insert a call to initsinetable() at program start. Opting out
// means the table isn't filled until the explicit call below runs.
@ignoremethod initsinetable

var
	angle : byte;
	x : byte;

begin
	initsinetable();

	angle := 64;
	x := sine[angle];

	screen_bg_col := x;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/ignoremethod.ras){ .md-button download }

## Known limitations

The argument must be written in all-lowercase (`initgetkey`, not
`initGetKey`), regardless of how the routine's name is normally cased
everywhere else, including in this site's own examples. Writing it in
that normal casing silently fails to match, and the automatic insertion
stays active alongside a program's own explicit call to the routine. For
most `init...` routines the result is just harmless redundancy (the
routine guards itself against running its setup twice), but for
`initGetKey` specifically, there's no such guard, and the mismatch
produces a hard build failure (a duplicate-symbol error from the
keyboard-input code being assembled twice).
