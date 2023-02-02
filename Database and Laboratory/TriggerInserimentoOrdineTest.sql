-- popolamento minimo della base di dati:
insert into Dipendente values  ('1234567890123456', 'Mario', 'Rossi', 'Via delle guide', 9000, 'Dipendente', null);
insert into Reparto values ('Scarpe', 0, '1234567890123456');
update Dipendente set TipoDipendente = 'Manager' where CodId = '1234567890123456';
insert into Fornitore values 
    ('f1', 'Azienda 1', 'via dei pioppi', 0),
    ('f2', 'Azienda 2', 'via dei pioppi', 0);
insert into Articolo values
    ('a1', 'Scarpe', 5, 'abc', 'f1', '05-03-2022', 4),
    ('a2', 'Scarpe', 4, 'bca', 'f1', '05-03-2022', 3),
    ('a3', 'Scarpe', 3, 'cba', 'f2', '05-03-2022', 2),
    ('a4', 'Scarpe', 8, 'abs', null, '05-03-2022', 4);
insert into Ordine values ('1111111111111', '05-03-2022');

-- test del trigger:
-- 1: ha successo
insert into Composto values('1111111111111', 'a1', 'Scarpe', 3);
-- 2: ha successo
insert into Composto values('1111111111111', 'a2', 'Scarpe', 3);
-- 3: ERRORE: Tutti gli articoli per questo ordine devono essere forniti da f1.
insert into Composto values('1111111111111', 'a3', 'Scarpe', 3);
-- 4: ERRORE: Tutti gli articoli per questo ordine devono essere forniti da f1.
insert into Composto values('1111111111111', 'a4', 'Scarpe', 3);