;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lezione 5.12.2019|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
;es 1
(define match 
 (lambda (u v)
   (if ( or (string=? u "") (string=? v ""))
       ""
       (let ( (uh (string-ref u 0)) (vh (string-ref v 0))
              (s (substring u 1)) (p (substring v 1))
            )


       (if (char=? uh vh)
           (string-append (string uh) (match s p))
           (string-append "*" (match s p))
           ))
 )))

;es 2
(define offset (char->integer #\0))

(define last-digit ;il numero massimo in cui puoi arrivare in quella base
 (lambda (base) (integer->char (+ (- base 1) offset)) ))

(define next-digit ;ottiene la cifra successiva in char
 (lambda (dgt) (integer->char (+ (char->integer dgt) 1))) )

(define increment
 (lambda (num base) ; 2 <= base <= 10
   (let ((digits (string-length num)))
     (if (= digits 0)
         "1"
         (let ((dgt (string-ref num (- digits 1)))) ;la cifra meno significativa
           (if (char=? dgt (last-digit base))
               (string-append (increment (substring num 0 (- digits 1)) base) ;prendo la parte prima dell'ultima cifra e gli aggiungo infondo lo 0
                "0")
               (string-append (substring num 0 (- digits 1)) (string(next-digit dgt))
               ))
 )))))

;es 3         
(define lcs ; valore: lista di terne
 (lambda (u v) ; u, v: stringhe

   (lcs-rec 1 u 1 v) ;per mirolo gli indici partono da 1
   ))

(define lcs-rec
 (lambda (i u j v)
 (cond ((or (string=? u "") (string=? v "")) null)

       ((char=? (string-ref u 0) (string-ref v 0)) ;se i caratteri alla stessa posizione coincidono (non posso usare i e j perche' gli indici vanno considerati solo come contatori, in quanto se substringo una stringa la posizione di indice 1 diventa di indice 0

        (cons (list i j (string-ref u 0)) ;si crea la lista con il carattere comune e le posizioni (che sono uguali)
              (list (lcs-rec (+ i 1) (substring u 1) (+ j 1) (substring v 1)) ) )) ;richiama ricorsivamente la funzione spostando avanti di 1 gli indici
        
        (else
         (better  ;better sceglie tra le due liste quella piu lunga
             (lcs-rec i u  (+ j 1) (substring v 1)) ;se la stringa più lunga è la prima, allora sposta solo l'indice della seconda
             (lcs-rec (+ i 1) (substring u 1) j v) ;altrimenti il contrario
         )
        )

  )
 )
)

(define better ;confronta le lunghezze di due liste e ritorna quella più lunga, in questo caso passo le due stringhe contenute in due liste diverse
 (lambda (x y)
 (if (< (length x) (length y))
     y
     x)
 ))

;es 4
(define CyclicStringRec
  (lambda (pattern length count)
      (if (= length 0)
          ""
          (if (= (- (string-length pattern) 1) count) ;se il count e' arrivato alla fine allora lo resetto, ovvero la lunghezza del count=lunghezza del pattern (il -1 e'solo perche il count fa da indice e percio parte da 0)
           (string-append (string (string-ref pattern count)) (CyclicStringRec pattern (- length 1) 0)) 
           (string-append (string (string-ref pattern count)) (CyclicStringRec pattern (- length 1) (+ count 1))) ;se il count non e' arrivato alla fine continuo ad incrementarlo spostandomi nell'alfabeto (pattern)
          )
      )
  )
)

(define CyclicString
  (lambda (pattern length)
    (CyclicStringRec pattern length 0)
  )
)

;es 5
(define Av
  (lambda (lista)
     (cond ((null? (cdr lista)) null)
           ((> (+ (car lista) (car (cdr lista))) 0) ;se la somma dei primi due elementi della lista e' >0
             (list 1 (Av (cdr lista))) ;creo una lista inserendoci 1 e poi delego per il resto della lista
           )
           ((< (+ (car lista) (car (cdr lista))) 0) ;se la somma dei primi due elementi della lista e' <0
             (list -1 (Av (cdr lista))) ;creo una lista inserendoci -1 e poi delego per il resto della lista
           )
           ((= (+ (car lista) (car (cdr lista))) 0) ;se la somma dei primi due elementi della lista e' =0
             (list 0 (Av (cdr lista))) ;creo una lista inserendoci 0 e poi delego per il resto della lista
           )
    )
   
 )
)

;es 6
(define Rval
  (lambda (sNum) ;sNum e'il numero sotto forma di stringa
    (let ((lsb (string-ref sNum 0)) (post (substring sNum 1)))
      (cond ((string=? post "") (/ 1 2)) ;se la stringa e' finita allora ritorna 1/2, caso di uscita in quanto l'ultimo numero sara' sempre 1 (non si scrive mai .110 ma solo .11)
            ((char=? #\1 lsb)  (+ (* (/ 1 2) 1) (* (/ 1 2) (Rval (substring sNum 1))))) ;sommo 1/2 e delego il resto moltiplicando per 2^-1 (in modo da avere 2^-1 * 2^-1...)
            ((char=? #\0 lsb)  (+ 0 (* (/ 1 2) (Rval (substring sNum 1))))) ;sommo 1 e delego il resto moltiplicando per 2^-1 (in modo da avere 2^-1 * 2^-1...)
            ((char=? lsb #\.) (Rval (substring sNum 1))) ;se trova il punto si sposta di 1
      )
    )
  )
)

;es 7
(define Shared
  (lambda (l1 l2)
    (cond ((or (null? l2) (null? l1)) null)
          ((= (car l2) (car l1)) (cons(car l1) (Shared (cdr l1) (cdr l2)))) ;se li trova nella stessa posizione allora inserisce l'elemento
          (else
           (better (Shared l1 (cdr l2)) (Shared (cdr l1) l2)) ;altrimenti scorre la lista finche non trova l'elemento corrente e aggiunge il tutto alla lista dell'elemento successivo
          )
    )
  )
)

;es 8
(define ParityCheckFailures
  (lambda (l pos)
    (if (null? l)
        null
        (cons (ParityCount (car l) pos 0) (ParityCheckFailures (cdr l) (+ 1 pos))) ;richiamo la funzione per ogni elemento (stringa) contenuto nella lista e ci passo il car (ovvero la stringa), l'indice (pos) e un count
    )   
  )
)

(define ParityCount
  (lambda (s pos count) ;s e' l'elemento stringa singola della lista di partenza, pos e' la posizione nella lista di partenza iniziale, count serve per calcolare se ha superato o no la parita
    (cond ((string=? s "") ;se la stringa passata e' vuota
           (if (even? count) ;allora controlla il count se e' pari o dispari (pari-> ok, dispari-> controllo non passato)
               null ;se ha passato il controllo non deve ritornare nulla
               pos ;altrimenti ritorna la posizione della stringa nella lista di partenza
           )
          )
          ((char=? (string-ref s 0) #\1) (ParityCount (substring s 1) pos (+ 1 count))) ;se trova "1" allora incrementa il counter di 1 e richiama la funzione spostando la lista (che in questo caso e' una singola stringa della lista iniziale
          ((char=? (string-ref s 0) #\0) (ParityCount (substring s 1) pos count)) ;altrimenti si sposta solo nella lista
    )
  )
)

;es 9
(define ClosestPair ;ritorna, data una lista ordinata, le coppie la cui differenza è la più bassa
  (lambda (l) ;l è la lista ordinata
    (if (null? l) ;se la lista è vuota
        null ;ritorno null
        (ClosestPairRec l 100 0 100) ;altrimenti eseguo la procedura d'appoggio
    )
  )
)

(define ClosestPairRec
  (lambda (l d e1 e2) ;l è la lista e d contiene la differenza minima
     (cond ((not(null? (cdr l))) ;se la lista non è finita continuo i cicli
               (let ((aux (- (car (cdr l)) (car l)))) ;aux contiene la differenza della coppia corrente (i e i+1)
                 (cond ((< aux d) (ClosestPairRec (cdr l) aux (car l) (car (cdr l)))) ;se la differenza corrente è minore di quella minore delle precedenti allora richiamo ricorsivamente la funzione cambiando la differenza minima con quella attuale e cambio i valori considerati nella differenza
                       (else (ClosestPairRec (cdr l) d e1 e2)) ;altrimenti mi sposto nella lista tenendo come differenza minima quella precedente
                       )
                 )
           )
           (else (list e1 e2)) ;altrimenti ritorno i due elementi più "vicini", vuol dire che ora la lista è vuota
     )
  )
)

;es 10
(define SortedCharList
  (lambda (s)
    (SmazzaStringa s '())
  ) 
)

(define ScorriInserisciOrdinato ;prende un singolo carattere e lo inserisce in modo ordinato
  (lambda (l c) ;l è la lista e c è il carattere da eventualmente inserire se non c'è
    (cond ((null? l) (cons c null)) ;se la lista è vuota ritorna essa con un elemento
          ((and (char=? c (car l)) (not (null? (cdr l)))) l) ;se il carattere è già inserito allora non fa niente (solo se non è alla prima iterazione)
          ((and (char=? c (car l)) (null? (cdr l))) null) ;se invece è alla prima iterazione e trova il carattere allora ritorna la lista
          ((char<? c (car l)) (cons c l)) ;ritorno una lista dove inserisco davanti il primo elemento  
          ((char>? c (car l)) (cons (car l) (ScorriInserisciOrdinato (cdr l) c))) ;mi sposto nella lista
          
    )
  )
)

(define SmazzaStringa ;prende ogni singolo carattere e richiama la funzione per inserirlo in modo ordinato
  (lambda (s l) ;s è la stringa di partenza e l è la lista ordinata
     (if(string=? s "") ;se la stringa è vuota
       l ;allora ritorna la lista ordinata
       (SmazzaStringa (substring s 1) (ScorriInserisciOrdinato l (string-ref s 0))) ;altrimenti richiama l'inserimento ordinato per un carattere (che ritorna la stringa ordinata) e richiama se stessa passando come lista quella ritornata dall'inserimento ordinato e come stringa il substring
     )
  )
)



          