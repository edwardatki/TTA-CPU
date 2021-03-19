#bits 8

#subruledef source {
	[mar] => 2
	a => 3
	b => 4
	c => 5
	alu => 6
	in => 7
}

#subruledef dest {
	[mar] => 1
	pc => 0
	mar => 2
	a => 3
	b => 4
	c => 5
	alu => 6
	out => 7
}

#ruledef
{
	segc {segment}, {address} 		=> 3`2 @ 0`1 @ segment`5 @ address`8
	segd {segment}					=> 3`2 @ 1`1 @ segment ` 5

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