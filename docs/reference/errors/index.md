# Compiler Error Messages

A reference for every error (and notable warning) the compiler can print
while compiling a program, grouped by what part of the compile process
produces them. If you've hit an error message and want to know why, and
how to fix it, search for the exact text here, or browse the category
that matches where it happened.

Each entry shows the message roughly as printed (variable parts like a
file name or type name are shown as a lowercase placeholder in angle
brackets, e.g. `<name>`), what causes it, and how to fix it.

## Categories

- [Syntax, types & variables](syntax-types-and-variables.md): token/parsing
  errors, illegal or unknown types, and problems finding or declaring a
  variable, constant, or symbol.
- [Procedures, expressions & control flow](procedures-expressions-and-control-flow.md):
  procedure/function declaration and call errors, expression and operator
  errors, and `for`/`break`/`continue` errors.
- [Builtin function parameters](builtin-function-parameters.md): errors
  from calling a builtin (`MemCpy`, `Joystick`, `SetScreenLocation`, and
  the like) with the wrong kind of argument.
- [Files & assets](files-and-assets.md): missing source/include/asset
  files, image and music import errors, and command-line build-script
  errors.
- [Assembler & internal errors](assembler-and-internal-errors.md): errors
  from the assembler stage that turns generated code into a `.prg`
  (illegal opcodes, branch range, label conflicts), plus internal
  consistency checks that should never trigger from valid code.

## A note on the internal errors category

Most errors in this reference are triggered by something specific and
fixable in your own source code. A handful, called out on the
[assembler & internal errors](assembler-and-internal-errors.md) page, are
internal safety checks (their wording usually includes phrases like
"should not happen"): if one of those actually fires, it points at a
compiler bug rather than a mistake in your program.
