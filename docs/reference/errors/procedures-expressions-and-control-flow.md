# Procedures, expressions & control flow

Errors from calling procedures/functions, evaluating expressions and
operators, assignments, and loop/`break`/`continue` control flow.

## Procedures & calls

### `Requires <n> parameters but has <m>` / `Incorrect number of parameters calling procedure '<name>'. Requires <n> parameters but is called with <m>` / `Procedure '<name>' requires <n> parameters, not <m>.`

A procedure, function, or built-in method was called with the wrong
number of arguments. Count the parameters in its declaration and match
the call to it.

### `Procedure '<name>' requires parameter <n> to be a pure variable or number`

A parameter marked `pure` received something more complex than a plain
variable or a numeric constant, such as a computed expression. Assign
the expression's result to a temporary variable first, then pass that.

### `Procedure '<name>' requires parameter <n> to be a pure number / constant`

A parameter marked `pure_number` received something other than a
compile-time constant. Pass a literal number or a `const`.

### `Procedure '<name>' requires parameter <n> to be a pure variable`

A parameter marked `pure_variable` received something other than a
plain variable reference. Pass a variable directly, not an expression.

### `Error: <name> requires parameter <n> to be pure numeric` / `<name> requires parameter to be pure numeric`

A built-in method's parameter is declared to accept only a pure numeric
value (a constant or plain numeric variable), but received an
expression. Simplify the argument to a single number or variable.

### `Error: <name> requires parameter <n> to be a procedure`

A built-in method's parameter expects a procedure reference (for
example, an interrupt handler), but something else was passed. Pass the
procedure's name directly, without parentheses.

### `TRSE currently does not support inline parameters to be in expressions in built-in methods. Please bug the developer about this`

An inline function's own parameter was used inside a larger expression
passed to a built-in method. Assign the inline parameter to a local
variable first, then use that variable in the expression.

### `Using procedures as functions can result in unpredicted behaviour. Please convert your procedure '<name>' into a function in order to avoid potential problems with the return value.` (warning)

A plain `procedure` (not a `function`) was used somewhere a value was
expected. Declare it as a `function` with an explicit return type
instead, so its return value is well-defined.

## Expressions & operators

### `Binary operations must occur between same token types (<type a> vs <type b>)`

A compile-time constant expression combined two operands of different
token types in a way the constant folder can't reconcile. Make sure both
sides of the operator are compatible literal/constant types.

### `Unknown binary operation!`

A compile-time constant-folding step hit an operator it doesn't
recognize. This generally means an operator was used somewhere the
parser accepted but constant folding doesn't implement; try moving the
computation into a runtime expression instead of a constant one.

### `Binary operation: Division by zero!`

A constant expression divides by a literal `0` (something the compiler
can catch at compile time because both sides are known constants). Fix
the divisor.

### `Mul/div not implemented for 24-bit longs`

Multiplication or division was attempted between two `long` (24-bit)
values, which isn't implemented. Use `byte`/`integer` arithmetic instead,
or implement the multiply/divide manually in stages.

### `Binary operation / not implemented for this type yet...`

A division was attempted between a combination of operand types that
has no implemented code path. Check that both operands are `byte` or
`integer`, which are the supported cases.

### `Unknown operation with address!`

An `address`-typed variable was used in an expression context that
expects a value, but no expression was actually attached to it.
Address-typed variables are meant for referencing memory locations, not
general arithmetic; use a `byte`/`integer` variable instead if you need
to compute with the value.

### `You cannot use integers variables as array indices!`

A 16-bit (`integer`) variable was used directly as an array subscript,
which the 6502 target doesn't support. Use a `byte` variable as the
index instead, or use a pointer if the array is larger than 256
elements.

### `Unary operator (-) for integer not implemented yet. Please bug the developer!`

Unary negation (`-x`) was applied to a 16-bit (`integer`) value, which
isn't implemented. Rewrite the expression as `0 - x`, or restructure the
calculation to avoid negating an `integer` directly.

### `Compare must be pure variable`

A compare-and-jump code path received a left-hand operand that isn't a
plain variable. Assign the expression to a variable first, then compare
that variable.

### `PVar::> cannot compare strings` / `PVar::< cannot compare strings`

A `>`/`<` comparison was attempted between two `string` values at
compile time. String values can't be ordered this way; compare specific
characters or use string-handling builtins instead.

### `'<value>' is an array. Did you mean to reference it with '#'?`

