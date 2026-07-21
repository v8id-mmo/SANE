# `@if`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Compile-time conditional compilation, like [`@ifdef`](ifdef.md), but
checking a defined symbol against a specific value instead of just
whether it was `@define`d at all. Only the matching branch's code exists
in the compiled program; the other one isn't just skipped at runtime, it
was never compiled in the first place.

## Syntax

    @if <name> = <value>
        <code, only compiled if <name> was @defined as <value>>
    @endif

`@if` with `@else` branch:

    @if <name> = <value>
        <code, only compiled if <name> was @defined as <value>>
    @else
        <code, only compiled otherwise>
    @endif

## Parameters

- `<name>`: the symbol to check, as previously set with `@define <name>
  <value>`.
- `<value>`: the value to compare against. The comparison is an exact
  text match against whatever `<name>` was `@define`d as, not a numeric
  evaluation, so `@define count 01` would not match `@if count = 1`.

`=` is the only comparison supported; there's no `<>`, `>`, `<`, etc.
form. If `<name>` was never `@define`d at all, the condition is treated
as false, the same as `@ifdef` on an undefined symbol.

## Example

```pascal
program AtIfDemo;
@define target_ntsc 1
@if target_ntsc = 1
var
	refreshRate : byte = 60;
@else
var
	refreshRate : byte = 50;
@endif

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(refreshRate,3);
	loop();
end.
```

Since `target_ntsc` is `@define`d as `1` and the check is `= 1`, the first
branch is the one actually compiled in (`refreshRate` ends up `60`).

[:material-download: Download this example](../../assets/examples/if-directive.ras){ .md-button download }

## See also

[`@ifdef`](ifdef.md)/[`@ifndef`](ifndef.md) check only whether a symbol
was defined, not its value; use `@if` when the branch depends on what a
symbol was actually `@define`d as. Not to be confused with the
[`if`](../keywords/if.md) statement, which is a runtime conditional
resolved every time the program runs, not once at compile time.
