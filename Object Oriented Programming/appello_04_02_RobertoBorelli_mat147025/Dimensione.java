/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;

/**
 * ADT immutabile per le dimensioni di un ogetto
 */
public class Dimensione {
    private final float larghezza;
    private final float profondità;
    private final float lunghezza;

    public Dimensione(float larghezza, float profondità, float lunghezza) {
        this.larghezza = larghezza;
        this.profondità = profondità;
        this.lunghezza = lunghezza;
    }

    /**
     * Calcola se una dimensione è contenuta strettamente
     * in volume in questa dimensione
     * @return true se la dimesnione è contenuta, false altrimenti
     */
    public boolean contiene(Dimensione dimensione){
        return this.getLarghezza() < dimensione.getLarghezza()
                && this.getLunghezza() < dimensione.getLunghezza()
                && this.getProfondità() < dimensione.getProfondità();
    }

    public float getLarghezza() {
        return larghezza;
    }

    public float getLunghezza() {
        return lunghezza;
    }

    public float getProfondità() {
        return profondità;
    }
}
