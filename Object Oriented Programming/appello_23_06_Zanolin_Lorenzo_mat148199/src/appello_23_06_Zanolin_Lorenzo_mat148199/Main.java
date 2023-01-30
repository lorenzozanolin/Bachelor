package appello_23_06_Zanolin_Lorenzo_mat148199;

import appello_23_06_Zanolin_Lorenzo_mat148199.Caratteristiche.Caratteristica;
import appello_23_06_Zanolin_Lorenzo_mat148199.Caratteristiche.Piano;
import appello_23_06_Zanolin_Lorenzo_mat148199.Sconto.Sconto;
import appello_23_06_Zanolin_Lorenzo_mat148199.Servizio.Piscina;
import appello_23_06_Zanolin_Lorenzo_mat148199.Servizio.Ristorante;
import appello_23_06_Zanolin_Lorenzo_mat148199.Servizio.Sauna;
import appello_23_06_Zanolin_Lorenzo_mat148199.Servizio.Servizio;

import java.util.Date;
import java.util.List;
import java.util.Vector;

public class Main {
    public static void main(String[] args) {

        Caratteristica piano = new Piano();

        Stanza stanza = new Stanza(1, TipoStanza.SINGOLA,true,"E una bella stanza con vista su mare",piano,100);
        List<Stanza> listaStanzeAlbergo = new Vector<>();

        Ristorante ristorante = new Ristorante(5,"Bella cucina");
        List<Ristorante> listaRistoranti = new Vector<>();

        Servizio piscina = new Piscina();
        Servizio sauna = new Sauna();

        List<Servizio> listaServizi = new Vector<>();

        listaServizi.add(piscina);
        listaServizi.add(sauna);
        listaRistoranti.add(ristorante);
        listaStanzeAlbergo.add(stanza);

        Albergo albergo = new Albergo(listaStanzeAlbergo,NumeroStelle.CINQUESTELLE,listaRistoranti,listaServizi);

        List<Albergo> listaAlberghi = new Vector<>();
        listaAlberghi.add(albergo);

        List<Prenotazione> listaVecchiePrenotazioni = new Vector<>();
        List<Prenotazione> listaNuovePrenotazioni = new Vector<>();
        List<Cliente> listaClienti = new Vector<>();

        Cliente cliente = new Cliente("Lorenzo","Zanolin","ora non me lo ricordo");


        listaClienti.add(cliente);

        AziendaHoltin aziendaHoltin = new AziendaHoltin(listaAlberghi,listaVecchiePrenotazioni,listaNuovePrenotazioni,listaClienti);

        List<Servizio> listaServiziDaCercare = new Vector<>();

        Date inizioPrenotazione = new Date(),
                finePrenotazione = new Date();


        //cerca la disponibilita della stanza da cercare
        List<Albergo> listaAlberghiTrovati = aziendaHoltin.cercaDisponibilita(listaServiziDaCercare,piano,inizioPrenotazione,finePrenotazione);

        int numeroPersone = 5;
        List<Sconto> listaSconti = new Vector<>();
        aziendaHoltin.ottieniPrezzoPrevisto(numeroPersone,listaServizi,piano,inizioPrenotazione,finePrenotazione,listaSconti);

    }
}
