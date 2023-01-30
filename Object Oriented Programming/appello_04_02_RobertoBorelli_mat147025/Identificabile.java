/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */

package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Eccezioni.CodiceUnivocoNonAncoraAssegnatoException;

public interface Identificabile <T>{

    /**
     * Restituisce un "codice" univoco assegnato all'istanza di un ogetto
     * @return il codice univoco
     * @throws CodiceUnivocoNonAncoraAssegnatoException se ad una determinata
     * istanza di un ogetto non è ancora stato
     * assegnato il proprio codice univoco
     */
    public T ottieniCodiceUnivoco() throws CodiceUnivocoNonAncoraAssegnatoException;
}
