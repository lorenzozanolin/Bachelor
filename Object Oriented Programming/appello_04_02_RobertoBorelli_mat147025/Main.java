/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */

package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca.ContieneAlberi;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca.GrandeAlPiù;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.CaratteristicheBarca.HaDueCaratteristiche;
import java.util.Date;
import java.util.List;
import java.util.Vector;

public class Main {
    public static void main(String[] args) {
        Barca barchetta = new Barca(Marca.BAVARIA,"barchetta",TipoBarca.INDUSTRIALE,
                new Dimensione(10,10,10),20, 2);

        Barca barcone = new Barca(Marca.BAVARIA,"barcone",TipoBarca.A_MOTORE,
                new Dimensione(10,10,10),200, 1);
        List<Barca> barche = new Vector<>();
        barche.add(barchetta);

        AziendaNoleggioBarche MareESole = new AziendaNoleggioBarche(barche,listino);

        MareESole.aggiungiBarcaAllaFlotta(barcone);

        //cerca le barche che hanno 2 alberi e che sono grandi al piu (10,15,20)
        List<Extra> extras;
        MareESole.cercaBarche(
                new HaDueCaratteristiche<>(
                        new ContieneAlberi(2),
                        new GrandeAlPiù(new Dimensione(10,15,20))
                ),
                extras
        );


        //prenota barcone per mario e crea un noleggio
        Cliente mario = new Cliente("awhh", "mario", "rossi");
        MareESole.registraCliente(mario);
        Noleggio noleggioDiMario =
                MareESole.prenota(barcone.ottieniCodiceUnivoco(),
                new Posizione(20, 50),
                new Posizione(40,60),
                new Date(),
                new Date(),
                mario.ottieniCodiceUnivoco(),
                extras
        );

        //da il barcone a mario e calcola il prezzo del noleggio
        int prezzoBaseMario = MareESole.consegnaAlCliente(barcone.ottieniCodiceUnivoco(), noleggioDiMario);

        //L'azienda si riprende il barcone da mario
        int prezzoViolazioniMario = MareESole.riprendiDaCliente(barcone.ottieniCodiceUnivoco(), noleggioDiMario);
    }
}
