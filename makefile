all:
	customasm fibonacci.asm -f logisim8 -o fibonacci.lbi
	customasm fibonacci.asm -f annotated -o fibonacci.txt
	cat fibonacci.txt
