# Syntax, types & variables

Errors from the earliest stages of compiling a program: turning source
text into tokens, checking that statements and declarations are written
correctly, and resolving variable, constant, and type names.

## Tokens & syntax

### `Chars chan only contain one symbol`

A character literal (`'x'`) contains more than one character before the
closing quote. Character literals must hold exactly one character; use a
string (double quotes) for multiple characters.

### `Error parsing: <char>`

The lexer hit a character that isn't valid anywhere in TRSE source, such
as a stray symbol left over from pasting formatted text. Remove or
replace the offending character.

### `Expected '<expected>' but found '<actual>'` (followed by "Did you forget a semicolon (;) ?")

The parser expected a specific token (often `;`, `)`, or `end`) at this
point and found something else. This is most commonly a missing
semicolon on the previous line, but can also be an unbalanced
parenthesis or a misplaced keyword.

### `Preprocessor '@endif' mismatch error`

An `@endif` was found with no matching open `@if`/`@ifdef` before it.
Check that every `@if`/`@ifdef` in the file has exactly one `@endif`, and
that they're not accidentally nested wrong.

### `You cannot have an else block without having an if statement`

An `@else` preprocessor directive appeared without a preceding `@if`.
Add the missing `@if`, or remove the stray `@else`.

### `Value required to be a number or a constant.`

A context that only accepts a literal number or a previously declared
constant found something else (a variable, an expression). Replace it
with a numeric literal or a `const`.

### `Mismatced paranthesis when parsing number`

Parenthesis nesting is unbalanced inside a numeric/constant expression.
Count the opening and closing parentheses in the expression and fix the
mismatch.

### `Error parsing number : <text>`

Two numeric tokens appeared back-to-back with no operator between them
(for example a stray digit or missing `+`/`-`). Add the missing
operator, or remove the extra token.

### `After declarations, BEGIN is expected`

The main program's declaration section (`var`, `const`, procedures) was
not followed by `begin`. Make sure every declaration ends with a `;` and
that `begin` immediately follows the last one.

### `Expected THEN or DO after conditional`

An `if` condition wasn't followed by `then`, or a loop condition wasn't
followed by `do`. Add the missing keyword.

### `Did you forget a semicolon? (Token should not be ID in Parser)`

An identifier turned up where the parser expected either a new statement
or the end of a block. This almost always means a semicolon is missing
after the previous statement.

### `Syntax error`

A generic fallback: the parser reached the end of input while still
expecting to parse an expression. Check for an unclosed block, missing
`end`, or an incomplete expression near the end of the file.

### `End of file error`

