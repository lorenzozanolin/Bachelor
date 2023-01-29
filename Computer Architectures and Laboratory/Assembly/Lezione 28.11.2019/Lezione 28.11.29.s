;.text
;mov r0,#0x1000
;add r0,r0,#0x10
;ldr r1, [r0]
;str r1, [r0, #8]
;mov r0,#0
;mov r0,#1
;mov r0,#2

;swi 0x11
;.end

.data
 num: .word 1,-1,-2,-3
 
.text
 ldr r5, =num ;r5 ora contiene l'indirizzo del primo elemento della lista
 ldr r0, [r5] 
 