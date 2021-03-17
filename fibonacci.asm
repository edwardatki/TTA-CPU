#include "architecture.asm"

#addr 0x0000
segment_0:


mov a, 1
mov mar, x
mov [mar], a
mov mar, y
mov [mar], a
out 0, 0x80

loop:
	mov mar, x
	mov a, [mar]
	mov mar, y
	mov b, [mar]
	mov alu, 0b01001000
	movc pc, exit
	mov mar, x
	mov [mar], alu

	mov a, ret_a
	mov mar, return
	mov [mar], a
	mov mar, x
	mov a, [mar]
	mov pc, print
	ret_a:
	
	mov mar, x
	mov a, [mar]
	mov mar, y
	mov b, [mar]
	mov alu, 0b01001000
	movc pc, exit
	mov mar, y
	mov [mar], alu
	
	mov a, ret_b
	mov mar, return
	mov [mar], a
	mov mar, y
	mov a, [mar]
	mov pc, print
	ret_b:

	
	mov pc, loop

print:
	mov mar, .temp			; Backup value
	mov [mar], a

	.loop10:
	mov b, 10
	mov alu, 0b01001001
	movc pc, .skip10		; If A less than 10
	mov a, alu				; Otherwise sub 10
	mov pc, .loop10
	.skip10:
	mov b, "0"
	mov alu, 0b01001000
	out 0, alu

	mov a, [mar]
	.loopdiv:
	mov b, 10
	mov alu, 0b01001001
	movc pc, .skipdiv
	.skipdiv:

	out 0, "\n"
	mov mar, return
	mov pc, [mar]
	
	.temp:
	#d8 0

exit:
	mov a, 1
	mov seg, a

x:
#d8 1
y:
#d8 1

return:
#d8 0

#addr 0x0100
segment_1:

end:
	out 0, "\n"
	out 0, "D"
	out 0, "o"
	out 0, "n"
	out 0, "e"
	out 0, "!"
stop:
	mov pc, stop-segment_1