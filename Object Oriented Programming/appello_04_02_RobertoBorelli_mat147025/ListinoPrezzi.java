/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;
import java.util.HashMap;
import java.util.List;

/**
 * Conosce tutti i prezzi e gli sconti che l'azienda decide di applicare
 */
public class ListinoPrezzi {

    //associa ad ogni barca la propria tariffa gioarnaliera
    private HashMap<Barca, Integer> tariffaGiornaliera;
    private List<Sconto> sconti;

    //associa ad ogni penalità il suo prezzo
    private HashMap<Penalità, Integer> prezziPenalità;

    /**
     * Restituisce il prezzo base giornaliero di una barca
     */
    int ottieniPrezzoGiornaliero(Barca b){
        return tariffaGiornaliera.get(b);
    }

    /**
     * Aggiorna la tariffa base delle barche
     */
    void aggiornaTariffaPrezzi(HashMap<Barca, Integer>){}


    /**
     * Aggiorna la tariffa degli sconti
     */
    void aggiornaTariffaSconti(List<Sconto>){}

    /**
     * Aggiunge uno sconto alla lista degli socnti
     */
    void aggiungiSconto(Sconto s){
        sconti.add(s);
    }


    /**
     * Dato un noleggio calcola il prezzo totale includendo tutte le promozioni attive
     */
    int calcolaPrezzo(Noleggio noleggio){

    }

    /**
     *
     * Calcola il prezzo di una lista di penalità
     */
    int calcolaPenalità(List<Penalita> penalita){}
}
