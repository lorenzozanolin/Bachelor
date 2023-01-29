.data
 vettore: .word 0 ;vettore vuoto
 lunghezza: .word 21

.text
	
 v .req r0 ;rinomino r0 in vett
 n .req r1 ;rinomino r1 in n
 counter .req r2 ;r2 verra usato come contatore (verra considerato come numero con cui fare i confronti)
 secondoNum .req r3 ;r3 verra' usato per rappresentare l'indice del secondo numero da confrontare (per vedere se e' multiplo)
 resto .req r4 ; r4 viene utilizzato per calcolare il resto
 quoziente .req r5 ;r5 viene utilizzato per salvare il quoziente della divisione di (indice /p)
 
 mov counter,#0 ;azzero il counter
 ldr v,=vettore ;salvo la prima posizione del vettore
 ldr n,=lunghezza ;salvo l'indirizzo del vettore
 ldr n, [n] ;salvo la lunghezza del vettore nel registro r1
 
 
CaricaVettore:

	str counter,[v], #4 ;scrivo nel vettore il valore del contatore e poi mi sposto (POST INCREMENTO) di 4, quindi r0=r0+4
	add counter,counter,#1 ;incremento il contatore
	cmp n,counter ;confronta la lunghezza del vettore con il contatore
	bge CaricaVettore ;se non ha ancora raggiunto la dimensione desiderata allora richiamo il ciclo, ovvero se counter<=n

 ldr v,=vettore ;risposto l'indirizzo iniziale del vettore in v
 mov counter,#0 ;azzero il contatore
 str counter,[v,#4] ;azzero il vettore in posizione 1, in quanto l'1 non e' un numero primo
 mov counter,#2 ;parto dall'indice 2 del vettore dato che ho gia azzerato l'1
 mov secondoNum,#3 ;secondoNum parte dall'indice successivo
 sub v,v,#4
 
AzzeraVettore:

	cmp counter,n ;confronta la lunghezza del vettore con il valore del contatore
	beq Fine ;se sono uguali il programma ha finito

;----------
CercaMultipli: ;preso il primo numero (counter), lui lo confronta con tutti gli altri indici finche non arriva in fondo
	
	cmp secondoNum,n ;confronta il secondo numero con la lunghezza del vettore
	bgt Ciclo2Finito ;se ha passato tutti gli elementi del vettore allora puo' uscire dal ciclo e cambiare primo numero
	
	mov resto,secondoNum ;salvo il contatore nel quoziente temporaneo (quello che alla fine della divisione sara' il resto)
	bl Divisione ;va alla procedura divisione salvando nel link register questo indirizzo (per poi tornare indietro)
	cmp resto,#0 ;se il resto della divisione dell'indice per p e' 0 allora vuol dire che l'indice e' multiplo
	beq Multiplo ;allora azzera in quella posizione se e' multiplo
	add secondoNum,secondoNum,#1 ;incrementa il secondo numero
	b CercaMultipli

;-----------
Ciclo2Finito:
	;una volta uscito dal cerca multipli vuol dire che ha trascorso il vettore con il primo numero, percio' procede cambiandolo
	add counter,counter,#1 ;incrementa il counter(ovvero il numero fisso di riferimento)
	add secondoNum,counter,#1;il secondo numero ora deve valere uno in più del primo
	b AzzeraVettore 

Divisione:
	
	cmp resto, counter ;confronta il quoziente progressivo (che poi diventera' resto alla fine) (resto contiene il secondo numero) con il divisore (ovvero il numero fissato per il ciclo intermedio)
	blt Uscita ;se non puo' piu' essere sottratto perche' p>quoziente esce, altrimenti
	sub resto, resto, counter ;sottrae dal numero di partenza (quoziente) che sarebbe il counter il numero p
	add quoziente, quoziente, #1 ; e incrementa il quoziente. in realta' questo valore poi sara' il quoziente ed il resto e' quello che rimane in quoziente temporaneo
	b Divisione
	
Uscita:

	mov pc,lr ;serve per uscire dalla divisione e riporta all'istruzione successiva in cui e' stata richiamata
	
Multiplo:
	ldr v,=vettore ;risposta l'indice del vettore all'inizio dato che devo svolgere la moltiplicazione
	mov r7,#4 ;4 e' lo shift per passare dalla cella n alla cella n+1 ; tocca usare un registro perche la mul non vuole costanti
	mul r6,r7,secondoNum ;r6 conterra' la posizione dell'indice da resettare
	str resto,[v,r6] ;scrivo 0 nella posizione v (che all'inizio dovra' essere posizionata nell'indice 2) e mi sposto
	add secondoNum,secondoNum,#1 ;incrementa il secondo numero
	b CercaMultipli

Fine:
 swi 0x11
 .end