(a)
-- (almeno due - almeno tre)
SELECT C1.OPERA
FROM CARTELLONE C1,C2
WHERE C1.OPERA = C2.OPERA AND
     C1.TEATRO < C2.TEATRO AND 
     C2.ANNO = C1.ANNO AND
     C1.ANNO = '2020' 

EXCEPT

SELECT C1.OPERA
FROM CARTELLONE C1,C2,C3
WHERE C1.OPERA = C2.OPERA AND
     C2.OPERA = C3.OPERA AND
     C1.TEATRO < C2.TEATRO AND
     C1.TEATRO < C3.TEATRO AND
     C1.ANNO = '2020' AND
     C2.ANNO = '2020' AND
     C3.ANNO = '2020'


(b)
-- seleziona i teatri per cui - non esiste un opera (fatta al teatro di torino nel 2018) che non esiste nelle opere di quel teatro nel 2018

CREATE VIEW OPERE_TORINO_2018
SELECT OPERA 
FROM CARTELLONE 
WHERE TEATRO = 'TEATRO STABILE DI TORINO' AND
     ANNO = '2018'
     

SELECT TEATRO
FROM CARTELLONE C1
WHERE NOT EXIST(SELECT *    -- seleziona tutte le opere del 2018 che sono state fatte dal teatro di Torino ma non dal teatro selezionato
               FROM OPERE_TORINO_2018  
               WHERE NOT EXIST(
                            SELECT *
                            FROM CARTELLONE C2
                            WHERE C2.OPERA = OPERE_TORINO_2018.OPERA AND
                                 C2.ANNO = '2018' AND
                                 C1.TEATRO = C2.TEATRO AND
                                 C2.TEATRO <> OPERE_TORINO_2018.TEATRO

                            
                    )
            )