.data
 vettore: .word 2,3,4
 
.text
ShiftVettore:
	ldr r1,=vettore ;salvo la prima posizione del vettore
	
	;2->3
	ldr r0,[r1,#8] ;carico dal vettore l'ultimo elemento
	ldr r2,[r1,#4] ;carico dal vettore il penultimo elemento
	str r2,[r1,#8] ;lo salvo
	
	;1->2
	ldr r2,[r1] ;carico il primo elemento dal vettore
	str r2,[r1,#4]
	str r0,[r1]

swi 0x11
 .end