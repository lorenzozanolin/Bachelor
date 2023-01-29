;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Tassellazione a L|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
;; L-Tessellation Problem
;; Claudio Mirolo, 6/11/2014

;; Per eseguire questo codice e' necessario
;; utilizzare il TeachPack "drawings.ss"


;; L-Tessellation Problem
;;
;; Questo problema si basa su tasselli a forma di L, con
;; i lati lunghi di 2 unita' e quelli corti di 1 unita'.
;; La forma di ogni tassello, nella configurazione di
;; riferimento, e' associata al nome
;;
;;   L-tile
;;
;; Hai a disposizione tanti tasselli quanti ne servono e li
;; puoi spostare e combinare fra loro con le procedure:
;;
;;   (shift-down <figura> <passi>)
;;
;;   (shift-right <figura> <passi>)
;;
;;   (quarter-turn-right <figura>)
;;
;;   (quarter-turn-left <figura>)
;;
;;   (half-turn <figura>)
;;
;;   (glue-tiles <figura> <figura>)
;;
;; L'argomento <figura> e' nel caso piu' semplice un tassello e in
;; generale una figura ottenuta spostando, ruotando e combinando
;; diversi tasselli. L'argomento <passi> rappresenta il numero di
;; unita' di spostamento in basso o a destra.
;;
;; Le operazioni consentono, rispettivamente, di spostae in basso,
;; spostare a destra, ruotare di 90 gradi in senso orario, ruotare
;; di 90 gradi in senso antiorario, capovolgere e combinare
;; insieme due figure: si capisce facilmente provando, per esempio:
;;
;;   (glue-tiles L-tile (shift-right (half-turn L-tile) 1))
;;
;; Immagina che i tasselli rappresntino piastrelle con le quali
;; si deve coprire (o piastrellare) il pavimento di una stanza,
;; ma senza tagliare (o, peggio, sovrapporre) piastrelle.
;; Il problema e' risolubile se il pavimento della stanza e'
;; un quadrato di lato n unita', dove n e' una potenza di due,
;; da cui e' stata tolta una colonna quadrata di lato 1 unita'
;; in corrispondenza al vertice in basso a destra.
;; L'obiettivo e' di definire un'opportuna procedura in Scheme
;; "per piastrellare il pavimento" (naturalmente, se la forma e
;; le dimensioni sono consistenti con le specifiche date).


;; Traslazione unitaria da utilizzare per la tassellazione
;; (lato piu' corto del tassello a forma di L)

(set-tessellation-shift-step!)

(define L-tassellation ; val: Figura a forma di L (con il lato corto lungo n)
  (lambda (n)          ; n potenza di 2
    (if (> n 1 )
        (glue-tiles (L-tassellation (/ n 2))                                                                     ; Ogni figura con n > 1 è formata da quattro sezioni di grandezza n/2,
                    (glue-tiles (shift-down (shift-right (L-tassellation (/ n 2)) (/ n 2)) (/ n 2))              ; di cui una spostata in basso di n/2 paasi e le altre due ruotate rispettivamente 
                                (glue-tiles (shift-down (quarter-turn-left (L-tassellation (/ n 2))) n)          ; in senso orario e antiorario e poi spostate a destra o in basso di n passi.
                                            (shift-right (quarter-turn-right (L-tassellation (/ n 2))) n))       ; Ogni sezione viene costruita alla stessa maniera in modo ricorsivo.
                   )
        )
        L-tile         ; caso base: restituisce la piastrella singola
     )
  )
  )
