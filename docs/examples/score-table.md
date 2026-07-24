# A score table with records and arrays

A small, fixed data table built from an array of records, the pattern
behind things like a high-score list or an inventory: print every entry,
then scan the table to find the one with the highest value.

## What this uses

- [`record`](../reference/types/record.md) - groups an `id` and a
  `score` into one named type.
- [`array`](../reference/types/array.md) - holds five entries of that
  record type.
- [`for`](../reference/keywords/for.md) - both prints every row and
  scans for the highest score.

```pascal
program ScoreTable;
var
	Entry = record
		id, score : byte;
	end;

	// A small fixed table of "player id"/"score" pairs. The same array
	// could just as easily be filled in at runtime instead.
	table : array[5] of Entry;
	i, bestIndex : byte;
	bestScore : byte;

begin
	clearscreen(key_space,screen_char_loc);

	table[0].id := 1;
	table[0].score := 42;
	table[1].id := 2;
	table[1].score := 87;
	table[2].id := 3;
	table[2].score := 15;
	table[3].id := 4;
	table[3].score := 63;
	table[4].id := 5;
	table[4].score := 91;

	// Print the whole table first.
	for i:=0 to 4 do
	begin
		moveto(0,i,hi(screen_char_loc));
		printstring("player",0,40);
		moveto(7,i,hi(screen_char_loc));
		printdecimal(table[i].id,1);
		moveto(10,i,hi(screen_char_loc));
		printstring("score:",0,40);
		moveto(17,i,hi(screen_char_loc));
		printdecimal(table[i].score,3);
	end;

	// Then scan it for the highest score, keeping track of which entry
	// it belongs to.
	bestIndex := 0;
	bestScore := table[0].score;
	for i:=1 to 4 do
	begin
		if (table[i].score > bestScore) then
		begin
			bestScore := table[i].score;
			bestIndex := i;
		end;
	end;

	moveto(0,7,hi(screen_char_loc));
	printstring("highest: player",0,40);
	moveto(16,7,hi(screen_char_loc));
	printdecimal(table[bestIndex].id,1);

	loop();
end.
```

[:material-download: Download this example](../assets/examples/cookbook/score-table.ras){ .md-button download }

## How it works

`Entry` is declared once as a `record` with two `byte` fields, then used
as the element type for `table`, an ordinary five-element `array`. Each
entry is filled in field by field (`table[i].id := ...`), the same way
any single record's fields would be set. The first loop just walks the
table in order and prints every row. The second loop starts by assuming
entry `0` is the best one seen so far, then compares every remaining
entry against the current best, replacing it whenever a higher score
turns up; by the time the loop ends, `bestIndex` points at whichever
entry actually had the highest score, not just the last one checked.
