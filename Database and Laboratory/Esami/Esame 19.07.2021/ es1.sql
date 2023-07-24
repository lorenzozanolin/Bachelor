(a)

CREATE VIEW VITTORIE_SQUADRE            --PARTITA1 HA LE VITTORIE DI ANDATA, PARTITA2 HA LE VITTORE DI RITORNO
SELECT NAZIONE,COUNT(*) AS VITTORIE
FROM PARTITA1,PARTITA2, NAZIONALE
WHERE NAZIONE = PARTITA1.NAZIONALE1
AND NAZIONE = PARTITA2.NAZIONALE2
AND PARTITA1.GOALNAZIONALE1 > PARTITA1.GOALNAZIONALE2
AND PARTITA2.GOALNAZIONALE2 > PARTITA2.GOALNAZIONALE1
GROUP BY NAZIONE

SELECT NAZIONE
FROM VITTORIE_SQUADRE
WHERE VITTORIE_SQUADRE.VITTORIE >= ALL (SELECT VITTORIE_SQUADRE.VITTORIE
                                    FROM VITTORIE_SQUADRE)


(b)

SELECT NAZIONALE1   --NAZIONALI CHE HANNO GIOCATO IN ALMENO TUTTI GLI STADI DOVE HA GIOCATO IL BELGIO
FROM PARTITA P1
AND NOT EXIST(
                SELECT *
                FROM PARTITA P2
                WHERE (P2.NAZIONALE1 = "BELGIO"
                OR P2.NAZIONALE2 = "BELGIO")
                AND NOT EXIST (
                                SELECT *
                                FROM PARTITA P3
                                WHERE (P3.NAZIONALE1 = P1.NAZIONALE1 
                                      OR P3.NAZIONALE1 = P1.NAZIONALE2
                                      OR P3.NAZIONALE2 = P1.NAZIONALE1
                                      OR P3.NAZIONALE2 = P1.NAZIONALE2)
                                      AND P3.STADIO = P2.STADIO
                                      
                ) 
)

EXCEPT

SELECT NAZIONALE1   --NAZIONALI CHE HANNO GIOCATO IN STADI DOVE NON HA GIOCATO IL BELGIO
FROM PARTITA P1
AND NOT EXIST(
                SELECT *
                FROM PARTITA P2
                WHERE (P2.NAZIONALE1 = "BELGIO"
                AND P2.NAZIONALE2 = "BELGIO")
                AND NOT EXIST (
                                SELECT *
                                FROM PARTITA P3
                                WHERE (P3.NAZIONALE1 = P1.NAZIONALE1 
                                      OR P3.NAZIONALE1 = P1.NAZIONALE2
                                      OR P3.NAZIONALE2 = P1.NAZIONALE1
                                      OR P3.NAZIONALE2 = P1.NAZIONALE2)
                                      AND P3.STADIO <> P2.STADIO
                                      
                ) 
)

   