package appello_23_06_Zanolin_Lorenzo_mat148199;

import appello_23_06_Zanolin_Lorenzo_mat148199.Caratteristiche.Caratteristica;
import appello_23_06_Zanolin_Lorenzo_mat148199.Servizio.Ristorante;
import appello_23_06_Zanolin_Lorenzo_mat148199.Servizio.Servizio;

import java.util.Date;
import java.util.List;
import java.util.Objects;


public class Albergo {
    private List<Stanza> listaCamere;
    private NumeroStelle numeroStelle;
    private List<Ristorante> listaRistoranti;
    private List<Servizio> listaServiziOfferti;

    public Albergo(List<Stanza> listaCamere, NumeroStelle numeroStelle, List<Ristorante> listaRistoranti, List<Servizio> listaServiziOfferti) {
        this.listaCamere = listaCamere;
        this.numeroStelle = numeroStelle;
        this.listaRistoranti = listaRistoranti;
        this.listaServiziOfferti = listaServiziOfferti;
    }

    /**
     * Ricerca un servizio all'interno della lista dei servizi offerti
     * @param servizio da cercare
     * @return true se trova il servizio, altrimenti ritorna false
     */
    public boolean soddisfaServizio(Servizio servizio){
        Objects.requireNonNull(servizio);
        //cerco nella lista di servizi forniti dall'hotel
        if(listaServiziOfferti.contains(servizio)){
            return true;
        }else{
            return false;
        }
    }

    /**
     * Cerca nella lista delle camere se queste sono disponibili nelle date richieste e se hanno la caratteristica richiesta
     * @param caratteristicaDellaCameraDaCercare caratteristica della camera da cercare
     * @param dataInizio data di inizio della prenotazione
     * @param dataFine data di fine della prenotazione
     * @param listaPrenotazioniInCorso  lista delle prenotazioni in cui cercare le date di prenotazione per le camere con le caratteristiche desiderate
     * @return true se esite un camera, false altrimenti
     *
     */
    public boolean haCameraDisponibile(Caratteristica caratteristicaDellaCameraDaCercare, Date dataInizio, Date dataFine,List<Prenotazione> listaPrenotazioniInCorso){

    }


    public Stanza trovaStanza(Caratteristica caratteristicaCamera){

    }

}
