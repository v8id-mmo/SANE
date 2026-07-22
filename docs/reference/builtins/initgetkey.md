# `initGetKey`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the keyboard-matrix scanning routine used by
[`getKey`](getkey.md) (C64 and C128 only). Normally included automatically
the first time `getkey(` appears in the source; calling it directly,
together with [`@ignoremethod`](../directives/ignoremethod.md), lets a
program take manual control of when it's pulled into the build.

## Syntax

    initgetkey();

## Example

```pascal
program InitGetKeyDemo;

// getkey() normally auto-includes initGetKey the first time it's seen.
// @ignoremethod opts out, so the call below is what actually pulls the
// keyboard-scan routine into the build.
@ignoremethod initgetkey

var
	k : byte;

begin
	initgetkey();

	k := getkey();

	screen_bg_col := k;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initgetkey.ras){ .md-button download }

## Known limitations

The argument to [`@ignoremethod`](../directives/ignoremethod.md) must be
written in all-lowercase (`initgetkey`, not `initGetKey` as shown in this
routine's own name). Writing it in the normal casing silently fails to
suppress the automatic insertion, and the resulting duplicate inclusion
of the keyboard-input code fails the build outright with a duplicate-symbol
assembly error, unlike most other `init...` routines, where the same
mismatch is harmless.
