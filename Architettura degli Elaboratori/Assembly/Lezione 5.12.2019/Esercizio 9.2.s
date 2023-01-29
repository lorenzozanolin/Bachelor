.data
 vettore: .word 2,3,4
 
.text
Quadruplo:
	ldr r1,=vettore ;salvo la prima posizione del vettore
	ldr r0,[r1] ;carico dal vettore l'elemento desiderato
	mov r2,#4 ;salvo 4 in un registro per poterlo moltiplicare
	mul r3,r0,r2 ;moltiplico per 4
	str r3,[r1] ;lo salvo
	
	ldr r0,[r1,#4] ;carico dal vettore l'elemento desiderato
	mov r2,#4 ;salvo 4 in un registro per poterlo moltiplicare
	mul r3,r0,r2 ;moltiplico per 4
	str r3,[r1,#4] ;lo salvo
	
	ldr r0,[r1,#8] ;carico dal vettore l'elemento desiderato
	mov r2,#4 ;salvo 4 in un registro per poterlo moltiplicare
	mul r3,r0,r2 ;moltiplico per 4
	str r3,[r1,#8] ;lo salvo

swi 0x11
 .end