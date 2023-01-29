;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lezione 19.12.2019|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
;PARTE 1

(define CodiceCesare ;val: procedura[car->car] ritorna una procedura
  (lambda (rot) ;rot è la rotazione (offset) da 0 a 19
    (lambda (c) ;definizione di una procedura, c entra in gioco se viene chiamata la procedura
     (let ((alfabeto "ABCDEFGHILMNOPQRSTVX")) ;alfabeto latino su cui eseguire le operazioni
      (let ((posSucc (- (+ rot (CercaPosAlfabeto c alfabeto)) 1))) ;posizione del nuovo carattere cifrato e tolgo 1 perchè parto da un'indice 1 e non 0
        (if (<= posSucc 19) ;se la posSucc è < 19, ovvero non ha ancora percorso tutto l'alfabeto
            (string-ref alfabeto posSucc) ;posizione di c
            ;else
            (string-ref alfabeto (- posSucc 19)) ;altrimenti riparto dall'inzio con l'alfabeto
        )
      )
    )         
  )
 )
)

(define CercaPosAlfabeto ;funzione per cercare la posizione di un carattere nell'alfabeto
  (lambda (c alfabeto)
   (if (char=? c (string-ref alfabeto 0))
       1
       (+ 1 (CercaPosAlfabeto c (substring alfabeto 1)))
   )
  )
)

(define Crittazione ;Procedura da richiamare che prende come parametri stringa e procedura
  (lambda (s algo) ;s è la stringa da criptare e algo è l'algoritmo di crittazione da utilizzare
    (if (string=? s "") ;se la stringa fosse vuota
        ""
        (string-append (string (algo (string-ref s 0))) (Crittazione (substring s 1) algo)) ;converto carattere per carattere
    )
  )
)

;PARTE 2

(define H
  (lambda (algo1 algo2) ;algo1 e algo2 sono le due funzioni che applica la procedura
    (lambda (x1 x2) ;x1 e x2 sono i due parametri
      (if (= x2 0) ;controlla se il secondo parametro è 0
          (algo1 x1) ;h( m, 0 ) = f(m)
          (algo2 x1 ((H algo1 algo2) x1 (- x2 1))) ;funzione composta h( m, n ) = g( m, h(m,n–1) ) e h(m,n)=H perciò sostituisco
       )
     )
  )
)
       
(define S2 ;funzione che ti somma fino al successivo
  (lambda (n1 n2)
     (+ n2 1) ;s2(u,v) = v+1
    
  )
)

(define I ;funzione identità, ovvero riapplica la stessa funzione sul valore
  (lambda (x)
    x
  )
)

(define Add ;funzione somma che somma x1 e x2 utilizzando la composizione di I(S2(x1,x2))
   (H I S2)    
)
    
;(Add 4 5)