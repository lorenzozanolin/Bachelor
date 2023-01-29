;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lezione 28.11.19|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define hanoi-moves ; val: lista di coppie
 (lambda (n) ; n > 0 intero, n e' il numero di dischi
   (hanoi-rec n 1 2 3)
 )
)

(define hanoi-rec ; val: lista di coppie
 (lambda (n s d t) ; n intero, s, d, t: posizioni
   (if (= n 1)
       (list (list s d))
      (let ((m1 (hanoi-rec (- n 1) s t d))
            (m2 (hanoi-rec (- n 1) t d s))
      )
      (append m1 (cons (list s d) m2))
      )
   )
 )
)

(define hanoi-disks
  (lambda (n m) ;n e' il numero di dischi, m e' il numero della mossa
    (let ((listaMosse (hanoi-moves n))) ;lista mosse contiene la lista con tutte le mosse in ordine da fare per svolgere la torre di hanoi di n dischi
      
      (DiskRec n 0 0 listaMosse m) ;nella situazione di partenza tutti i dischi sono nella prima asticella
      
    )
  )
)

(define DiskRec
  (lambda (ns nt nd listaMosse counter)
    
      (cond
        ((= counter 0) ;se il contatore si e' azzerato, vuole dire che il programma ha eseguito le n mosse
         (list (list 1 ns) (list 2 nt) (list 3 nd))) ;ritorno la lista con le configurazioni richieste
        
         ;situazioni di spostamento, ovvero decremento solo dall'asta di partenza il numero di dischi e incremento i dischi nell'asta di arrivo

        ;1->2
        ((and (= (car (car listaMosse)) 1) (= (car(cdr (car listaMosse))) 2)) ;se la mossa ha come disco iniziale il primo (1)
              (DiskRec (- ns 1) (+ nt 1) nd (cdr listaMosse) (- counter 1)))  ;decremento il numero di start e incremento il numero di arrivo

        ;1->3
        ((and (= (car (car listaMosse)) 1) (= (car(cdr (car listaMosse))) 3)) ;se la mossa ha come disco iniziale il primo (1)
              (DiskRec (- ns 1) nt (+ nd 1) (cdr listaMosse) (- counter 1)))  ;decremento il numero di start e incremento il numero di arrivo
        
        ;2->1
        ((and (= (car (car listaMosse)) 2) (= (car(cdr (car listaMosse))) 1)) ;se la mossa ha come disco iniziale il primo (1)
              (DiskRec (+ ns 1) (- nt 1) nd (cdr listaMosse) (- counter 1)))  ;decremento il numero di start e incremento il numero di arrivo

        ;2->3
        ((and (= (car (car listaMosse)) 2) (= (car(cdr (car listaMosse))) 3)) ;se la mossa ha come disco iniziale il primo (1)
              (DiskRec ns (- nt 1) (+ nd 1) (cdr listaMosse) (- counter 1)))  ;decremento il numero di start e incremento il numero di arrivo

        ;3->1
        ((and (= (car (car listaMosse)) 3) (= (car(cdr (car listaMosse))) 1)) ;se la mossa ha come disco iniziale il primo (1)
              (DiskRec (+ ns 1) nt (- nd 1) (cdr listaMosse) (- counter 1)))  ;decremento il numero di start e incremento il numero di arrivo

        ;3->2
        ((and (= (car (car listaMosse)) 3) (= (car(cdr (car listaMosse))) 2)) ;se la mossa ha come disco iniziale il primo (1)
              (DiskRec ns (+ nt 1) (- nd 1) (cdr listaMosse) (- counter 1)))  ;decremento il numero di start e incremento il numero di arrivo

      )       
  )
)
         