.data
 vettore: .word 0 ;vettore vuoto
 lunghezza: .word 4
 
.text
	
 v .req r0 ;rinomino r0 in vett
 n .req r1 ;rinomino r1 in n
 counter .req r2 ;r2 verrà usato come contatore
 
 mov counter,#0 ;azzero il counter
 ldr v,=vettore ;salvo la prima posizione del vettore
 ldr n,=lunghezza ;salvo l'indirizzo del vettore
 ldr n, [n] ;salvo la lunghezza del vettore nel registro r1
 mov r4,#0
 
CaricaVettore:

	str counter,[v], #4 ;scrivo nel vettore il valore del contatore e poi mi sposto (POST INCREMENTO) di 4, quindi r0=r0+4
	add counter,counter,#1 ;incremento il contatore
	cmp n,counter ;confronta la lunghezza del vettore con il contatore
	bgt CaricaVettore ;se non ha ancora raggiunto la dimensione desiderata allora richiamo il ciclo, ovvero se counter<=n

 ldr v,=vettore ;risposto l'indirizzo iniziale del vettore in v
 mov counter,#0 ;azzero il contatore
 
AzzeraVettore:

	cmp counter,n ;confronta la lunghezza del vettore con il valore del contatore
	beq Fine ;se sono uguali il programma ha finito
	ldr r3,[v] ;si salva in r3 il contenuto del vettore
	add counter,counter,#1 ;incrementa il counter
	ands r3,r3,#1 ;per verificare la parità fa un and tra il valore e 1, se=0 allora è pari, altrimenti è dispari e SCRIVE NEL REGISTRO DI STATO
	beq Pari ;va su pari se il risultato dell'operazione precedente fornisce 0
	add v,v,#4 ;sposta l'indice del vettore
	b AzzeraVettore 
Pari:
	str r3,[v],#4 ;scrivo 0 nella posizione v e mi sposto
	b AzzeraVettore

Fine:
 swi 0x11
 .end
 