An array variable was loaded in a context that expects a single value or
address, without an index or a `#` reference. Add `[index]` to read one
element, or `#name` to get the array's address.

### `Unknown syntax: referenced address with index.`

A referenced expression (`#var`) also had an array index attached, which
isn't a supported combination. Use either the reference (`#var`) or the
index (`var[i]`), not both together.

### `<token type> assignment not supported yet for exp: <value>`

The value being assigned doesn't match any implemented assignment code
path for its type. Check that the variable and the expression are using
one of the supported types (`byte`, `integer`, `long`, `pointer`,
`string`).

### `You are adding together two addresses. Is this really what you intend?` (warning)

Both sides of a `+` are `address`-typed values. This is usually a
mistake (adding two memory locations rarely makes sense); if it's
intentional, the warning can be ignored.

### `Using _A, _X and _Y register values must be pure.`

An assignment to the combined `_a`/`_x`/`_y` pseudo-registers used a
computed expression on the right-hand side. Assign a plain variable or
constant instead.

### `Setting _X and _Y register values must be pure number or variable.`

An assignment to the `_x`/`_y` pseudo-registers used something other
than a plain number or variable. Simplify the right-hand side.

### `Setting _AX and _AX, and _XY register values must be pure number or variable.`

An assignment to a two-register pseudo-register pair (`_ax`, `_xy`, and
similar) used something other than a plain number or variable. Simplify
the right-hand side.

## Assignments

### `Left value not variable or memory address!`

The left-hand side of an assignment (`:=`) isn't a variable or a memory
address literal. Check that you're assigning into a declared variable.

### `Left value must be either variable or memory address, not a constant.`

The left-hand side of an assignment is a plain numeric constant. You can
only assign into a variable or an explicit memory address, not a bare
number.

### `Right hand of assign statement must be expression.`

The right-hand side of an assignment didn't parse into a valid
expression. Check the syntax after `:=`.

### `Cannot assign a pointer data to a record.`

A pointer value was assigned into something typed as a record. Assign
the pointer into an appropriately typed field or variable instead.

### `Cannot assign a record of type '<type>' to a single variable.`

The right-hand side of an assignment is a record/class value, but the
left-hand side isn't a compatible record/class target. Make sure both
sides are the same record/class type, or assign individual fields
instead.

### `Right-hand side of assignment must also be record of type '<type>'` / `Right-hand side of assignment must also be of type '<type>'`

A record/class assignment's right-hand side is either a different
record/class type, or isn't record data at all. Make both sides match
the same record/class type.

### `Can only assign strings to arrays of pointers (such as string lists)`

A `string` value was assigned to an array whose element type isn't a
pointer-style element (i.e., not a string list). Change the target
array's element type, or assign to a plain `string`/pointer variable
instead.

### `Can only assign strings to pointers, strings or arrays of strings`

A `string` right-hand side was assigned to a left-hand side that isn't a
pointer, string, or string array. Change the target variable's type.

## Loops, `break` & `continue`

### `Index cannot be register`

A `for` loop's index variable is a CPU register (such as `_x`/`_y`), which
isn't allowed as a loop index. Use a normal `byte`/`integer` variable
instead.

### `Index must be a varialbe` / `Index must be variable`

A `for` loop's index expression isn't a plain variable. Declare a
variable and use it as the loop index.

### `For unrolled loop, right value must be a constant value` / `For unrolled loop, left value must be a constant value`

An `unroll`-flagged `for` loop's start or end bound isn't a compile-time
constant. Unrolled loops need both bounds known at compile time; use
literal numbers or `const`s for the range.

### `Using integer '<var>' as a for loop index can result in unpredictable behavior on the 6502. Please keep to using byte indicies, and use pointers to cover data > 255 bytes. See the TRSE tutorials for examples.` (warning)

A 16-bit (`integer`) variable is being used as a `for` loop index. Prefer
a `byte` index and a pointer for data beyond 255 entries, as the warning
suggests, since 16-bit loop counters aren't handled reliably on 6502.

### `'Break' can only be used within a for / while loop`

`break` appeared outside any loop. Remove it, or move it inside a `for`
or `while` loop.

### `'Continue' can only be used within a for / while loop`

`continue` appeared outside any loop. Remove it, or move it inside a
`for` or `while` loop.

### `keyword onpage can only be used with 1 compare clause (no and, or etc)`

The `onpage` keyword was applied to a compound condition using `and`/`or`.
Split the condition so `onpage` only wraps a single comparison, or
remove `onpage`.
