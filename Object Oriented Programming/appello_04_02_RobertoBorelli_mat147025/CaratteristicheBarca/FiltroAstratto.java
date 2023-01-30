/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca;
import java.util.List;
import java.util.stream.Stream;

public interface FiltroAstratto <T>{
    /**
     * Restituisc tutti gli elementi ogettiDaFiltrare che soddisfano una certa caratteristica
     */
    Stream<T> filtra(List<T> ogettiDaFiltrare, CaratteristicaAstratta<T> caratteristica);
}
