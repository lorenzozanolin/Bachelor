.data
 vettore: .word 0 ;vettore vuoto
 lunghezza: .word 4
 
.text
	
 n .req r1 ;rinomino r1 in n
 vett .req r0 ;rinomino r0 in vett
 counter .req r2 ;r2 verrà usato come contatore
 
 mov counter,#0 ;azzero il counter
 ldr vett,=vettore ;salvo la prima posizione del vettore
 ldr n,=lunghezza ;salvo l'indirizzo del vettore
 ldr n, [n] ;salvo la lunghezza del vettore nel registro r1
	
CaricaVettore:

	str counter,[vett], #4 ;scrivo nel vettore il valore del contatore e poi mi sposto (POST INCREMENTO) di 4, quindi r0=r0+4
	add counter,counter,#1 ;incremento il contatore
	cmp n,counter ;confronta la lunghezza del vettore con il contatore
	bgt CaricaVettore ;se non ha ancora raggiunto la dimensione desiderata allora richiamo il ciclo, ovvero se counter<=n

swi 0x11
 .end