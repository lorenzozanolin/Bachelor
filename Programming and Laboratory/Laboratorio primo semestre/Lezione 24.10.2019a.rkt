;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lezione 24.10.2019|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define Frase ;ritorna la frase fatta ->string
  (lambda (sogg pred cogg)
    (let ((aSogg (Article sogg)) (aCogg (Article cogg)) (v (Decline pred (Number sogg))) ) ;aSogg contiene l'articolo del soggetto, aCogg contiente l'articolo del compl.ogg, v contiene il verbo coniugato
          (string-append aSogg (string-append sogg " ") v aCogg cogg) ;restituisco la stringa con i vari parametri calcolati
  )))
    ; (funzione parametri)

(define Article ;determina l'articolo in base al genere e al numero ->string
  (lambda (s)
    (let ((g (Gender s)) (n (Number s))) ;g contiente il genere, n il numero (sing/plur)
    ( if (string=? "m" g) ;se termina con m
        ( if(string=? "s" n) ;ed è singolare
        "il " ;allora
        "i " ;altrimenti
        ) 
        ;caso else, ovvero se termina con f
        ( if(string=? "s" n) ;ed è singolare
         "la "  ;allora
         "le " ;altrimenti
        )
     )
      ) ;fine if
      );fine let
    );fine lambda
   ;fine funzione
    

(define Gender ;stabilisce se la parola è maschile o femminile ->char
  (lambda (p)
     (if (string=? (substring p (- (string-length p) 1)) "o" ) ;compara l'ultimo carattere con le varie possibilità,ovvero divide tra n-1 e n di una stringa
         "m"  
         ( if (string=? "a" (substring p (- (string-length p) 1) ))
           "f"
          ( if (string=? "i" (substring p (- (string-length p) 1) ))
           "m"
           ( if (string=? "e" (substring p (- (string-length p) 1) ))
            "f"
            ""
           )
          )
         )
       )
     )
    )
  

(define Number ;stabilisce se la parola è plurale o singolare ->char
  (lambda (p)
     (if (string=? "o" (substring p (- (string-length p) 1))) ;se la parola termina con "o"
         "s" ;allora è singolare
         (if (string=? "a" (substring p (- (string-length p) 1) )) ;altrimenti se termina con "a"
         "s" ;allora è sempre singolare
         "p" ;altrimenti è plurale
         )
         )
      )
    
 )
  


(define Decline ;declina il verbo al tempo verbale corretto ->string
  (lambda (p n) ;p è il predicato infinito e n contiene il numero (sing/plur)
    (if (string=? n "s") ;se il sostantivo è singolare 
       ;caso true   
       (if (string=? "are" (substring p (- (string-length p) 3))) ;e il verbo termina con are
            (string-append (substring p 0 (- (string-length p) 3)) "a ") ;allora va fatto finire il verbo con a
            (string-append (substring p 0 (- (string-length p) 3)) "e ") ;allora va fatto finire il verbo con e, in quanto sia ere che ire vanno coniugati con e
        )
       ;else , se il sostantivo è plurale
       (if (string=? "are" (substring p (- (string-length p) 3))) ;e il verbo termina con are
             (string-append (substring p 0 (- (string-length p) 3)) "ano ") ;allora va fatto finire il verbo con a
             (string-append (substring p 0 (- (string-length p) 3)) "ono ") ;allora va fatto finire il verbo con e, in quanto sia ere che ire vanno coniugati con e
       )
      )
  )
)

       

         


