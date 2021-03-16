#include "architecture.asm"

start:
	mov a, 1
	mov b, a

loop:
	mov alu, 0b00100000
	movc pc, zero
	mov a, alu
	mov out, a
	
	mov alu, 0b00100000
	movc pc, zero
	mov b, alu
	mov out, b
	
	mov pc, loop

result:
#d8 0