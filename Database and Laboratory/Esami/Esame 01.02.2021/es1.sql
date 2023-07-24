(a)

SELECT GARA
FROM PARTECIPAZIONE P1
WHERE NOT EXIST(
                SELECT *
                FROM PARTECIPAZIONE P2,P3
                WHERE P1.GARA = P2.GARA AND
                P2.SCIATORE <> P3.SCIATORE AND
                P2.POSIZIONE = P3.POSIZIONE AND
                P2.GARA = P3.GARA
              )

(b)

--- SCIATORI SOLO GARE Schladming
SELECT P1.SCIATORE
FROM PARTECIPAZIONE P1
WHERE NOT EXIST(
                SELECT *
                FROM PARTECIPAZIONE,GARA
                WHERE CODG = GARA AND
                LUOGO <> "Schladming" AND
                SCIATORE = P1.SCIATORE 

              )
AND EXIST (
            SELECT *
            FROM PARTECIPAZIONE,GARA G1
            WHERE CODG = GARA AND
            LUOGO = "Schladming" AND 
            SCIATORE NOT IN (
                              SELECT SCIATORE
                              FROM PARTECIPAZIONE
                              WHERE GARA = G1.GARA
                           )
)

