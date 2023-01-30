/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Barca;

import java.util.List;
import java.util.stream.Stream;

public class FiltroBarca implements FiltroAstratto<Barca>{
    @Override
    public Stream<Barca> filtra(List<Barca> ogettiDaFiltrare, CaratteristicaAstratta<Barca> caratteristica) {
        return ogettiDaFiltrare.stream().filter(barca -> caratteristica.èSoddisfattaDa(barca));
    }
}
