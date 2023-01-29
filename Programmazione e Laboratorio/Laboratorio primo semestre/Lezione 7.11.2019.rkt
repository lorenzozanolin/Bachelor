;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lezione 7.11.2019|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define BtrSum
  (lambda (s1 s2)
    (let ((num1 (NormalizedBtr s1)) (num2 (NormalizedBtr s2))) ;num1 e num2 sono le due stringhe prive di eventuali '.' davanti
     (NormalizedBtr (BtrCarrySum num1 num2 #\.)) ;rinormalizzo il risultato
     )
  )
)

(define BtrCarrySum
  (lambda (num1 num2 rip) ;rip e' il riporto
      (let ((last1 (Lsd num1)) (last2 (Lsd num2))) ;last1 e last2 sono le cifre meno significative di ciascun numero 
       (let ((pre1 (Head num1)) (pre2 (Head num2))) ;pre1 e pre2 sono il resto delle stringhe con le cifre piu' significative

         (cond
           
           ((and (> 0 (string-length num1)) (= 0 (string-length num2))) ;se la lunghezza di una delle due e' >0, ovvero se solo la seconda e' terminata
              (BtrDigitSum last1 rip #\.) ;sommo la prima cifra con il riporto della somma precedente
           )

           ((and (> 0 (string-length num2)) (= 0 (string-length num1))) ;se la lunghezza di una delle due e' >0, ovvero se solo la prima e' terminata
              (BtrDigitSum last2 rip #\.) ;sommo la seconda cifra con il riporto della somma precedente
           )

           ((and (= 0 (string-length num2)) (= 0 (string-length num1))) (string rip)) ;se la lunghezza di tutte e due e' =0, allora ritorna solo il riporto

           (else ;se la lunghezza di entrambe e' >0, ovvero se entrambe le stringhe non sono terminate
               (string-append (BtrCarrySum pre1 pre2 (BtrCarry last1 last2 rip)) (string (BtrDigitSum last1 last2 rip))) ;concateno il risultato della somma delle ultime cifre con la somma delle successive usando la ricorsione
           )
        )
      )
    )
  )
)

 
(define BtrDigitSum                    ; funzione che restituisce la somma di due cifre ternarie prese singolarmente
  (lambda (u v c)                        ; u, v, c: caratteri +/./-  ; u, v rappresentano le cifre "incolonnate"; c rappresenta il riporto "in entrata";
    (cond ((char=? u #\-)                ; se la prima cifra incolonnata è -

           (cond ((char=? v #\-)         ; se la seconda cifra incolonnata è -                      

                  (cond ((char=? c #\-)  ; - - -      ;se il riporto è -1
                         #\.)
                        ((char=? c #\.)  ; - - .      ;se il riporto è 0
                         #\+)
                        ((char=? c #\+)  ; - - +      ;se il riporto è 1
                         #\-)))

                 ((char=? v #\.)         ;se la seconda cifra incolonnata è -
                  
                  (cond ((char=? c #\-)  ; - . -      ;se il riporto è -1
                         #\+)
                        ((char=? c #\.)  ; - . .
                         #\-)
                        ((char=? c #\+)  ; - . +
                         #\.)))

                 ((char=? v #\+)         ;se la seconda cifra incolonnata è +
                  c)))                   ; - + c

          ((char=? u #\.)                ;se la prima cifra incolonnata è .

           (cond ((char=? v #\-)         ;se la seconda cifra incolonnata è -

                  (cond ((char=? c #\-)       ;se il riporto è -1
                         #\+)            ; . - -
                        ((char=? c #\.)       ;se il riporto è 0
                         #\-)            ; . - .
                        ((char=? c #\+)       ;se il riporto è 1
                         #\.)))          ; . - +

                 ((char=? v #\.)         ;se la seconda cifra incolonnata è .         
                  c)                     ; . . c

                 ((char=? v #\+)         ;se la seconda cifra incolonnata è +

                  (cond ((char=? c #\-)       ;se il riporto è -1  
                         #\.)            ; . + -
                        ((char=? c #\.)       ;se il riporto è 0 
                         #\+)            ; . + .
                        ((char=? c #\+)       ;se il riporto è 1  
                         #\-)))))        ; . + +

          ((char=? u #\+)                ; se la prima cifra incolonnata è +

           (cond ((char=? v #\-)         ;se la seconda cifra incolonnata è -
                  c)                     ; + - c ritorna il riporto

                 ((char=? v #\.)         ;se la seconda cifra incolonnata è .

                  (cond ((char=? c #\-)       ;se il riporto è -1  
                         #\.)            ; + . -
                        ((char=? c #\.)       ;se il riporto è 0  
                         #\+)            ; + . .
                        ((char=? c #\+)       ;se il riporto è 1  
                         #\-)))           ; + . +

                 ((char=? v #\+)         ;se la seconda cifra incolonnata è +

                  (cond ((char=? c #\-)       ;se il riporto è -1   
                         #\+)            ; + + -
                        ((char=? c #\.)       ;se il riporto è 0  
                         #\-)            ; + + .
                        ((char=? c #\+)       ;se il riporto è 1  
                         #\.)))))        ; + + +
          )))

(define BtrCarry ;funzione per calcolare il riporto in tutti i casi visti
  (lambda (u v c)
     (cond ((char=? u #\-)               ; se la prima cifra incolonnata è -

           (cond ((char=? v #\-)         ; se la seconda cifra incolonnata è -                      

                  (cond ((char=? c #\-)  ; - - -      ;se il riporto è -1
                         #\-)
                        ((char=? c #\.)  ; - - .      ;se il riporto è 0
                         #\-)
                        ((char=? c #\+)  ; - - +      ;se il riporto è 1
                         #\.)))

                 ((char=? v #\.)         ;se la seconda cifra incolonnata è .
                  
                  (cond ((char=? c #\-)  ; - . -      ;se il riporto è -1
                         #\-)
                        ((char=? c #\.)  ; - . .
                         #\.)
                        ((char=? c #\+)  ; - . +
                         #\.)))

                 ((char=? v #\+)         ;se la seconda cifra incolonnata è +
                  #\.)))                   ; - + c

          ((char=? u #\.)                ;se la prima cifra incolonnata è .

           (cond ((char=? v #\-)         ;se la seconda cifra incolonnata è -

                  (cond ((char=? c #\-)       ;se il riporto è -1
                         #\-)            ; . - -
                        ((char=? c #\.)       ;se il riporto è 0
                         #\.)            ; . - .
                        ((char=? c #\+)       ;se il riporto è 1
                         #\.)))          ; . - +

                 ((char=? v #\.)         ;se la seconda cifra incolonnata è .         
                  #\.)                     ; . . c

                 ((char=? v #\+)         ;se la seconda cifra incolonnata è +

                  (cond ((char=? c #\-)       ;se il riporto è -1  
                         #\.)            ; . + -
                        ((char=? c #\.)       ;se il riporto è 0 
                         #\.)            ; . + .
                        ((char=? c #\+)       ;se il riporto è 1  
                         #\+)))))        ; . + +

          ((char=? u #\+)                ; se la prima cifra incolonnata è +

           (cond ((char=? v #\-)         ;se la seconda cifra incolonnata è -
                  #\.)                     ; + - c ritorna il riporto

                 ((char=? v #\.)         ;se la seconda cifra incolonnata è .

                  (cond ((char=? c #\-)       ;se il riporto è -1  
                         #\.)            ; + . -
                        ((char=? c #\.)       ;se il riporto è 0  
                         #\.)            ; + . .
                        ((char=? c #\+)       ;se il riporto è 1  
                         #\+)))           ; + . +

                 ((char=? v #\+)         ;se la seconda cifra incolonnata è +

                  (cond ((char=? c #\-)       ;se il riporto è -1   
                         #\.)            ; + + -
                        ((char=? c #\.)       ;se il riporto è 0  
                         #\+)            ; + + .
                        ((char=? c #\+)       ;se il riporto è 1  
                         #\+)))))        ; + + +

  )
))

(define NormalizedBtr ;rimuove i  #\. prima di un numero
  (lambda (s)
    (let((lun (string-length s))) ;lunghezza della stringa
      (if (and (> lun 1) (char=? #\. (string-ref s 0))) ;se trova un . alla prima posizione della stringa e la stringa ha almeno due caratteri (in modo che se ho ".." rimanga ".")
             (NormalizedBtr (substring s 1)) ;richiamo ricorsivamente la funzione togliendo la prima cifra
             s
      )
    )
  )
)

(define Lsd ;ritorna il bit meno significativo di una stringa
  (lambda (s)
    (let((lun (string-length s))) ;lunghezza della stringa
     (if (= lun 0) ;se la lunghezza della stringa e' 0, ovvero e' vuota
       #\.
      (string-ref s (- lun 1)) ;else gli passo il carattere all'ultima posizione
    )
   )
  )
)

(define Head  ;ritorna la parte piu' significativa di una stringa
  (lambda (s)
    (let((lun (string-length s))) ;lunghezza della stringa
      (if (> lun 0)
      (substring s 0 (- lun 1)) ;ritorna la stringa senza l'ultimo carattere
      "")
    )
  )
)
    
 

  
