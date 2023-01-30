package appello_23_06_Zanolin_Lorenzo_mat148199;

import appello_23_06_Zanolin_Lorenzo_mat148199.Caratteristiche.Caratteristica;

public class Stanza {

    private int numeroStanza;
    private TipoStanza tipoStanza;
    private boolean eDisponibile;
    private String descrizione;
    private Caratteristica caratteristicaStanza;
    private long prezzoDiBase;

    public Stanza(int numeroStanza, TipoStanza tipoStanza, boolean eDisponibile, String descrizione, Caratteristica caratteristicaStanza, long prezzoDiBase) {
        this.numeroStanza = numeroStanza;
        this.tipoStanza = tipoStanza;
        this.eDisponibile = eDisponibile;
        this.descrizione = descrizione;
        this.caratteristicaStanza = caratteristicaStanza;
        this.prezzoDiBase = prezzoDiBase;
    }

    /**
     * Cerca se una stanza ha una determinata caratteristica
     * @param caratteristica da cercare della stanza
     * @return l'esito della ricerca, ovvero true se la trova, senno false
     */
    public boolean soddisfaCaratteristica(Caratteristica caratteristica){
        if(caratteristica.equals(caratteristicaStanza)){
            return true;
        }
        else{
            return false;
        }
    }


    /**
     *
     * @return il prezzo di base
     */
    public long getPrezzoBase(){return prezzoDiBase;}

}
