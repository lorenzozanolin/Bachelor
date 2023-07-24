--2 Restituire il numero di ordini effettuati presso un fornitore che al momento fornisce almeno un articolo. 

create or replace function numeroOrdini( pIvaFornitore dom_PartitaIva )
returns record
language plpgsql as $$
    begin
        if pIvaFornitore NOT IN (SELECT Fornitore FROM Articolo) 
            then raise Exception '% non fornisce alcun articolo in questo momento', pIvaFornitore;
        end if;

        return query
        SELECT PartitaIva, NumeroOrdini FROM Fornitore WHERE PartitaIva = pIvaFornitore;
    end;
$$;


SELECT numeroOrdini(pIva);



--3 Visualizzare la quantità ordinata di un determinato articolo in un preciso periodo. 

create or replace function quantitaOrdinata( codiceArticolo dom_CodArticolo, reparto dom_NomeReparto, dataInizio date, dataFine date )
returns record
langauge plpgsql as $$
    declare n integer;
    begin
        if dataInizio after dataFine
            then raise Exception 'Periodo non valido';
        end if;


        return query
        SELECT codiceArticolo, reparto, dataInizio, dataFine, count(*) as quantitaOrdinata
        FROM Composto JOIN Ordine ON C.Ordine = O.CodiceOrdine as CO
        WHERE codiceArticolo = CO.CodiceArticoloReparto AND reparto = CO.Reparto AND CO.DataOrdine AFTER dataInizio AND CO.DataOrdine BEFORE dataFine;
    end;
$$;

SELECT quantitaOrdinata( articolo, reparto, dataInizio, dataFine );

