package appello_23_06_Zanolin_Lorenzo_mat148199.Servizio;

import appello_23_06_Zanolin_Lorenzo_mat148199.Servizio.Servizio;

public class Ristorante{

    private int numeroPersonale;
    private String nomeRistorante;

    public Ristorante(int numeroPersonale, String nomeRistorante) {
        this.numeroPersonale = numeroPersonale;
        this.nomeRistorante = nomeRistorante;
    }

    /**
     * Funzione che ritorna le informazioni sul ristorante
     * @return il nome del ristorante
     */
    public String descrizione() {
        return "Ristorante "+nomeRistorante;
    }


}
