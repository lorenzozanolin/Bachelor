.data
 vettore: .word 0,0,0,0
 
.text
PrimiNumeri:
	ldr r1,=vettore ;salvo la prima posizione del vettore
	mov r0,#1
	str r0,[r1]
	mov r0,#2
	str r0,[r1,#4]
	mov r0,#3
	str r0,[r1,#8]
	mov r0,#4
	str r0,[r1,#12]

swi 0x11
 .end