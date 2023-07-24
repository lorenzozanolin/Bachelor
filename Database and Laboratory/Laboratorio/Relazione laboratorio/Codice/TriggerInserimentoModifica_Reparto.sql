-- ORDINE OPERAZIONI: 
-- prima inserisco un dipendente, poi inserisco un reparto e vi setto il manager e poi vado ad aggiornare il tipoDipendente del dipendente selezionato come manager.
-- quando vado ad aggiornare un Dipendente in manager devo vedere se e' manager del reparto a cui afferisce (in Reparto)

I trigger vanno fatti su: 
    1- inserimento di un reparto, ovvero controllare che il manager che vado ad assegnare al reparto abbia come attributi [Reparto = null o mioReparto, tipoDipendente = dipendente]. 
        => se ha successo faccio raise notice "Il dipendente x e' stato elevato a manager" e modifico del dipendente [Reparto = null, tipoDipendente = manager]
        --devo controllare anche quando inserisco un reparto, che il manager (dipendente) afferisca a null, se diverso da null allora se e' lo stesso reparto(quindi e' un dipendente) devo settare reparto = null e tipodipendente = manager => ESCALATION. Invece se e' reparto != quello su cui sto inserendo/modificando allora l'operazione deve fallire
   
1.
create or replace function valida_manager_reparto() -- controllo che il nuovo reparto che vado a creare/modificare abbia un manager che: o afferisce a quel reparto o a nessuno, nel caso in cui afferisse ad un altro reparto c'e' un errore
returns trigger
language plpgsql as $$
declare
    reparto dom_NomeReparto; --il reparto del nuovo manager
    tipoDipendente dom_TipoDipendente; --il tipo di dipendente del nuovo manager
begin
    select d.Reparto into reparto
    from Dipendente d
    where d.CodID = new.ManageR;

    select d.tipoDipendente into tipoDipendente
    from Dipendente d
    where d.CodID = new.ManageR;

    if reparto is null and tipoDipendente = 'Dipendente'
    then
        --allora e' un dipendente appena creato che va ancora assegnato al reparto
        raise notice 'Il dipendente % e stato assegnato a manager per il reparto %',new.ManageR,new.Nome; 
        update Dipendente set TipoDipendente = 'Manager' where CodId = new.ManageR; -- aggiorno il tipoDipendete a manager
        return new;
    else
    if reparto = new.Nome and tipoDipendente = 'Dipendente'
    then
        --allora e' un dipendente del reparto e va fatta una promozione => passa da Dipendente a Manager e devo "de-rankare" quello vecchio
        raise notice 'Il dipendente % e stato elevato a manager per il reparto %',new.ManageR,new.Nome;
		update Dipendente set TipoDipendente = 'Dipendente', reparto = old.nome where CodId = old.ManageR; -- aggiorno il tipoDipendete al vecchio manager e gli riassegno il reparto
		update Dipendente set TipoDipendente = 'Manager', reparto = null where CodId = new.ManageR; -- aggiorno il tipoDipendete a manager
        return new;
    else
        --il dipendente afferisce ad un altro reparto
        raise exception 'Il dipendente % non afferisce al reparto %, aggiornamento fallito.',new.ManageR,new.Nome;
        return null;
    end if;
	end if;
end;
$$;

create trigger controlla_Manager before insert or update
on Reparto
for each row
execute procedure valida_manager_reparto();

-- test del trigger 1

-- popolamento minimo della base di dati:

insert into Dipendente values  ('1234567890123456', 'Mario', 'Rossi', 'Via delle guide', 9000, 'Dipendente', null);
--PRIMO IF, ovvero assegno ad un reparto un dipendente non occupato e diventa manager
insert into Reparto values ('Scarpe', 0, '1234567890123456');

update Dipendente set TipoDipendente = 'Manager' where CodId = '1234567890123456';
insert into Dipendente values  ('1234567890123457', 'Lorenzo', 'Zanolin', 'Via delle guide', 9000, 'Dipendente', 'Scarpe'); --ora LZ è un dipendente del reparto e MR è manager

--SECONDO IF, ovvero faccio una promozione a ZL e quindi MR diventa dipendente => (LZ: dipendente -> manager; MR: manager -> dipendente)
update Reparto set Manager = '1234567890123457' where nome = 'Scarpe';

-- ELSE, ovvero assegno ad un reparto un manager afferente ad un altro reparto
insert into Reparto values ('Vestiti', 0, '1234567890123457'); --da giustamente errore







