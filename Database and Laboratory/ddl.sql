create domain dom_CodID as char(16); --è il codice fiscale dei dipendenti
create domain dom_NumeroTelefono varchar(13); --include il prefisso +xx
create domain dom_CodOrdine as char(13);
create domain dom_NomeReparto varchar(30);
create domain dom_CodArticolo varchar(15);
create domain dom_CodArticoloFornitore varchar(60); --è grande per gestire la eterogeneità dei vari codice assegnati dai vari fornitori
create domain dom_PartitaIva varchar(20);
create domain dom_TipoDipendente varchar(10)
    DEFAULT 'Dipendente'
    CONSTRAINT valoreTipoDipendete 
    CHECK(value = 'Manager' or value = 'Dipendente');

create table Dipendente(
    CodID dom_CodID,
    Nome varchar(50) not null,
    Cognome varchar(50) not null,
    Indirizzo varchar(100) not null,
    Stipendio integer not null,
    TipoDipendente dom_TipoDipendente not null,
    CodIDCapoFamiglia dom_CodID,
    Reparto dom_NomeReparto,

    PRIMARY KEY(CodID),
    CHECK (Stipendio > 0),
    CONSTRAINT FkCapoFamiglia FOREIGN KEY(CodIDCapoFamiglia) 
        references Dipendente(CodID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

create table NumeroDiTelefono(
    Numero dom_NumeroTelefono,
    Proprietario dom_CodID not null,

    PRIMARY KEY(Numero),
    CONSTRAINT FkProprietario FOREIGN KEY(Proprietario) 
        references Dipendente(CodID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


create table Reparto(
    Nome dom_NomeReparto,
    NumeroDipendenti integer not null,
    ManageR dom_CodID not null unique,

    PRIMARY KEY(Nome),
    CONSTRAINT FkManager FOREIGN KEY(Manager) 
        references Dipendente(CodID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

alter table Dipendente ADD CONSTRAINT FkReparto 
    FOREIGN KEY(Reparto) 
    references Reparto(Nome)
    ON UPDATE CASCADE
    ON DELETE NO ACTION;

create table Fornitore(
    PartitaIva dom_PartitaIva,
    Nome varchar(30) not null,
    Indirizzo varchar(50) not null,
    NumeroOrdini integer not null,

    PRIMARY KEY (PartitaIva),
    CHECK (NumeroOrdini >= 0)
);

create table Articolo(
    CodiceArticoloReparto dom_CodArticolo,
    Reparto dom_NomeReparto not null,
    PrezzoAlDettaglio decimal(5,2) not null,
    CodiceArticoloFornitore dom_CodArticoloFornitore not null,
    Fornitore dom_PartitaIva,
    DataInizio date not null,
    PrezzoIngrosso decimal(5,2) not null ,

    PRIMARY KEY(CodiceArticoloReparto,Reparto),
    CHECK (PrezzoAlDettaglio > 0),
    CHECK (PrezzoIngrosso > 0),
    CONSTRAINT FkArticolo FOREIGN KEY(Reparto)
        references Reparto(Nome)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT FkFornitore FOREIGN KEY(Fornitore)
        references Fornitore(PartitaIva)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

create table FornituraPassata(
    CodiceArticolo dom_CodArticolo,
    Reparto dom_NomeReparto,
    Fornitore dom_PartitaIva,
    DataFine date,
    DataInizio date not null,
    PrezzoFornitura decimal(5,2) not null,

    PRIMARY KEY(CodiceArticolo,Reparto,Fornitore,DataFine),
    CHECK (PrezzoFornitura > 0),
    CHECK (DataFine > DataInizio),
    CONSTRAINT FkFornituraPassataArticolo FOREIGN KEY(CodiceArticolo, Reparto)
        references Articolo(CodiceArticoloReparto, Reparto)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT FkFornituraPassataFornitore FOREIGN KEY(Fornitore)
        references Fornitore(PartitaIva)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

create table Ordine(
    CodiceOrdine dom_CodOrdine,
    DataOrdine date not null,

    PRIMARY KEY(CodiceOrdine)
);

create table Composto(
    Ordine dom_CodOrdine,
    CodiceArticolo dom_CodArticolo,
    Reparto dom_NomeReparto,
    Quantità integer not null,

    PRIMARY KEY(Ordine,CodiceArticolo,Reparto),
    CHECK (Quantità > 0),
    CONSTRAINT FkCompostoOrdine FOREIGN KEY(Ordine)
        references Ordine(CodiceOrdine)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT FkCompostoArticolo FOREIGN KEY(CodiceArticolo, Reparto)
        references Articolo(CodiceArticoloReparto, Reparto)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);