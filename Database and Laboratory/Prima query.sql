SELECT R.Nome, R.NumeroDipendenti, AVG(D.Stipendio)
FROM Reparto AS R, Dipendente AS D	
WHERE R.Nome=D.Reparto OR R.Manager=D.CodId
GROUP BY R.Nome

-- facendo cosi però l'inserimento di un dipendente va fatto con delle transazioni in modo da evitare che ci siano dei dipendenti senza reparto