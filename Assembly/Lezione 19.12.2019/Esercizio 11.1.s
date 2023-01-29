.data
    text: .asciiz "testo.txt" ;il file di testo contiene come primo elemento il numero di elementi, dal secondo in poi contiene gli elementi
    vett: .word ;vett e' un vettore vuoto che poi si popolera'

.text
ldr r0, =text ;in r0 mi salvo l'indirizzo di riferimento del file di testo

Proc1:
    swi 0x66 ;salva il r0 l'handler (ovvero una sorta di biglietto da visita) per accedere al testo contenuto
    mov r2, r0 ;mi salvo l'handler in r2 perche' poi mi serve utilizzare r0 per altri scopi
    swi 0x6c ;legge il primo elemento nel file di testo (ovvero il numero di elementi contenuti nel file di testo (tranne il primo, ovvero esso stesso))
    mov r3, r0 ;r3 contiene il numero di elementi
    ldr r1, =vett ;r1 contiene l'indirizzo di partenza del vettore
    loop:           ;lettura elementi escluso il primo
        mov r0, r2  ;sposto l'handler in r0 perche' per usare swi devo averlo in r0
        swi 0x6c    ;leggo l'elemento successivo
        str r0, [r1], #4 ;salva l'elemento nel vettore alla posizione r1 e poi shifta di 4
        add r4, r4, #1 ;incrementa il counter
        cmp r4, r3 ;finche non ha caricato tutti gli elementi continua nel loop
        ble loop
    mov r0, r1  ;da correggere sta minchiatas
    mov r1, r3

swi 0x11
.end



