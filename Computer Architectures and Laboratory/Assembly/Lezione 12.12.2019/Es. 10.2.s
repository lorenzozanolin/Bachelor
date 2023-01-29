.data
 numeri: .word 2,2 ;vettore contenente i numeri utilizzati 1->a 2->m
 
.text
 a .req r0 ;rinomino r0 in a
 m .req r1 ;rinomino r1 in m
 exp .req r2 ;r2 verrà usato come contatore (per l'esponente)
 
 mov exp,#1 ;metto l'esponente a 1 
 ldr a,=numeri ;salvo la prima posizione del vettore
 ldr m,[a,#4] ;salvo il valore di m nel registro m
 ldr a, [a] ;salvo il valore di a in r0
 mov r3,a ;inizializzo il registro r3
 mov r4,a ;inizializzo il registro r4
	
CercaPotenzaVicina: ;cerco la potenza del numero a (elevato alla exp) che più si avvicina a m

	cmp m,r3 ;se il numero da trovare è ancora minore dell'argomento del logaritmo (m)
	ble exit ;se il numero è stato trovato, ovvero se r3>=m
	add exp,exp,#1 ;incremento l'esponente, che in realtà è un counter
	mul r3,r4,a ;moltiplico a per se stesso(r4) (è stato moltiplicato n-volte quante l'esponente) e salvo in r3
	mov a,r3 ;salvo il valore di r4 in modo da fare la moltiplicazione
	b CercaPotenzaVicina ;se non ha ancora raggiunto la dimensione desiderata allora richiamo il ciclo, ovvero se (a^exp)<=m
exit:
dec exp,#1 ;decremento l'esponente
mov a,exp ;ora r0 (a) contiene il numero più vicino al loga (m)
swi 0x11
 .end