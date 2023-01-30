/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */

package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Sconti;

/**
 * Rappresenta uno sconto applicato ad un ogetto
 * Ad esempio una classe che implementa Sconto<Dimensione> calcola un particolare sconto data una dimensione
 */
public interface Sconto <T>{

    /**
     * Calcola lo sconto per un ogetto
     */
    int calcolaSconto(T t);

    /**
     * Restituisce true se un ogetto t ha diritto a a sconto
     */
    boolean haDirittoAsconto(T t);
}
