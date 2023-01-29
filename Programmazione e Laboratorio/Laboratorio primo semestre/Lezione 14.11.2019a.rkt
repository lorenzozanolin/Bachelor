;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Lezione 14.11.2019a|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define Manhattan3d ;funzione che ritorna il numero di modi possibili per arrivare da un punto A ad un punto B
  (lambda (i j k) ;i,j,k sono le dimensioni del poliedro
    
     (cond ((or (and (= i 0) (= j 0)) (and (= k 0) (= j 0)) (and (= i 0) (= k 0))) 1) ;caso base, ovvero quando arriva a destinazione, nel caso appunto in cui almeno due dimensioni siano a 0 e sono sullo stesso asse (è tutto in riga perciò esiste un unico modo per arrivare)
           
           ((and (> i 0) (> j 0) (> k 0)) (+ (Manhattan3d (- 1 i) j k) (Manhattan3d i (- 1 j) k) (Manhattan3d i j (- 1 k)))) ;caso in cui tutti e 3 sono >0 e allora deve decrementare tutto

           ((= i 0) (+ (Manhattan3d 0 (- j 1) k) (Manhattan3d 0 j (- k 1)))) ;se abbiamo terminato l'ascissa mi muovo solo in ordinata e coordinata z
           ((= k 0) (+ (Manhattan3d (- i 1) j 0) (Manhattan3d i (- j 1) 0))) ;se abbiamo terminato l'asse z mi muovo solo in ordinata e ascissa
           ((= j 0) (+ (Manhattan3d (- i 1) 0 k) (Manhattan3d i 0 (- k 1)))) ;se abbiamo terminato l'ordinata mi muovo solo in ascissa e coordinata z
     ) 
    ) 
  
)