The file ended before the parser expected it to (the main program body
wasn't properly closed). Check for a missing final `end.` or an
unbalanced `begin`/`end` pair somewhere above it.

### `Uknown token '<token>'. Please separate your parametes by commas.`

While parsing an inline function's parameter list, a token turned up
that wasn't a comma or closing parenthesis. Check the parameter list for
a missing comma.

### `Unexpected token '<value>'`

A variable declaration list hit a token where a comma or closing
parenthesis was expected. Check the declaration for a typo or missing
separator.

### `For loop needs a 'DO' keyword`

A `for` loop's header wasn't followed by `do` within the expected number
of tokens. Check the loop bounds and make sure `do` is present.

### `Error assigning variable '<value>', did you forget a colon or mistype? Syntax should be: 'a := b;'.`

An assignment statement was expected but `:=` wasn't found after the
left-hand side. The most common cause is writing `=` instead of `:=`.

### `Did you mean to use bit and/or (&, |) instead of logical and/or?`

`and`/`or` were used somewhere that looks like a bitwise expression on
numeric values. TRSE's `and`/`or` are logical (boolean) operators; use
`&`/`|` for bitwise operations on `byte`/`integer` values.

## Types & declarations

### `'<name>' is a reserved keyword, not a type.`

A variable or parameter declaration used a language keyword as if it
were a type name. Rename the type, or check for a typo that happens to
collide with a keyword.

### `Unknown or illegal type : '<type>'.` (sometimes followed by `Did you mean '<similar>'?`)

The declared type isn't a known record/class name and isn't one of the
compiler's built-in base types. The only real base types on this fork's
C64 target are `byte`, `address`, `integer`, `pointer`, `array`,
`boolean`, `string`, and `long`; there is no `word`, `float`, or
`ppointer`. If the message suggests a similar name, that's very likely
the fix (a typo of an existing type or record name).

### `TRSE doesn't support classes on this CPU yet`

A `class` declaration was used, but the current compile target doesn't
support classes. Use a `record` instead, or a plain set of variables.

### `Procedures and funtions can only be declared in classes, not in records`

A `procedure`/`function`/`interrupt` was declared inside a plain
`record` block. Records can only hold data fields; move the routine out
of the record, or change the record to a `class` if it needs its own
methods.

### `Can only assign an object of a record/class to another object of the same type`

A record/class variable was assigned a value that isn't a matching
record/class instance. Make sure both sides of the assignment are the
same record/class type.

### `Class variables cannot have default values. These must be set manually or in a constructor (which is currently not yet implemented)`

A field inside a `class` declaration was given an initializer value.
Remove the initializer and set the field's value in code after the
object exists instead.

### `Unknown or illegal type : '<value>'.` (assignment context, with optional similar-name hint)

Same underlying check as the general "Unknown or illegal type" error
above, hit while resolving the left-hand side of an assignment. Check
the variable's declared type for a typo.

### `String declaration must be single string or paranthesis with multi values.`

A `string` variable's initializer wasn't a plain string literal or a
parenthesized, comma-separated list of values. Check the initializer's
syntax.

### `String error!`

A string-list initializer parsed more than 10000 comma-separated
elements, which is treated as a runaway parse rather than a legitimate
declaration. Check for a missing closing parenthesis or quote earlier in
the declaration.

### `Stack parameters can currently only be 'byte'`

A procedure parameter marked `stack` was declared with a type other than
`byte`. Change the parameter's type to `byte`, or drop the `stack`
modifier if another type is needed.

### `TRSE currently only supports return values of type 'byte', 'integer', 'boolean' and 'long'`

A function's declared return type isn't one of those four. Change the
return type, or restructure the function to return one of the supported
types (for example, returning a pointer's address as an `integer`).

### `Unknown or illegal type when defining constant of type: '<value>' (<token type>)` (followed by "Allowed types are : address, byte, integer.")

A `const` declaration's value doesn't resolve to one of the types a
constant can hold. Rewrite the constant's value as an address, byte, or
integer literal (also `long`, which the message text doesn't mention but
the compiler does accept).

### `Type already defined: <name>`

A `type = ...` alias declaration reused a name that's already a type.
Pick a different alias name.

### `You cannot have arrays of (zeropage) pointers on the 6502. Instead, please use an array of integers, and then assign a pointer to the (integer) array item.`

An array was declared with `pointer` as its element type, which the
6502 target can't support directly. Declare the array as `integer`
instead, and assign pointer values into individual elements as needed.

### `You cannot declare an array of records that contain sub-arrays due to 6502 limitations. Please remove the sub-array from the record type in question : '<type>'.`

An array of a record type was declared, and that record itself contains
an array field, which isn't supported together. Remove the array field
from the record, or restructure the data to avoid nesting an array
inside a record that's itself used in an array.

### `Must point to either byte, integers, long (m68k/mega65).`

A `pointer` declaration's target type isn't `byte`, `integer`, `long`,
or a class. Change the pointee type to one of those.

### `On the 6502, pointers must be initialized through code. Z80/M68K pointer initialization not yet implemented in TRSE.`

A `pointer` variable declaration included a `= value` initializer, which
isn't supported on 6502 targets. Remove the initializer and assign the
pointer's value in code instead.

### `You cannot declare pointers in records/classes on this CPU type. Please use an integer to store the address instead, and assign a pointer to it when required.`

A `pointer`/`lpointer` field was declared inside a `record`/`class` on a
target that doesn't allow it (this includes the C64). Store the address
in an `integer` field instead, and treat it as a pointer manually where
needed.

### `Procedure type '<value>' on this system does not support the flag '<flag>'` / `Globally defined type '<value>' on this system does not support the flag '<flag>'`

A type flag (such as `chipmem` or `aligned`) was applied somewhere the
current target doesn't support it. Remove the flag, or check which
flags the C64 target actually supports for that kind of declaration.

### `Type flag 'no_term' is only allowed for strings.`

The `no_term` flag was applied to a non-`string` type. Remove the flag,
or change the variable to a `string`.

### `Type flag 'invert' is only allowed for cstrings.`

The `invert` flag was applied to a type other than `cstring`. Remove the
flag, or change the variable to a `cstring`.

### `Cannot initialise record data for '<name>' when placed at a specific memory location (<position>)`

A record-typed variable was placed at an explicit `@address` and also
given initializer data, which isn't supported together. Either drop the
explicit address, or drop the initializer and set the fields in code.

### `Cannot declare variable of type: <type>`

The assembler stage was asked to reserve storage for a variable whose
type doesn't map to any known storage directive. This usually traces
back to a type that isn't actually one of the supported base types;
check the variable's declared type.

### `Record types does not support strings (yet) for record : <type>` / `Record types does not support strings for record : <type>, please use classes instead.`

A record field was declared with type `string`, which records don't
support. Use a `class` instead of a `record` if a string field is
needed, or replace the field with a `cstring`/byte-pointer approach.

## Variables, constants & symbols

### `Could not find constant/symbol : '<value>'`

An identifier used where a constant or number was expected couldn't be
resolved to any known constant. Check the name for a typo, or make sure
it's declared as a `const` before use.

### `Could not assign variable!`

The left-hand side of an assignment didn't resolve to anything
assignable. Check that the variable on the left of `:=` is actually
declared.

### `Could not find variable/procedure : <name>. Are you sure it is defined?`

An indexed expression (`name[...]`) referenced a name that isn't a known
variable or procedure. Check the spelling, and that it's declared before
use (or `@use`d, if it comes from a unit).

### `Variable '<name>' is neither a pointer nor an array.`

Index syntax (`name[...]`) was used on a variable that isn't an array,
pointer, or string. Remove the indexing, or change the variable's type.

### `Assignment '<token>' cannot be a reference.`

The left-hand side of `:=` was written as a reference (`#var := ...`),
which isn't valid; you can only take the reference of a variable to pass
it somewhere, not assign through it directly. Remove the `#`.

### `Unknown compare type : '<token>'. Did you mean '=' or '>' etc?`

A comparison inside a `case`/conditional clause used a token that isn't
a recognized comparison operator. Check for a typo of `=`, `<`, `>`,
`<=`, `>=`, or `<>`.

### `Procedure '<name>' is already declared with identical parameters.`

An overloaded procedure was declared twice with the exact same parameter
types. Either change one version's parameters, or remove the duplicate.

### `TRU '<name>' is already defined!`

The same unit was `@use`d twice under the same name. Remove the
duplicate `@use` line.

### `Internal function 'Length' reqruires a variable`

`Length(...)` was called on something that isn't a resolvable variable
(for example, a literal or an expression). Pass a declared variable
instead.

### `Can only cast strings to cstrings.`

The cstring-cast built-in was applied to something other than a
`string`. Make sure the argument being cast is a `string` variable or
literal.

### `Function return name needs to be identical the name of the function itself.`

Inside a function body, `name := value;` was used to set the return
value, but `name` doesn't match the enclosing function's own name.
Rename it to match the function.

### `Only functions can have intrinsic return values.`

A `procedure` (not a `function`) tried to set a return value using the
`name := value;` form. Either declare it as a `function`, or remove the
return-value assignment.

### `You can only set the return value once in the scope of the function.`

A function's return-value assignment (`funcname := value;`) appeared
more than once in the same function. Keep only one assignment (it can
still be inside different branches, just not written twice
unconditionally in the same scope).

### `Could not find procedure :<name>`

An inline-call parameter list referenced a procedure name that isn't
declared anywhere. Check the spelling and that the procedure exists
before this point in the file.

### `TRUs must contain at least one "var" declaration block.`

A `.tru` unit file has no `var` section at all. Add at least an empty
`var` block, even if the unit doesn't declare any variables.

### `Current system does not support inclusive for (FORI).`

`FORI` was used on a target that doesn't implement the inclusive-bound
for-loop variant. Use a regular `for` loop instead, adjusting the bound
by one if needed.

### `Forward declared procedure '<name>' has incorrect number of parameters.`

A procedure's actual implementation has a different number of
parameters than its earlier `forward` declaration. Make the two
parameter lists match exactly.

### `Forward declared procedure '<name>' has incorrect or missing declared parameter '<param>'`

A forward-declared procedure's parameter name doesn't match at the same
position in the implementation. Rename the parameter to match, or fix
the parameter order.

### `Forward declared procedure '<name>' has incorrect declared parameter type for parameter '<param>', should be <type>`

A forward-declared procedure's parameter type doesn't match its
implementation. Change one side so the types agree.

### `Procedure '<name>' already defined`

A procedure name (that isn't overloaded and isn't a forward declaration
being fulfilled) collides with an existing declaration. Rename it, or
remove the duplicate.

### `Unknown usage of data or array. Did you mean to reference it? (#<name>)`

An array or `incbin`/data variable was used bare, with no index and no
`#` reference, somewhere that needs one or the other. Add `[index]` to
read a single element, or `#name` to get its address.

### `Variable '<name>' is an array and must be indexed`

An array variable was used as a record/class member without an
`[index]`. Add the missing index.

### `Symbol '<name>' is already defined.`

A `const` declaration's name collides with an existing symbol. Rename
the constant.

### `Unknown declaration : <token>`

The declarations section hit a token that doesn't start any recognized
kind of declaration (`var`, `const`, `type`, a procedure, and so on).
Check for a typo or a misplaced statement above the `begin` of the
program.

### `Illegal variable name '<name>' on the <system> (name already used in the assembler etc)`

A variable name collides with a name reserved by the assembler or
target system (for example, a 6502 mnemonic or register name).
Rename the variable.

### `'<name>' is already defined as a constant.`

A variable declaration reuses a name that's already a `const`. Rename
the variable, or the constant.

### `TRSE does not support string parameters. Please use a byte pointer parameter instead`

A procedure parameter was declared with type `string`. Declare it as a
`pointer` to `byte` instead, and pass the string's address.

### `Cannot declare variables that start with 'global_' in TRSE, since this prefix is used internally`

A variable name starts with `global_`, which the compiler reserves for
its own internal use. Rename the variable.

### `Variable '<name>' is already defined!`

A `var` declaration's name already exists in the current scope. Rename
it, or remove the duplicate declaration.

### `Unknown subnode: '<value>'`

While resolving a record/class member-access chain (`a.b.c`), one of the
links in the chain wasn't itself a plain variable reference. Check the
member-access expression for a typo or an unsupported construct.

### `Could not find global variable '<name>'. If you declared '<name>' as a global procedure variable within a class, then please declare it as '<unit>::<name>'.`

A name was only found in its unit-qualified form. Add the missing
`Unit::` prefix when referencing a variable declared inside a class or
unit from outside it.

### `Could not find variable '<name>'.` (sometimes followed by `Did you mean '<similar>'?`)

A symbol name couldn't be resolved anywhere in scope. Check the spelling
(the suggested name, if one is shown, is very likely the fix), and make
sure the variable is declared, or its unit is `@use`d, before this point.

### `Symbol/variable '<name>' does not exist in the current scope`

The name isn't present anywhere in the symbol table at all. Declare it,
or check for a typo.

### `Record/class '<name>' does not contain any variable '<var>'`

A member-access expression referenced a field name that isn't part of
that record/class type. Check the field name against the record/class's
actual declaration.
