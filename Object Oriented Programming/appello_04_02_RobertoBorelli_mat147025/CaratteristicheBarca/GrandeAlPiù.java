/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Barca;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Dimensione;

public class GrandeAlPiù implements CaratteristicaAstratta<Barca> {
    private Dimensione dimensione;

    public GrandeAlPiu(Dimensione d){
        this.dimensione = d;
    }

    /**
     *Restituisce true se una barca è più piccola di this.dimensione*/
    @Override
    public boolean èSoddisfattaDa(Barca barca) {
        return barca.misura().contiene(dimensione);
    }
}
