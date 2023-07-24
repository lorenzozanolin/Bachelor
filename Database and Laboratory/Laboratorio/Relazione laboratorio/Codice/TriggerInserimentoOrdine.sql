create or replace function ottieni_fornitore(codArticolo varchar(15), rep varchar(30))
returns  varchar(20)
language plpgsql as $$
declare
    result varchar(20);
begin
    result := null;
    select a.Fornitore into result
    from Articolo a
    where a.Reparto = rep and a.CodiceArticoloReparto = codArticolo;

    return result;
end;
$$;

create or replace function valida_entry_ordine()
returns trigger
language plpgsql as $$
declare
    old_f varchar(20);
    new_f varchar(20);
    old_entry record;
begin
    perform *
    from Composto c
    where c.Ordine = new.Ordine;

    if found
    then
        select * into old_entry
        from Composto c
        where c.Ordine = new.Ordine 
        limit 1;

        old_f := ottieni_fornitore(old_entry.CodiceArticolo, old_entry.Reparto);
        new_f := ottieni_fornitore(new.CodiceArticolo, new.Reparto);
    
        if old_f = new_f
        then
            --il fornitore e' lo stesso degli altri aricoli
            return new;
        else 
            --il fornitore non e' lo stesso
            raise exception 'Tutti gli articoli per questo ordine devono essere forniti da %.',old_f;
            return null;
        end if;
    else    
        --e' il primo articolo inserito
        return new;
    end if;
end;
$$;

create trigger valida_articolo_ordine before insert or update
on Composto
for each row
execute procedure valida_entry_ordine();
