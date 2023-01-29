#lang racket
;Notazione in base 2

(define BinRep->Number
 (lambda (s) ;s è un numero binario
    (let ((posCifra (PosizionePrimaCifra s)) (segno (Sign (string-ref s 0)))) ;posizione della prima cifra e segno è il primo carattere della stringa (se omesso viene considerato come positivo)
     (let ((indxpunto (TrovaPunto s))) ;e indxpunto è la posizione del punto

       (if (not indxpunto);se non c'è una parte decimale 
         (let ((inte (ParteIntera (substring s posCifra))))
           (* segno inte)
         )
         ;se effettivamente c'è una parte decimale
        (let ((dec (ParteDecimale (string-append "0" (substring s (+ 1 indxpunto ))))) (inte (ParteIntera (substring s posCifra indxpunto)))) ;parte decimale è la parte dopo la virgola a cui va anteposto uno 0 per evitare problemi di calcolo
           (* segno (+ inte dec))
        )
       )
    ) 
   )
 )
)

(define PosizionePrimaCifra ;stabilisce dov'è la posizione della prima cifra, per evitare di immettere sempre il segno
  (lambda (num)
     (cond ((char=? (string-ref num 0) #\1) 0) ;se alla posizione 0 c'è un 1 allora vuol dire che il segno è omesso
           ((char=? (string-ref num 0) #\0) 0) ;se alla posizione 0 c'è un 1 allora vuol dire che il segno è omesso
           (else 1) ;altrimenti vuol dire che c'è un segno
     )
  )
)

(define TrovaPunto
  (lambda (s)
  (for/first ([x s]              ; for each character in the string c
              [i (in-naturals)]  ; counts 0, 1, 2, ...
              #:when (char=? #\. x))
    i)))

(define ParteIntera ;converte un binario in decimale
  (lambda (num) ;stringa non vuota di 0/1
    (let ( (k (- (string-length num) 1))) ;k è la posizione del penultimo carattere
    (let ( (pre (substring num 0  k)) (lsb (string-ref num k)))  ;pre è tutta la stringa senza considerare il lsb (least significant bit, string-ref ritorna il char della stringa alla posizione)
      (if (= k 0) ;se la lunghezza è 1, ovvero 1-1=0
          (BitVal lsb) ;restituisce il valore del bit
          ;else
          (+ (* 2 (ParteIntera pre)) (BitVal lsb))
          )
      )
    )
    )
)

(define ParteDecimale ;converte la parte decimale da binario in base 10
  (lambda (dec)
    (let ( (k (- (string-length dec) 1))) ;k è la posizione del penultimo carattere
    (let ( (pre (substring dec 1)) (lsb (string-ref dec 0)))  ;pre è tutta la stringa senza considerare il lsb (least significant bit, string-ref ritorna il char della stringa alla posizione)
      (if (= k 0) ;se la lunghezza è 1, ovvero 1-1=0
          (BitVal lsb) ;restituisce il valore del bit
          ;else
          (+ (BitVal lsb) (* 0.5 (ParteDecimale pre)))
          )
      )
    )
   )
)

(define Sign ;stabilisce il segno del numero in base al primo carattere s della stringa
  (lambda (s)
    ( if(char=?  #\- s)
        -1
        1
    )
  ))

(define BitVal ;dal char del lsb stabilisce il valore decimale 
  (lambda (bit)
    ( if (char=? bit #\0)
         0
         1
     )
    ))

 

;--------------------------------- FUNZIONE INVERSA NON UTILIZZATA
(define ParteDecimale2 ;ritorna il valore decimale, bisogna rimuovere il primo zero --> DA DECIMALE A BINARIO
  (lambda (dec) ;dec è il numero decimale convertito dalla stringa e arriva con 0,partedecimale
    (cond ((= dec 1) "1") ;caso di uscita, ovvero in cui il risultato della moltiplicazione per 2 è 1.00
          ((> dec 1) (string-append "1" (ParteDecimale2 (* 2 (- dec 1))) )) ;se il numero moltiplicato per 2 (nella chiamata precedente) è comunque <0 allora aggiungo "0" e richiamo la funzione
          ((< dec 1) (string-append "0" (ParteDecimale2 (* 2 dec)) )) ;se il numero moltiplicato per 1 eccede e quindi considero "1" e poi moltiplico solo la sua parte decimale (gli decremento 1)
    )
  )
)

;--------------------------------- FUNZIONE TROVA PUNTO NON UTILIZZATA IN QUANTO NON SI TROVA SOLUZIONE PER RITORNARE FALSO RICORSIVAMENTE
(define TrovaPunto1 ;trova (se c'è) la posizione del punto e ritorna l'indice
  (lambda (num)
    (let((lun (string-length num)))
     (cond ((char=? #\. (string-ref num 0)) ;se il carattere alla posizione start è il punto 
            start) ;allora ritorna la posizione del punto
           (else (TrovaPunto (substring num 1)) ;altrimenti richiama la funzione ricorsivamente spostando la posizione di 1
     )
  )
)))



    