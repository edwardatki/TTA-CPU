#include "architecture.asm"
#include "fibonacci.asm"

#bankdef bank_0
{
    #addr 0x0000
    #size 0x0100
    #outp 0*8*0x100
}

main:
	segd 0
	mov a, start_str
	mov c, .ret
	mov mar, print_str-1
	mov [mar], c
	mov pc, print_str
	.ret:
	
	; Check for new data
	.loop:
	mov a, in
	mov b, 0b01111111
	mov alu, 0b00010010	; A NAND B
	mov a, alu
	mov alu, 0b00000010	; NOT A
	movz pc, .skip
	
	mov a, alu
	mov out, 0x80
	mov b, 0x30
	mov alu, 0b00010001 ; A sub B
	movz pc, .prog_0
	
	.skip:
	mov pc, .loop
	
	.prog_0:
		segc 1, 0

; Print string at address stored in A
#d8 0
print_str:
	mov mar, a
	
	.loop:
	mov a, [mar]
	mov alu, 0b00110000 ; No operation, just set flags
	movz pc, .skip
	mov out, a
	mov alu, 0b01111100 ; Inc MAR
	mov mar, alu
	mov pc, .loop
	.skip:

	mov out, "\n"

	; Return
	mov mar, print_str-1
	mov pc, [mar]
	
start_str:
#d "Select program:\n0: Fibonacci\0"