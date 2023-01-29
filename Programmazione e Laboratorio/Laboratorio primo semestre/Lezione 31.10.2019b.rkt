#lang racket

(define Rep->Number
 (lambda (d s) ;d è il dizionario ordinato contenente l'alfabeto, s è la stringa su cui si esegue il calcolo
  (let ((posCifra (PosizionePrimaCifra s)) (segno (Sign (string-ref s 0)))) ;posizione della prima cifra e segno è il primo carattere della stringa (se omesso viene considerato come positivo)  
   (let ((indxpunto (TrovaPunto s)) (base (CalcolaBase d))) ; indxpunto è la posizione del punto e base e' la base a cui fa riferimento la stringa inserita

       (if (not indxpunto);se non c'è una parte decimale 
         (let ((inte (ParteIntera (substring s posCifra) base d)))
           (* segno inte)
         )
         ;se effettivamente c'è una parte decimale
        (let ((dec (ParteDecimale (string-append "0" (substring s (+ 1 indxpunto ))) base d)) (inte (ParteIntera (substring s posCifra indxpunto) base d))) ;parte decimale è la parte dopo la virgola a cui va anteposto uno 0 per evitare problemi di calcolo
           (* segno (+ inte dec))
        )
       )
   )
  )
 )
)

(define CalcolaBase ;calcola la base di un alfabeto in base al numero di caratteri
  (lambda (d)
     (string-length d)
  ) 
)

(define CalcolaPeso ;calcola il peso delle cifre
  (lambda (l alfabet pos)       ;parametri: (l) lettera a cui assegnerà il valore pari al suo indice nel dizionario e (alfabet) la stringa di riferimento
     (cond ((char=? (string-ref alfabet pos) l) ;se il carattere alla posizione pos è il carattere da cercare 
            pos) ;allora ritorna la posizione del carattere
           (else (CalcolaPeso l alfabet (+ pos 1))) ;altrimenti richiama la funzione ricorsivamente spostando la posizione di 1
     )
  )
)

(define ParteIntera ;converte una base x in decimale
  (lambda (num base alfabeto) ;stringa non vuota di 0/1
    (let ( (k (- (string-length num) 1))) ;k è la posizione del penultimo carattere
    (let ( (pre (substring num 0  k)) (lsb (string-ref num k)))  ;pre è tutta la stringa senza considerare il lsb (least significant bit, string-ref ritorna il char della stringa alla posizione)
      (if (= k 0) ;se la lunghezza è 1, ovvero 1-1=0
          (CalcolaPeso lsb alfabeto 0) ;restituisce il valore del lsb utilizzando il metodo CalcolaPeso
          ;else
          (+ (* base (ParteIntera pre base alfabeto)) (CalcolaPeso lsb alfabeto 0))
          )
      )
    )
    )
)

(define ParteDecimale ;converte la parte decimale da base x in base 10
  (lambda (dec base alfabeto)
    (let ( (k (- (string-length dec) 1))) ;k è la posizione del penultimo carattere
    (let ( (pre (substring dec 1)) (lsb (string-ref dec 0)))  ;pre è tutta la stringa senza considerare il lsb (least significant bit, string-ref ritorna il char della stringa alla posizione)
      (if (= k 0) ;se la lunghezza è 1, ovvero 1-1=0
          (CalcolaPeso lsb alfabeto 0) ;restituisce il valore del bit
          ;else
          (+ (CalcolaPeso lsb alfabeto 0) (* (/ 1 base) (ParteDecimale pre base alfabeto))) 
          )
      ) 
    )
   )
)
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
     (cond ((char=? (string-ref num 0) #\+) 1) ;se alla posizione 0 c'è un 1 allora vuol dire che il segno è omesso
           ((char=? (string-ref num 0) #\-) 1) ;se alla posizione 0 c'è un 1 allora vuol dire che il segno è omesso
           (else 0) ;altrimenti vuol dire che c'è un segno
     )
  )
)

(define TrovaPunto
  (lambda (s)
  (for/first ([x s]              ; for each character in the string c
              [i (in-naturals)]  ; counts 0, 1, 2, ...
              #:when (char=? #\. x))
    i)))

(define Sign ;stabilisce il segno del numero in base al primo carattere s della stringa
  (lambda (s)
    ( if(char=?  #\- s)
        -1
        1
    )
  ))