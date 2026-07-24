# Getting Started

SANE compiles from the command line only (`-cli` mode); there is no
bundled GUI/IDE. The compiler targets the Commodore 64 exclusively.

## Compiling a downloaded example

Every runnable example on this site (on a keyword, builtin, or operator
page) links a single downloadable `.ras` source file. The compiler
doesn't have a single-file compile mode: every compile needs a **project
file** (`.trse`) and a **settings file** (`.ini`) alongside the source,
even for a one-off snippet.

To make this painless, one small, generic project bundle works for
**every** example on this site, not just one:

[:material-download: Download project.trse](assets/examples/project.trse){ .md-button download }
[:material-download: Download trse.ini](assets/examples/trse.ini){ .md-button download }

1. Download both files above into the same folder as your downloaded
   `.ras` example.
2. From that folder, run:

    ```sh
    trse -cli op=project project=project.trse settings=trse.ini input_file=<example>.ras
    ```

    replacing `<example>.ras` with whichever file you downloaded.

3. On success, this produces `<example>.prg` next to your source file
   (plus a matching `.asm` and `.sym`), ready to run in an emulator like
   VICE or on real hardware.

The project and settings files aren't tied to any particular example:
the source file to compile always comes from `input_file=` on the
command line, never from the project file itself, so the same two
downloaded files work unchanged for every example on the site. Add
`assemble=no` to the command above to stop after generating the `.asm`
without assembling a `.prg`.

See [Project & Settings Files](project-files.md) for a full, detailed
reference on every setting in both files, what each one controls, and
the rest of the command-line options.

## Where to go next

- See the [Reference](reference/keywords/index.md) section for the
  language itself, and [Examples](examples/index.md) for runnable
  programs.
