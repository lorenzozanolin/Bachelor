/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;

/**
 * Dato astratto immutabile per rappresentare una posizione
 * Ha una cordinata x e una y
 */
public class Posizione {
    private final float longitudine;
    private final float latitudine;


    public Posizione(float longitudine, float latitudine) {
        this.longitudine = longitudine;
        this.latitudine = latitudine;
    }

    public float ottieniLongitudine() {
        return this.longitudine;
    }

    public float ottieniLatitudine() {
        return this.latitudine;
    }
}