# Assembler & internal errors

The last stage of a build turns the compiler's generated assembly into an
actual `.prg` file. Errors here come from that assembler stage, from
resource limits (running out of zero-page space, overlapping memory),
and from a small set of internal consistency checks that exist to catch
compiler bugs rather than mistakes in your program.

## Assembling generated code

### `Cannot do nested unrolling.`

A `repeat` (unrolled-code) block appeared inside another still-open
`repeat` block. Close the outer `repeat` before starting a new one.

### `Repeat count must be either 1 or 2-dimensional.`

A `repeat n [m]` line has neither one nor two numeric arguments. Use
either a single count or a row/column pair.

### `Repeat count must be a number.`

A `repeat` block's count argument(s) failed to parse as integers. Use
literal numbers.

### `Repeat count must be larger than 0.`

A `repeat` count is zero or negative. Use a positive count.

### `Not in an repeat loop.`

A `repend` appeared without a matching open `repeat` before it. Add the
missing `repeat`, or remove the stray `repend`.

### `Align only takes one parameter`

A `.align` directive line has other than exactly one argument (besides
the directive itself). Check the directive's syntax.

### `Invalid align parameter, must be >0`

An `.align` directive's numeric value is zero or negative. Use a
positive alignment value.

### `Orgasm does not support constants (or absolute addresses) that uses the name 'x' or 'y'! Please use a different name.`

A constant or label was named exactly `x` or `y` (any case), which
clashes with the 6502's index registers in the assembler's own syntax.
Rename it.

### `OrgAsm error: constant '<name>' already defined.`

The same constant name was assigned twice. Rename one of them, or remove
the duplicate.

### `OrgAsm error: label '<name>' already defined as a constant.`

A label name collides with an already-defined constant. Rename the
label.

### `OrgAsm error: symbol '<name>' already defined`

A label name collides with an already-defined label or symbol. Rename
it.

### `Incorrect number format: <text>`

A `.byte`/data value couldn't be parsed as a number (and doesn't use a
`<`/`>`/`^` hi/lo/bank-byte selector). Check the value's syntax.

### `Could not include binary file: <file>`

An `incbin`-generated include directive's target file doesn't exist by
the time the assembler runs. This usually traces back to an earlier
compile step not producing the expected file; check the originating
`incbin`/asset directive.

### `Unknown operation: <expression>`

An instruction operand expression couldn't be evaluated to a number
during the assembler's symbol pass. Check the expression for a typo or
an unresolved label.

### `Unknown opcode: <opcode>`

A mnemonic in generated assembly isn't in the assembler's opcode table at
all. If this happens with inline assembly (`asm(...)`) you wrote by
hand, check the mnemonic's spelling.

### `Opcode illegal or not implemented yet: '<opcode>' on line '<line>'`

The mnemonic is recognized, but has no valid addressing-mode encodings
at all on the 6502. Check the mnemonic against a 6502 instruction
reference.

### `Unknown or non-implemented opcode: <opcode>`

The detected addressing mode for this instruction has no matching
encoded variant. Check that the operand's addressing mode (immediate,
absolute, indexed, and so on) is valid for that mnemonic.

### `Opcode type not implemented or illegal: <opcode> type <n> on line <line>`

The specific addressing-mode encoding needed for this instruction isn't
implemented. Check the instruction's operand form against a 6502
reference.

### `Branch out of range : <diff> :<opcode> <expression> on line <line>` (followed by "Please remember that you can use the keyword 'offpage' in your block to let OrgAsm know that the code should perform off-page jumps.")

A relative branch instruction's target is more than 127 bytes forward or
128 bytes back, which a 6502 branch can't reach directly. Wrap the block
with `offpage` so the assembler generates a long jump instead, as the
message suggests.

## Memory & resource limits

### `Could not allocate more free pointers! Please free some up, or declare more in the settings page.`

A `pointer` variable was declared, but no free zero-page pointer slots
remain. Free up existing pointers you no longer need, or add more
zero-page addresses for pointers in the project settings.

### `Origin reversed index. Trying to move program counter backwards to '<address>' from current counter <counter>.` (followed by an explanation that included/defined data overlaps)

An `org`/position directive tried to move the assembly position
backwards over data that's already been placed there. Check for two
variables or blocks placed at overlapping addresses, and use the memory
analyzer to find the conflict.

### `Overlapping memory regions: '<name 1>' and '<name 2>' at <start> to <end>. See the memory analyzer for details.` (warning)

Two declared memory blocks or variables occupy overlapping address
ranges. Move one of them to a non-overlapping address, or let the
compiler place it automatically instead of pinning both to explicit
addresses.

### `Unused variables : <list>` (warning)

Lists every variable that was declared but never referenced anywhere.
Not an error; remove the unused variables if they were left over from
earlier edits, or ignore the warning if they're intentionally reserved.

### `Error: Out of memory addresses for temp values for the SNES (must not reside in ROM). Please go to the project settings -> zeropages -> add new addresses to the 'temp vars zeropages!'`

Raised when temp-variable zero-page space runs out while targeting the
SNES. Not reachable on this fork's C64-only target, but present in the
shared assembler code the C64 path also uses.

### `VIC-20 compilation error: You need to specify 4 1-byte VIA zero page values in the project settings.`

Raised when compiling for the VIC-20 without 4 configured VIA zero-page
values. Not reachable on this fork's C64-only target, but present in the
shared compiler code.

## Internal consistency checks

These exist to catch situations the compiler's own logic considers
impossible. If one of them actually fires, it points at a bug in the
compiler rather than something wrong with your program. There's no
source-code fix to apply; simplifying or restructuring the code near
where it happened, to work around whatever unusual combination triggered
it, is the practical short-term option, alongside reporting it as a bug
on the project's GitHub repository.

### `Node is nullpointer. Should not happen. Contact leuat@irio.co.uk and slap him.`

An internal AST-node guard fires when statement parsing produces no node
at all.

### `NodeProcedure Getvalue m_procedure is empty!`

Fires when a procedure reference's underlying declaration is unexpectedly
missing at code-generation time.

### `Error reading constant '<name>' with value '<value>' in syntax.txt. This should not happen, contant leuat@www.irio.co.uk at once!`

Fires if the compiler's own bundled constants table has an unparsable
value; this is a packaging/build integrity issue, not something a
project's source code can trigger.

### `Error in registerstack push : trying to push regstack from max` / `Error in registerstack pop : trying to pop from zero` / `Error in registerstack get : out of bounds`

Internal guards on the code generator's register-allocation stack,
firing on overflow, underflow, or an out-of-bounds access.

### `Zero pointer cannot be pushed below zero`

An internal guard on the assembler's zero-page pointer stack, firing on
underflow.

### `PVar::== - unknown type comparison` / `PVar::> - unknown type comparison` / `PVar::< - unknown type comparison`

Fallback guards in the compile-time constant-folding helper, firing when
a comparison is attempted between two constant values of a type
combination it doesn't recognize.
