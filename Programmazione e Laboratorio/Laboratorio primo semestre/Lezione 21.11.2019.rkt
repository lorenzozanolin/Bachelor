;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lezione 21.11.2019|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define Belong?
  (lambda (e l) ;l e' la lista ordinata ed e e' l'elemento da cercare

    (cond ((null? l) false) ;se non ha trovato il numero ritorna falso
          ((= e (car l)) true) ;se ha trovato il numero ritorna vero
          (else ;altrimenti
           (Belong? e (cdr l)) ;ricorsione togliendo un elemento dalla lista
          )
    )
  )
)

(define Position ;ritorna la posizione di un numero
  (lambda (e l)
    (El-ref l e 0)
  )
)

(define El-ref ;ritorna la posizione dell'elemento di una lista
  (lambda (l e pos) ;l e' la lista, e l'elemento da cercare e pos e' un'indice che viene utilizzato per salvare la posizione
    (cond ((null? l) false) ;elemento non trovato percio' ritorna false
          ((= e (car l)) pos) ;se corrisponde con l'elemento della lista
          (else ;altrimenti
           (El-ref (cdr l) e (+ 1 pos))
          )
    )
  )
)

(define Position2 ;un altro modo per trovare la posizione, controlla all'inzio se appartiene
  (lambda (e l)
    (if (Belong? e l) ;se appartiene
        (if (= e (car l)) ;allora fa il confronto con l'elemento da cercare
            0
            (+ 1 (Position2 e (cdr l))) 
        )

        false
    )
  )
)

(define SortedIns ;inserisce in modo ordinato in una lista ordinata
  (lambda (e l)
    (cond ((null? l) (cons e null)) ;se la lista e' vuota
          ((> e (car l)) (cons (car l) (SortedIns e (cdr l)))) ;se e' maggiore percio' deve ancora scorrere la lista, percio' si salva la parte precedente della lista e richiama la parte successiva
          ((= e (car l)) l) ;se l'elemento e' gia inserito allora va ritornata la lista
          (else
           (cons e l) ;se l'elemento e' minore della lista che c'e' gia allora lo mette in prima posizone
          )
    ) 
  )
)

(define SortedList ;riordina la lista
  (lambda (l)
    (StupidSort l '())
  )
)

(define StupidSort ;riordina una lista utilizzando algoritmo stupidsort
  (lambda (l aux) ;aux e' una lista ausiliare che mi serve per salvare la lista precedentemente ordinata mano a mano che vado avanti ricorsivamente
    (cond ((null? l) aux) ;se e' arrivato alla fine della lista, ritorna tutta la lista ausiliare che ti sei costruito prima
          (else
           (StupidSort (cdr l) (SortedIns (car l) aux)) ;accoda l'elemento nella parte gia ordinata di lista e richiama ricorsivamente la funzione con la parte restante di lista
          )
        
    )
  )
)
