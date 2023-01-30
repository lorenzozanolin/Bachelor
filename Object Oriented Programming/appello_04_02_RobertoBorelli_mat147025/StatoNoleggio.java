/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */



package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;

/**
 * Rappresenta lo stato di un noleggio
 */
public enum StatoNoleggio {
    PRENOTATO(1), PRENOTAZIONE_FALLITA(1),
    IN_CORSO(2),
    CONCLUSO(3);

    private int ordine;
    private StatoNoleggio(int ordine){
        this.ordine = ordine;
    }

    /**
     * Verifica se una transazione t: stato1 -> stato2 è ammissibile
     * (ad esempio una transazione da CONCLUSO a PRENOTATO non è ammissbile)
     * @param statoNoleggio1 lo stato antecedente alla transione
     * @param statoNoleggio2 lo stato successivo alla transione
     * @return true se la transizione è ammissibile
     */
    public static boolean transizioneAmmissibile(StatoNoleggio statoNoleggio1, StatoNoleggio statoNoleggio2){
        return statoNoleggio1.ordine < statoNoleggio2.ordine;
    }
}
