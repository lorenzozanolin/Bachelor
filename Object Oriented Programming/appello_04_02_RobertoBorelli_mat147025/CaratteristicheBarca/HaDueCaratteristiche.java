/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca;
public class HaDueCaratteristiche<T> implements CaratteristicaAstratta<T>{
    private CaratteristicaAstratta<T> prima, seconda;

    public HaDueCaratteristiche(CaratteristicaAstratta<T> prima, CaratteristicaAstratta<T> seconda) {
        this.prima = prima;
        this.seconda = seconda;
    }


    /**
     * Restituisce true se due caratteristiche sono soddisfatte
     */
    @Override
    public boolean èSoddisfattaDa(T t) {
        return prima.èSoddisfattaDa(t) && seconda.èSoddisfattaDa(t);
    }
}
