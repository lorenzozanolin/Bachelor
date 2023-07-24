(a)
SELECT STUDENTE, COUNT(*) AS NUMESAMI
FROM ESAME E
GROUP BY STUDENTE
HAVING NUMESAMI <= ALL(SELECT COUNT(*)
                      FROM ESAME 
                      GROUP BY STUDENTE
                     )

(b) 
--il candidtato e' valido se per ogni esame (se e' stato fatto dalla matricola 100000, (->)allora lo studente che l'ha fatto e' valido)
SELECT DISTINCT STUDENTE
FROM ESAME E1
WHERE NOT EXISTS(SELECT *
               FROM ESAME E2
               WHERE STUDENTE = 100000
               AND NOT EXISTS(SELECT *
                            FROM ESAME
                            WHERE STUDENTE = E1.STUDENTE
                            AND INSEGNAMENTO = E2.INSEGNAMENTO
                           ) 
              )

