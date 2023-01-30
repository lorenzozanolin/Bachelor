package appello_23_06_Zanolin_Lorenzo_mat148199;

import appello_23_06_Zanolin_Lorenzo_mat148199.Sconto.Sconto;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

public class Prenotazione {

    private Albergo albergoPrenotazione;
    private Stanza stanzaPrenotazione;
    private Date dataInizioPrenotazione;
    private Date dataFinePrenotazione;
    private int numeroDiPersone;
    private StatoPrenotazione statoPrenotazione;
    private List<Sconto> listaSconti;


    public Prenotazione(Albergo albergoPrenotazione, Stanza stanzaPrenotazione, Date dataInizioPrenotazione, Date dataFinePrenotazione, int numeroDiPersone, StatoPrenotazione statoPrenotazione, List<Sconto> listaSconti) throws IllegalArgumentException {
        Objects.requireNonNull(albergoPrenotazione);
        Objects.requireNonNull(stanzaPrenotazione);
        Objects.requireNonNull(dataInizioPrenotazione);
        Objects.requireNonNull(dataFinePrenotazione);
        Objects.requireNonNull(statoPrenotazione);
        Objects.requireNonNull(listaSconti);

        if (numeroDiPersone < 1) {
            throw new IllegalArgumentException("Il numero di persone specificato è non positivo");
        }

        this.albergoPrenotazione = albergoPrenotazione;
        this.stanzaPrenotazione = stanzaPrenotazione;
        this.dataInizioPrenotazione = dataInizioPrenotazione;
        this.dataFinePrenotazione = dataFinePrenotazione;
        this.numeroDiPersone = numeroDiPersone;
        this.statoPrenotazione = statoPrenotazione;
        this.listaSconti = listaSconti;
    }

    /**
     * Calcola la durata della prenotazione in base alle date
     * @return la durata in giorni del noleggio
     */
    private long getDurataPrenotazione(){
        long differenza = dataFinePrenotazione.getTime() - dataInizioPrenotazione.getTime();
        return TimeUnit.DAYS.convert(differenza, TimeUnit.DAYS);
    }

    /**
     * Funzione che simula una prenotazione per calcolare il costo
     * @param numeroDiPersone
     * @param stanzaDaPrenotare
     * @param albergoDaPrenotare
     * @return il costo della prenotazione
     */
    public long calcolaCostoPrenotazione(int numeroDiPersone, Stanza stanzaDaPrenotare, Albergo albergoDaPrenotare,List<Sconto> listaSconti){
        long costoCamera = stanzaDaPrenotare.getPrezzoBase();

        for (Iterator<Sconto> iter = listaSconti.iterator(); iter.hasNext(); ) {
            Sconto scontoSingolo = iter.next();
            costoCamera -= scontoSingolo.getSconto();
        }

    }


}
