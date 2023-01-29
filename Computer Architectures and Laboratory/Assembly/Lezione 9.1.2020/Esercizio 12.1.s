.data
 vettore: .word 1,2,-5,-8,9,-11
 lunghezza: .word 6
 
.text
 ldr r0,=vettore
 ldr r1,=lunghezza
 ldr r1,[r1] ;mi salvo la lunghezza
 mov r2,#0 ;r2 mi serve per salvare temporaneamente il primo numero
 mov r3,r0 ;r3 è l'indice del vettore che uso per spostarmi
 ;r4 viene utilizzato eventualmente come indirizzo secondario per ricercare un positivo
 ;r5 mi serve per salvare temporaneamente il secondo numero
 
CercaPositivo:
 cmp r1,#0 ;confronto la lunghezza con 0
 beq Fine ;se sono uguali vuol dire che ha finito
 ldr r2,[r0] ;si salva il primo elemento in r2
 cmp r2,#0 ;controlla se il numero è positivo
 blgt CercaNegativo ;se l'ha trovato (positivo) si sposta alla ricerca del primo negativo e una volta trovato ritorna all'istruzione successiva con branch link
 add r3,r3,#4 ;incremento l'indice primario
 sub r1,r1,#1
 b CercaPositivo
 
CercaNegativo:
 movpl r4,r3 ;uso r4 come indice e cerco dalla posizione successiva (questa operazione va svolta solo la prima volta che entra nel ciclo)
 add r4,r4,#4 ;incremento l'indice secondario
 ldr r5,[r4] ;guardo l'elemento alla posizione successiva 
 cmp r5,#0 ;se il numero è negativo
 strmi r5,[r3] ;se ha trovato il negativo allora sovrascrive il nuovo numero 
 strmi r2,[r4] ;inserisce il positivo nella posizione del negativo
 movmi pc,lr ;se l'ha trovato allora torno al punto di link
 cmp r2,#255 ;serve per evitare di copiare r3 in r4 piu di una volta
 b CercaNegativo
	
Fine:
 swi 0x11
 .end