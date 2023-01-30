package appello_23_06_Zanolin_Lorenzo_mat148199;

import appello_23_06_Zanolin_Lorenzo_mat148199.Caratteristiche.Caratteristica;
import appello_23_06_Zanolin_Lorenzo_mat148199.Sconto.Sconto;
import appello_23_06_Zanolin_Lorenzo_mat148199.Servizio.Servizio;

import java.util.*;
import java.util.stream.Collectors;


/**
 * Rappresenta l'azienda che possiede gli hotel
 * ha una lista di hotel, un listino prezzi, una lista di prenotazioni e una lista di clienti
 * Comunica con i clienti
 * Conosce le prenotazioni in corso (non per forza ancora iniziate ma chee sono state pianificate), e quelli passati
 */
public class AziendaHoltin {
    private List<Albergo> catenaAlberghi;
    private List<Prenotazione> listaVecchiePrenotazioni;
    private List<Prenotazione> listaPrenotazioniInCorso;
    private List<Cliente> listaClienti;

    public AziendaHoltin(List<Albergo> catenaAlberghi, List<Prenotazione> listaVecchiePrenotazioni, List<Prenotazione> listaPrenotazioniInCorso, List<Cliente> listaClienti) {
        this.catenaAlberghi = catenaAlberghi;
        this.listaVecchiePrenotazioni = listaVecchiePrenotazioni;
        this.listaPrenotazioniInCorso = listaPrenotazioniInCorso;
        this.listaClienti = listaClienti;
    }

    /**
     * Procedura che cerca all'interno di un hotel se sono presenti tutti i servizi da ricercare
     * @param listaServiziAlbergo lista dei servizi da cercare all'interno di un hotel
     * @param albergo in cui cercare il servizio
     * @return l'esito della ricerca
     */
    private boolean soddisfaServizi(List<Servizio> listaServiziAlbergo, Albergo albergo){
        Objects.requireNonNull(albergo);
        for (Iterator<Servizio> servizo = listaServiziAlbergo.iterator(); servizo.hasNext(); ) {
            Servizio servizioDaCercare = servizo.next();
            if(!albergo.soddisfaServizio(servizioDaCercare)){
                return false;
            }
        }
        return true;
    }

    /**
     * Cerca una lista di alberghi che forniscono certi servizi e hanno disponibili delle camere (in un range di date) con una certa caratteristica
     * @param listaServiziAlbergo lista che contiene i servizi da cercare
     * @param caratteristicaCamera caratteristica da cercare
     * @param dataInizio data di inizio prenotazione di cui cercare la camera
     * @param dataFine data di fine prenotazione di cui cercare la camera
     * @return la lista di alberghi trovati
     * @throws AlbergoNonDisponibileException se non trova nessun albergo
     */
    public List<Albergo> cercaDisponibilita(List<Servizio> listaServiziAlbergo,Caratteristica caratteristicaCamera, Date dataInizio, Date dataFine) throws AlbergoNonDisponibileException {
        //devo filtrare le caratteristiche del cliente nella lista delle mie barche disponibili
        Objects.requireNonNull(listaServiziAlbergo);
        Objects.requireNonNull(dataFine);
        Objects.requireNonNull(dataInizio);
        List<Albergo> listaTrovata = catenaAlberghi
                .stream()
                .filter(albergo ->  albergo.haCameraDisponibile(caratteristicaCamera,dataInizio,dataFine,listaPrenotazioniInCorso))
                .filter(albergo -> soddisfaServizi(listaServiziAlbergo,albergo))
                .collect(Collectors.toList());
        if(listaTrovata.isEmpty()){
            throw new AlbergoNonDisponibileException();
        }
        else {
            return listaTrovata;
        }
    }

    /**
     *  in base ai parametri passati genera il costo di una possibile prenotazione
     * @param numeroPersone numero di persone di cui cercare
     * @param listaServiziAlbergo lista servizi da cercare
     * @param caratteristicaCamera caratteristiche della camera da cercare
     * @param dataInizio data di inizio prenotazione
     * @param dataFine data di fine prenotazione
     * @param listaSconti lista degli sconti da applicare
     * @throws AlbergoNonDisponibileException
     */
    public void ottieniPrezzoPrevisto(int numeroPersone,List<Servizio> listaServiziAlbergo,Caratteristica caratteristicaCamera, Date dataInizio, Date dataFine,List<Sconto> listaSconti) throws AlbergoNonDisponibileException{
        List<Albergo> listaAlberghiTrovati = cercaDisponibilita(listaServiziAlbergo,caratteristicaCamera,dataInizio,dataFine);

        Prenotazione prenotazioneIdeale;
        for (Iterator<Albergo> albergo = listaAlberghiTrovati.iterator(); albergo.hasNext(); ) {
            try {
                Stanza stanzaTrovata = albergo.next().trovaStanza(caratteristicaCamera);
                prenotazioneIdeale = new Prenotazione(albergo,stanzaTrovata,dataInizio,dataFine,numeroPersone,StatoPrenotazione.CALCOLO_COSTO,listaSconti);
                System.out.println(prenotazioneIdeale.calcolaCostoPrenotazione(numeroPersone,stanzaTrovata,albergo.next(),listaSconti));
            } catch ( NullPointerException e ) {
                System.out.println(" ");
            }
        }

    }




    /**
     * Ricerca una camera libera con le caratteristiche richieste
     * @param stanza da cercare
     * @param caratteristica caratteristica associata alla stanza da cercare
     * @return true se trova la camera, altrimenti ritorna false
     */
    private boolean haCameraDisponibile(Albergo stanza, Caratteristica caratteristica){
        Objects.requireNonNull(stanza);
        //cerco nella lista delle camere fornite dall'hotel

        if(listaServiziOfferti.contains(servizio)){
            return true;
        }else{
            return false;
        }
    }



}
