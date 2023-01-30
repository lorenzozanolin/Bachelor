/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Eccezioni.GpsNonDisponibileException;

/**
 * Rappresenta un veicolo
 */
public interface Mezzo {
    /**
     * Interroga il gps del mezzo per ottenere la posizione del mezzo
     * @return la posizione del mezzzo
     * @throws GpsNonDisponibileException se il mezzo non ha un gps o se
     * il gps non è disponibile causa segnale debole
     */
    Posizione ottieniPosizione() throws GpsNonDisponibileException;
}
