# Keywords

Statement, control-flow, and declaration keywords. `@`-prefixed build
directives (file/asset import-export, compile-time conditionals, project
configuration) have their own separate [Directives](../directives/index.md)
section.

- [`absolute`](absolute.md): places a variable at a fixed memory address
  (a synonym for `at`).
- [`asm`](asm.md): inserts raw 6502 assembler directly into the program.
- [`assembler`](assembler.md): marks a whole procedure body as
  hand-written assembler, no `begin`/`end` needed.
- [`at`](at.md): places a variable at a fixed memory address, such as a
  hardware register.
- [`begin`](begin.md): marks the start of a Pascal-style statement block.
- [`break`](break.md): exits the innermost enclosing loop immediately.
- [`buildsinetable`](buildsinetable.md): fills an array at compile time
  with one cycle of a sine wave.
- [`buildtable`](buildtable.md): fills an array at compile time from a
  JavaScript expression evaluated per index.
- [`buildtable2d`](buildtable2d.md): the two-dimensional version of
  `buildtable`, over a width by height grid.
- [`case`](case.md): a multi-way branch on a single value, Pascal-style.
- [`compressed`](compressed.md): compresses an array/string's initializer
  data at compile time.
- [`const`](const.md): declares a named, compile-time constant.
- [`continue`](continue.md): skips straight to the next loop iteration.
- [`do`](do.md): separates a `for`/`while` loop's header from its body.
- [`else`](else.md): the optional branch of `if`/`then` (or `case`) that
  runs when the condition is false.
- [`end`](end.md): closes a block opened by `begin`, or a `case`
  statement.
- [`for`](for.md): a counted loop from a start value up to (but not
  including) an end value.
- [`fori`](fori.md): the inclusive counted loop, up to and including the
  end value.
- [`forward`](forward.md): declares a procedure/function's signature
  before its real body, for forward/mutual references.
- [`function`](function.md): a procedure that returns a value.
- [`global`](global.md): binds a procedure parameter directly to an
  existing global variable, skipping parameter-passing overhead.
- [`if`](if.md): the standard conditional statement.
- [`inline`](inline.md): requests that a procedure's code be inserted
  directly at each call site instead of a real call.
- [`interrupt`](interrupt.md): declares a procedure as an interrupt
  handler instead of an ordinary procedure.
- [`invert`](invert.md): sets the high bit on every character of a
  `cstring`, for reverse-video PETSCII text.
- [`krillsloader`](krillsloader.md): sets up Krill's C64 loader, an
  argument to `@use`.
- [`length`](length.md): returns an array's element count (or a string's
  size) as a compile-time constant.
- [`no_term`](no_term.md): suppresses the automatic terminator byte on a
  `string`/`cstring` declaration.
- [`of`](of.md): links an array's bound (or a pointer's) to its element
  type, and separates a `case` expression from its branches.
- [`offpage`](offpage.md): forces a long jump instead of a short branch
  for a conditional's generated code.
- [`onpage`](onpage.md): forces a short relative branch for a
  conditional's generated code, with no size safety check.
- [`private`](private.md): a class/record visibility keyword with no
  working implementation, see its Known limitations.
- [`procedure`](procedure.md): a named, callable block of statements.
- [`program`](program.md): opens a source file and names the compiled
  program.
- [`public`](public.md): a class/record visibility keyword with no
  working implementation, see its Known limitations.
- [`repeat`](repeat.md): a post-condition loop that runs its body at
  least once, paired with `until`.
- [`repend`](repend.md): closes an inline-assembler `repeat N` unrolling
  block.
- [`return`](return.md): exits the current procedure or function
  immediately.
- [`signed`](signed.md): marks a numeric variable as holding a signed
  value, see its Known limitations.
- [`sizeof`](sizeof.md): the size of a variable in bytes, as a
  compile-time constant.
- [`stack`](stack.md): passes a `byte` parameter through the hardware
  stack instead of a fixed address, enabling recursion.
- [`step`](step.md): sets the increment amount for a `for`/`fori` loop
  counter.
- [`then`](then.md): separates an `if` condition from its true branch.
- [`to`](to.md): separates a `for` loop's start value from its end value.
- [`type`](type.md): declares a named alias for a type expression, inside
  a `var` block.
- [`unit`](unit.md): declares a `.tru` file as a reusable unit of code
  pulled in with `@use`.
- [`unroll`](unroll.md): expands a `for`/`fori` loop at compile time
  instead of generating a runtime loop.
- [`until`](until.md): closes a `repeat` loop with its exit condition.
- [`var`](var.md): opens a block of variable declarations.
- [`volatile`](volatile.md): stops the optimizer from removing accesses
  to a variable that changes outside normal program flow.
- [`wedge`](wedge.md): declares an interrupt-return procedure, currently
  identical to `interrupt`.
- [`while`](while.md): a pre-condition loop, checked before each pass
  through the body.
