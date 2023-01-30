/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca.CaratteristicaAstratta;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca.FiltroAstratto;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca.FiltroBarca;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Eccezioni.NessunaBarcaDisponibileException;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Eccezioni.PrenotazioneFallitaException;

import java.util.Date;
import java.util.List;

/**
 * Rappresenta l'azienda di noleggio delle barche
 * ha una flotta di barche, un listino prezzi e una lista di clienti con cui l'azienda ha avuto rapporti
 * Comunica con i clienti
 * Conosce i noleggi in corso,quelli futuri e quelli passati
 *
 */
public class AziendaNoleggioBarche {
    private List<Barca> flottaBarche;
    private ListinoPrezzi listinoPrezzi;
    private List<Cliente> clienti;

    private List<Noleggio> noleggiPassati;
    private List<Noleggio> noleggiInCorso;
    private List<Noleggio> noleggiFuturi;

    public AziendaNoleggioBarche(List<Barca> flottaBarche, ListinoPrezzi listinoPrezzi) {
        this.flottaBarche = flottaBarche;
        this.listinoPrezzi = listinoPrezzi;
    }

    AziendaNoleggioBarche


    /**
     * Cerca tra tutte le barche dell'azienda, barche disponibili per la prenotazione,
     * che soddisfano certe caratteristiche e a cui sono applicabili degli extra
     * @param caratteristicheBarca rappresenta tutte le carattesristiche che la Barca deve soddisfare
     *                             NB. si possono combinare piu caratteristiche con la classe HaDueCaratteristiche
     * @param extra sono gli extra del servizio di noleggio (es. pulizia a fine crocera)
     * @return tutte le barche disponibili che soddisfanno la ricerca
     * @throws NessunaBarcaDisponibileException se nessuna barca ha tutte le caratteristiche e non può
     * avere gli extra specificati
     */
    Stream<Barca> cercaBarche(CaratteristicaAstratta<Barca> caratteristicheBarca, List<Extra> extra)
        throws NessunaBarcaDisponibileException {
        FiltroAstratto<Barca> filtroBarca = new FiltroBarca();
        Stream<Barca> risultato =
                filfiltroBarcatro.filtra(flottaBarche, caratteristicheBarca)
                .filter(barca -> barca.metteADisposizione(extra));
        if(risultato == null){
            throw new NessunaBarcaDisponibileException();
        }
    }

    /**
     * Crea un noleggio per una certa data, barca e luogo
     * il noleggio viene aggiunto alla lista dei noleggi futuri
     * @param barca il codice della barca che si vuole prenotare
     * @param luogoConsegna il luogo in cui il cliente prenderà in consegna la barca
     * @param luogoRiconsegna il luogo in cui il cliente restituirà la barca all' azienda
     * @param inizioPrenotazione la data di inizio noleggio
     * @param finePrenotazione la data di fine noleggio
     * @param extra la lista dei servizi extra
     * @throws PrenotazioneFallitaException se la barca risulta non disponibile per la prenotazione
     * @return il noleggio prenotato con annesso il prezzo scontato
     */
    Noleggio prenota(int barca,
                 Posizione luogoConsegna,
                 Posizione luogoRiconsegna,
                 Date inizioPrenotazione,
                 Date finePrenotazione,
                 int codiceCliente,
                 List<Extra> extra)
    throws PrenotazioneFallitaException {
        Barca b = ottieniBarca(barca);

        if(b.èDisponibile(inizioPrenotazione, finePrenotazione)){
            Noleggio n = new Noleggio(
                    barca,
                    extra,
                    codiceCliente,
                    inizioPrenotazione,
                    finePrenotazione,
                    luogoConsegna,
                    luogoRiconsegna
            );
            n.marcaNoleggio(StatoNoleggio.PRENOTATO);
            n.impostaPrezzoBase(listinoPrezzi.calcolaPrezzo(n));
            return n;
        }
        throw new PrenotazioneFallitaException();
    }

    /**
     * Restituisce la barca associata al cocicebarca
     */
    private Barca ottieniBarca(int codiceBarca){}

    /**
     * Assegna al cliente la barca e restituisce il prezzo del noleggio
     * Aggiunge il noleggio alla lista dei noleggiInCorso
     * @param barca il codice della barca da dare al cliente
     * @return il prezzo che il cliente deve pagare per il noleggio, espresso in euro
     */
    int consegnaAlCliente(int barca, Noleggio noleggio){
        Barca b = ottieniBarca(barca);
        noleggio.marcaNoleggio(StatoNoleggio.IN_CORSO);
        return noleggio.ottieniPrezzoBase;
    }

    /**
     * Rappresenta la ripresa della barca da un cliente, nonchè il periodo di fine noleggio
     * Contrassegna una barca precedentemente noleggiata come nuovamente disponibile
     * @param barca il codice della barca che il cliente restituisce all'azienda
     * @return il prezzo delle penalità che il cliente deve eventualmente pagare
     */
    int riprendiDaCliente(int barca,Noleggio noleggio){
        int prezzoPenalita = listinoPrezzi.calcolaPenalità(
                noleggio.ottieniPenalita
        );
        noleggio.marcaNoleggio(StatoNoleggio.CONCLUSO);
        Barca b = ottieniBarca(noleggio.ottieniCodiceBarca());
        b.impostaDisponibile(true);
        return  prezzoPenalita;
    }

    void aggiungiBarcaAllaFlotta(Barca b){}

    void registraCliente(CLiente c){}
}
