.data
 vettore: .word 7,3

.text
 
 v .req r0
 n1 .req r1
 n2 .req r2
 quoziente .req r4
 
 ldr v,=vettore
 ldr n1,[v],#4
 ldr n2,[v],#4
 mov quoziente,#0

Divisione:
 cmp n1,n2 ;confronta n1 con n2 e se n1<n2 allora vuol dire che n1 non puo' piu' essere diviso per n2
 blt Fine ;se non sono piu' divisibili allora jumpa alla fine
 sub n1,n1,n2 ;sottraggo dal primo il secondo
 add quoziente,quoziente,#1 ;incremento il quoziente
 b Divisione
 
Fine:
 mov r0,n1 ;salvo il resto in r0
 mov r1,quoziente
 swi 0x11
.end