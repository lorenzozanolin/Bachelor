/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Barca;

public class ContieneAlberi implements CaratteristicaAstratta<Barca> {
    private int n;
    public ContieneAlberi(int n){
        this.n = n;
    }

    /**
     * Restituisce true se una barca ha n alberi
     */
    @Override
    public boolean èSoddisfattaDa(Barca barca) {
        return barca.contaAlberi() == n;
    }
}
