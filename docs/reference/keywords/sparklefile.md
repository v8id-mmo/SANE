# `@sparklefile`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Embeds a Sparkle 3 disk-authoring script directly inside the source file,
used when building a multi-file D64 disk image with the external
[Sparkle 3](https://csdb.dk/release/?id=236718) tool (a C64-scene disk
loader/builder). The quoted text after `@sparklefile` becomes the content
of the `.sls` script Sparkle 3 is invoked with, listing which files go on
the disk and where. It's a niche feature: it only matters for a project
that actually builds a D64 image through Sparkle 3, which needs to be
downloaded separately and linked in the compiler's settings.

## Syntax

    @sparklefile

    "<Sparkle 3 script text>"

## Parameters

- `<Sparkle 3 script text>`: the full Sparkle 3 `.sls` script, as a
  quoted string (typically spanning several lines). Its format is defined
  by Sparkle 3 itself, not by this compiler.

## Example

```pascal
program SparkleFileDemo;

@sparklefile

"
<< main file

<<ZP: 80
<<Header: sparkleme
<<name: sparklefiledemo
<<Start:		1000
Tracks:		40

File:	sparklefile.prg
"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/sparklefile.ras){ .md-button download }
