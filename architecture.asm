#bits 8

#subruledef source {
	[mar] => 2
	zero => 0
	a => 3
	b => 4
	alu => 5
	in => 7
}

#subruledef dest {
	[mar] => 0
	pc => 1
	mar => 2
	a => 3
	b => 4
	alu => 5
	out => 7
}

#ruledef
{
	mov {d:dest}, {s:source} 	=> 0`2 @ d`3 @ s`3
	mov {d:dest}, {value} 		=> 0`2 @ d`3 @ 1`3 @ value`8
	
	movz {d:dest}, {s:source} 	=> 1`2 @ d`3 @ s`3
	movz {d:dest}, {value} 		=> 1`2 @ d`3 @ 1`3 @ value`8
	
	movc {d:dest}, {s:source} 	=> 2`2 @ d`3 @ s`3
	movc {d:dest}, {value} 		=> 2`2 @ d`3 @ 1`3 @ value`8
}