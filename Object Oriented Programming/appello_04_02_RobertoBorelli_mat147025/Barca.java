/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */

package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Eccezioni.CodiceUnivocoNonAncoraAssegnatoException;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Eccezioni.GpsNonDisponibileException;

public class Barca implements Mezzo, Identificabile<Integer>{
    private static int codiciBarca = 100;
    private Marca marca;
    private String nome;
    private TipoBarca tipoBarca

    private Dimensione dimensioneBarca;
    private int postiDisponibili;
    private int alberi;
    private List<Optional> optional;
    private Integer codiceBarca;

    private Noleggio noleggioAttuale;

    public Barca(Marca marca, String nome, TipoBarca tipoBarca, Dimensione dimensioneBarca, int postiDisponibili, int alberi) {
        this.marca = marca;
        this.nome = nome;
        this.tipoBarca = tipoBarca;
        this.dimensioneBarca = dimensioneBarca;
        this.postiDisponibili = postiDisponibili;
        this.alberi = alberi;
        this.codiceBarca = Barca.codiciBarca;
        Barca.codiciBarca+=100;
    }


    /**
     * Restituisce true se una barca è disponibile in un determinato periodo
     */
    public boolean èDisponibile(Date dataIniziale, Date dataFinale){}


    /**
     * Interroga il gps del mezzo per ottenere la posizione del mezzo
     *
     * @return la posizione del mezzzo
     * @throws GpsNonDisponibileException se il mezzo non ha un gps o se
     *                                    il gps non è disponibile causa segnale debole
     */
    @Override
    public Posizione ottieniPosizione() throws GpsNonDisponibileException {
        return null;
    }

    public Dimensione misura(){
        return this.dimensioneBarca;
    }


    /**
     * Restituisce un "codice" univoco assegnato all'istanza di un ogetto
     *
     * @return il codice univoco
     * @throws CodiceUnivocoNonAncoraAssegnatoException se ad una determinata
     *                                                  istanza di un ogetto non è ancora stato
     *                                                  assegnato il proprio codice univoco
     */
    @Override
    public Integer ottieniCodiceUnivoco() throws CodiceUnivocoNonAncoraAssegnatoException {
        return this.codiceBarca;
    }
}
