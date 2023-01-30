/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */


package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Eccezioni.StatoNoleggioInvalidoException;

import java.util.Date;
import java.util.List;

/**
 * Rappresenta il noleggio
 * Ha un suo stato statoNoleggio che varia con l'evoleversi del
 * contratto cliente/azienda
 */
public class Noleggio {
    private StatoNoleggio statoNoleggio;
    private int codiceBarca;
    private Extra serviziExtra;
    private final int codiceCliente;

    private Date dataInizioNoleggio;
    private Date dataFineNoleggio;
    private Posizione luogoInizioNoleggio;
    private Posizione luogoFineNoleggio;

    Noleggio(int codiceBarca,
             Extra serviziExtra,
             int codiceCliente,
             Date dataInizioNoleggio, Date dataFineNoleggio,
             Posizione luogoInizioNoleggio, Posizione luogoFineNoleggio){
        this.codiceBarca = codiceBarca;
        this.serviziExtra = serviziExtra;

        this.codiceCliente = codiceCliente;
        this.dataInizioNoleggio = dataInizioNoleggio;
        this.dataFineNoleggio = dataFineNoleggio;
        this.luogoInizioNoleggio = luogoInizioNoleggio;
        this.luogoFineNoleggio = luogoFineNoleggio;
    }

    //inizialmente vuota, rappresenta la lista delle penalià che il cliente
    //accumula durante il periodo di noleggio
    private List<Penalità> penalitàAccumulate;
    private int prezzoBase;

    void marcaNoleggio(StatoNoleggio statoNoleggio)
            throws StatoNoleggioInvalidoException {
        if(StatoNoleggio.transizioneAmmissibile(this.statoNoleggio, statoNoleggio)){
            this.statoNoleggio = statoNoleggio;
        }else{
            throw new StatoNoleggioInvalidoException();
        }
    }

    StatoNoleggio osservaNoleggio(){
        return this.statoNoleggio;
    }
}
