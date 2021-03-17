#bits 8

#subruledef source {
	[mar] => 2
	a => 3
	b => 4
	c => 5
	alu => 6
}

#subruledef dest {
	[mar] => 0
	pc => 1
	mar => 2
	a => 3
	b => 4
	c => 5
	alu => 6
	seg => 7
}

#ruledef
{
	out {port}, {s:source} 			=> 3`2 @ port`3 @ s`3
	out {port}, {value:i8} 			=> 3`2 @ port`3 @ 1`3 @ value`8

	mov {d:dest}, {s:source} 		=> 0`2 @ d`3 @ s`3
	mov {d:dest}, {value:i8} 		=> {
		assert (value > 0) 
		0`2 @ d`3 @ 1`3 @ value`8
	}
	mov {d:dest}, {value:i8} 		=> {
		assert (value == 0) 
		0`2 @ d`3 @ 0`3
	}

	movz {d:dest}, {s:source} 		=> 1`2 @ d`3 @ s`3
	movz {d:dest}, {value:i8} 		=> {
		assert (value > 0) 
		1`2 @ d`3 @ 1`3 @ value`8
	}
	movz {d:dest}, {value:i8} 		=> {
		assert (value == 0) 
		1`2 @ d`3 @ 0`3
	}
	
	movc {d:dest}, {s:source} 		=> 2`2 @ d`3 @ s`3
	movc {d:dest}, {value:i8} 		=> {
		assert (value > 0) 
		2`2 @ d`3 @ 1`3 @ value`8
	}
	movc {d:dest}, {value:i8} 		=> {
		assert (value == 0) 
		2`2 @ d`3 @ 0`3
	}
}