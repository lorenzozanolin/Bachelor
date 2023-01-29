.data
 num: .word 1,-1,-2,-3
 
.text

somma:
	 ldr r5, =num ;r5 ora contiene l'indirizzo del primo elemento della lista
	 ldr r0, [r5] ;r0 ora contiene n1
	 ldr r6, [r5, #4] ;r6 ora contiene n2
	 add r0,r0,r6 ;r0 ora contiene n1+n2
	 ldr r6, [r5,#8] ;r6 ora contiene n3
	 add r0,r0,r6  ;r0 ora contiene n1+n2+n3
	 ldr r6, [r5,#12] ;r6 ora contiene n4
	 add r0,r0,r6 ;r0 ora contiene la somma di n1,n2,n3,n4
	 
media:
    mov r1,r0, asr #2 ;salva in r1= r0/4 -->shifta a destra di 2 bit

operazione:
	ldr r5 , [r5] ;r5 contiene n1
	mov r2, r5, lsl #10 ;moltiplico 2^10 con r5 (ovvero il primo numero) e poi ci risommo r1
	add r2, r2,r5 ;risommo appunto r5

resto16:
	mov r3, r5,lsl #4 ;shifto di 4 a sx (ovvero divido per 16)
	mov r3, r3, lsr #4 ;rimoltiplico per 16 in modo da ottenere solo la parte che c'era dopo la virgola
	
segno:
	;subs r5,r5,#1 ;vedo se il risultato setta il negative a 1 e lo zero a 1 sse i due numeri sono uguali
	;add r5,#0
	mov r4,r5,lsr#31 ;il bit alla posizione prima contiene il segno

swi 0x11
 .end
 