# Files & assets

Errors about locating source, include, and asset files (images, sprites,
music, SID/NSF tunes, binary blobs), plus the command-line batch-build
script's own errors.

## Include & unit files

### `Could not open file for inclusion: <filename>`

An `@use`/include directive named a file that doesn't exist, or isn't
readable. Check the path and filename.

### `Could not find TRU file for inclusion : <name>` (followed by "Tried dirs: ...")

`@use <Unit>` couldn't find the named `.tru` unit file in any of its
search directories (the local directory, then the system-specific unit
folder, then the shared CPU/global unit folders). Check the unit name's
spelling and casing.

### `Could not find file for inclusion: <file>`

A binary-split/include directive referenced a `.bin` fragment file that
doesn't exist. Check the path.

## User-directed file operations

### `Could not find file to copy: <source>`

An `@copyfile`-style directive's source file doesn't exist. Check the
path.

### `Could not find file to add to header: <source>`

A directive that appends a file's contents to the program header
couldn't find its source file. Check the path.

### `splitfile split position must be lower than file size!`

`@splitfile`'s given split offset is larger than the file itself. Use an
offset smaller than the file's actual size.

### `The following file is required for compilation: '<file>'.` (with a custom author-supplied message)

A "require file" preprocessor directive found its named file missing.
The custom message that follows (written by whoever authored the
project) explains what to do; typically it means a data file needs to be
placed alongside the source before compiling.

### `In order to compress files, please set up the 'lz4' path in the 'Utilities' section in the TRSE settings panel.`

A compression directive was used, but no `lz4` tool path is configured.
Set the `lz4` path in the project's settings.

## Images, sprites & data export

### `File not found : <file>`

Raised by numerous image/binary export directive handlers (palette
export, subregion export, general export, compressed export, CPC/PBM/VBM
variants, frame export) when the named input image or binary file
doesn't exist. Check the path given to the directive.

### `Could not find file :<file>`

The same "input file missing" condition, raised by the black-and-white
image export handler.

### `Could not find file : <file>`

The same condition again, raised by the sprite-compiler directive when
its source image is missing.

### `Bin2Inc error: could not open file <file>`

The `@bin2inc` directive's input binary file doesn't exist. Check the
path.

### `Pathtool error: could not open file <file>`

A path-drawing tool directive's input file is missing. Check the path.

### `Importing char error : unknown filetype for '<file>'` / `Importing char error : unknown filetype for input binary '<file>'`

A char/sprite-import directive couldn't identify the input file's format
from its extension/contents. Use one of the supported image formats.

### `Unknown image type : <type>. For now, only 'gameboy' and 'snes' is supported.`

A char/sprite-export directive named an image type other than `gameboy`
or `snes`. Use one of those two values (this applies to a shared
cross-target codegen path; the value has no effect on the C64-only
target beyond validating the parameter).

### `Added new sprite data from '<file>' : sprite from <position> to <size>. Sprite size: <n>` (informational, not an error)

Printed after `HandleSpriteCompiler` successfully compiles sprite data.
No action needed.

## Music & sound files

### `Unable to load '<file>', must be sid file!`

A `PlaySID`-style include's filename doesn't end in `.sid`. Rename or
point at an actual `.sid` file.

### `Unable to load '<file>', must be NSF file!`

An NSF-include's filename doesn't end in `.nsf`. Rename or point at an
actual `.nsf` file.

### `Unable to locate '<file>'`

The named `.sid`/`.nsf` file doesn't exist on disk. Check the path.

### `File '<file>' not identified as a SID file`

The file's header bytes don't match the PSID/RSID magic signature
expected of a real SID file. Use a genuine `.sid` file.

### `File '<file>' not identified as a NSF file`

The file's header bytes don't match the NESM magic signature expected of
a real NSF file. Use a genuine `.nsf` file.

### `Could not find music for inclusion : <file>.asm`

The AKG music compiler couldn't produce or find the expected `.asm`
output for an included music file. Check that the source music file
compiles correctly on its own.

## Disk images & the Krills fastloader

### `Could not locate paw file for building: <file>`

A directive that builds a disk image from a `.paw` project file couldn't
find that file. Check the path.

### `One of your disk files is missing a name. Please correct the .paw file!`

A disk-image build referenced a file entry in the `.paw` file that has
no name set. Add the missing name in the `.paw` file.

### `When using krills loader, the loader location must be either 0200, 1000,2000 etc`

`@use KrillsLoader` was given a loader address that doesn't have a
matching prebuilt loader file. Use one of the supported loader
addresses.

### `When using krills loader, the installer location must be either 1000, 2000, 3000 etc`

Same directive, for the installer address; use one of the supported
values.

### `Something went wrong with the krill loader implementation: please make sure that the loader line is exactly of the following format (including spaces and letter cases etc): '@use KrillsLoader $0200 $2000 $3000 '`

The generated loader source didn't contain the exact marker line the
build step expects. Copy the `@use KrillsLoader` line exactly as shown,
including spacing and letter case.

## User-triggered directive messages

### `@raiseerror "<message>"` / `@error "<message>"`

These preprocessor directives let a project's own source raise a custom
compile error with arbitrary text. The message is written by whoever
authored the code using the directive; follow its instructions.

### `@raisewarning "<message>"` (warning)

Same idea as `@raiseerror`, but non-fatal: prints the author-supplied
warning text and continues compiling.

## Command-line batch build script

These come from the CLI's batch/multi-file build-script runner, not from
compiling a single `.ras`/`.tru` file directly.

### `Could not find source file: <file>`

The batch build script named a source file that doesn't exist. Check the
path in the build script.

### `Error during assembly : <output>`

The compiled source failed at the assembler stage; the assembler's own
output is embedded in the message and explains the actual problem (see
the [assembler & internal errors](assembler-and-internal-errors.md)
page).

### `Error compiling : <file>` (followed by the compiler's own output)

The compile stage itself failed; the embedded output is the actual
compiler error, which is what to look up (elsewhere in this reference).

### `Build command 'define' requires two parameters: name and value`

A build-script `define` line doesn't have exactly two arguments. Add the
missing name or value.

### `Build command 'b' requires an input file`

A build-script `b` (build) command has no filename argument. Add the
source filename.

### `Error: setvalue requires 2 parameters: a name and a float`

A build-script `setvalue` command doesn't have exactly two arguments.
Add the missing name or value.
