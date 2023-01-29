.data
 vettore: .word 0 ;vettore vuoto
 lunghezza: .word 10
 numero: .word 2 ;numero p di cui azzerare i multipli
.text
	
 v .req r0 ;rinomino r0 in vett
 n .req r1 ;rinomino r1 in n
 P .req r2 ;r2 contiene p, ovvero il divisore degli indici da azzerare
 counter .req r3 ;r3 verra' usato come contatore
 resto .req r4 ; r4 viene utilizzato per calcolare il resto
 quoziente .req r5 ;r5 viene utilizzato per salvare il quoziente della divisione di (indice /p)
 
 mov counter,#0 ;azzero il counter
 ldr v,=vettore ;salvo la prima posizione del vettore
 ldr n,=lunghezza ;salvo l'indirizzo del vettore
 ldr n, [n] ;salvo la lunghezza del vettore nel registro r1
 ldr p,=numero
 ldr p,[p] ;salva il numero p in r2
 
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
	mov resto,counter ;salvo il contatore nel quoziente temporaneo (quello che alla fine della divisione sara' il resto)
	bl Divisione ;va alla procedura divisione salvando nel link register questo indirizzo (per poi tornare indietro)
	cmp resto,#0 ;se il resto della divisione dell'indice per p e' 0 allora vuol dire che l'indice e' multiplo
	
	beq Multiplo ;allora azzera in quella posizione
	add counter,counter,#1 ;incrementa il counter
	
	add v,v,#4 ;sposta l'indice del vettore
	b AzzeraVettore 

Divisione:
	
	cmp resto, p ;confronta il quoziente progressivo (che poi diventera' resto alla fine) con il divisore
	blt Uscita ;se non puo' piu' essere sottratto perche' p>quoziente esce, altrimenti
	sub resto, resto, p ;sottrae dal numero di partenza (quoziente) che sarebbe il counter il numero p
	add quoziente, quoziente, #1 ; e incrementa il quoziente. in realta' questo valore poi sara' il quoziente ed il resto e' quello che rimane in quoziente temporaneo
	b Divisione
	
Uscita:

	mov pc,lr ;serve per uscire dalla divisione e riporta all'istruzione successiva in cui e' stata richiamata
	
Multiplo:

	str resto,[v],#4 ;scrivo 0 nella posizione v e mi sposto
	add counter,counter,#1 ;incrementa il counter
	b AzzeraVettore

Fine:
 swi 0x11
 .end