import names, random, random_address, datetime, faker
from numpy import datetime_as_string
fake = faker.Faker()

# Devo creare 10 reparti
nomiReparti = ["Dairy products", "Meat", "Seafood", "Vegetables", "Wines and Beers", "Drinks", "Frozen Foods", "Health and Beauty", "Home Basics", "Cleaning Products"]
reparto = [
    {
        "Nome" : nomiReparti[i],
        "NumeroDipendenti" : 0,
        "Manager" : str(i)
    }
    for i in range(10)]


# Devo creare 200 dipendenti, di cui 10 manager e 190 non responsabili
dipendente = [
    {
        "CodID" : str(i),
        "Nome" : names.get_first_name(),
        "Cognome" : names.get_last_name(),
        "Indirizzo" : random_address.real_random_address()["address1"],
        "Stipendio" : random.randint(60000,120000) if i<10 else random.randint(30000,59999),
        "TipoDipendente" : "Manager" if i<10 else "Dipendente",
        "CodIDCapoFamiglia" : "null",
        "Reparto" : str(i%10) if i<20 else str(random.randint(0,9))
    } 
    for i in range(200)]
# Scelgo 10 persone a caso che sono a carico di qualcun altro
for i in range(10) :
    j = random.randint(1,199)
    dipendente[j]["CodIDCapoFamiglia"] = str(random.randint(0,j-1)) # Pongo che se A è a carico di A, allora A.CodID > B.CodID per evitare dipendenze cicliche

# Conto i dipendenti per reparto
for i in range(10) :
    reparto[i]["NumeroDipendenti"] = sum(map(lambda dip : dip["Reparto"] == i, dipendente))

# Genero i numeri di telefono: almeno uno per ciascun dipendente
numeroDiTelefono = [
    {
        "Numero" : "".join("+", str(random.randint(0,99)), str(i * 33333333 + random.randint(0, 33333332)).zfill(10)),
        "Proprietario" : str(i) if i < 200 else str(random.randint(0,199)) # Assegno almeno un numero di telefono a ciascun dipendente, e i restanti 100 li assegno a caso
    }
    for i in range(300)]

# Devo creare 220 fornitori
fornitore = [
    {
        "PartitaIva" : str(i * 454545454 + random.randint(0, 454545453)).zfill(11),
        "Nome" : names.get_full_name(),
        "Indirizzo" : random_address.real_random_address()["address1"],
        "NumeroOrdini" : 0 # NB!!!!!!!
    }
    for i in range(220)]

# Devo creare 2500 articoli
codiciArticoliReparti = [0 for i in range(10)]
codiciArticoliFornitori = [0 for i in range(220)]
articolo = []
for i in range(2500) :
    rep = i % 10 if i < 100 else random.randint(0,9)
    forn = i if i < 220 else random.randint(0,219)
    articolo.append({
        "CodiceArticoloReparto" : str(codiciArticoliReparti[rep]),
        "Reparto" : str(rep),
        "PrezzoAlDettaglio" : str(round(random.uniform(0,999.99),2)),
        "CodiceArticoloFornitore" : str(codiciArticoliFornitori[forn]),
        "Fornitore" : fornitore[forn]["PartitaIva"]
        "DataInizio" : "-".join([str(random.randint(2014,2022)), str(random.randint(1,12)), str(random.randint(1,28))])
        "DataFine" : str(fake.between) # DA QUAAAAAAAAAAAAAAAA
    })
    codiciArticoliReparti[rep] += 1
    codiciArticoliFornitori[forn] += 1

