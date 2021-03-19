#include "architecture.asm"

#bankdef bank_0
{
    #addr 0x0000
    #size 0x0100
    #outp 0*8*0x100
}

; Set intial values
mov a, 1
mov mar, x
mov [mar], a
mov mar, y
mov [mar], a

; Calculate fibonacci sequence
loop:
	; Get next value in sequence
	mov mar, x
	mov a, [mar]
	mov mar, y
	mov b, [mar]
	mov alu, 0b00010000 ; A add B
	movc pc, exit
	mov a, alu
	mov mar, x
	mov [mar], a
	
	; Print value
	mov c, ret_a
	mov mar, print_val-1
	mov [mar], c
	mov pc, print_val
	ret_a:
	
	; Get next value in sequence
	mov mar, x
	mov a, [mar]
	mov mar, y
	mov b, [mar]
	mov alu, 0b00010000 ; A add B
	movc pc, exit
	mov a, alu
	mov mar, y
	mov [mar], a
	
	; Print value
	mov c, ret_b
	mov mar, print_val-1
	mov [mar], c
	mov pc, print_val
	ret_b:
	
	mov pc, loop


; A / B
; Result in C
; Remainder in A
#d8 0
divide:
	mov c, 0
	.loop:
	mov alu, 0b00010001 ; A sub B
	movc pc, .skip
	mov a, alu
	mov alu, 0b01111000	; Inc C
	mov c, alu
	mov pc, .loop
	.skip:

	; Return
	mov mar, divide-1
	mov pc, [mar]

#d8 0
print_val:
	; Divide by 100
	mov b, 100
	mov c, .ret_a
	mov mar, divide-1
	mov [mar], c
	mov pc, divide
	.ret_a:
	mov b, "0"
	mov alu, 0b00011000 ; C add B
	mov out, alu

	; Divide by 10
	mov b, 10
	mov c, .ret_b
	mov mar, divide-1
	mov [mar], c
	mov pc, divide
	.ret_b:
	mov b, "0"
	mov alu, 0b00011000 ; C add B
	mov out, alu
	mov alu, 0b00010000 ; A add B
	mov out, alu

	mov out, "\n"

	; Return
	mov mar, print_val-1
	mov pc, [mar]

exit:
	segc 1, end

x:
#d8 1
y:
#d8 1

#bankdef bank_1
{
    #addr 0x0000
    #size 0x0100
    #outp 1*8*0x100
}

end:
	segd 1

	mov a, end_str
	mov c, .ret
	mov mar, print_str-1
	mov [mar], c
	mov pc, print_str
	.ret:

	mov a, far_str
	mov c, .loop
	mov mar, print_str-1
	mov [mar], c
	segd 2
	mov pc, print_str

; Echo terminal input back
.loop:
	; Check for new data
	mov a, in
	mov b, 0b10000000
	mov alu, 0b00010010	; A NAND B
	mov a, alu
	mov alu, 0b00000010	; NOT A
	movz pc, .skip

	; Output and advance input buffer
	mov out, in
	mov out, 0x80
.skip:
	mov pc, .loop

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

	segd 1
	mov out, "\n"

	; Return
	mov mar, print_str-1
	mov pc, [mar]

end_str:
#d "Done!\0"

#bankdef bank_2
{
    #addr 0x0000
    #size 0x0100
    #outp 2*8*0x100
}

far_str:
#d "This data is from a different segment", 0x00