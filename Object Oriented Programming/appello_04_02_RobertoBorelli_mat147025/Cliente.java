/**
 * Roberto Borelli
 * Matricola: 147025
 * Programmazione orientata agli ogetti
 * Esame del 04/02/2021
 */

package it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025;
import it.uniud.year2.poo.appello_04_02_RobertoBorelli_mat147025.Eccezioni.CodiceUnivocoNonAncoraAssegnatoException;
import java.util.Date;

/**
 * Ogetto immutabile per rappresentare i clienti che hanno o hanno avuto rapporti conl'azienda di prenotazioni
 */
public class Cliente implements Identificabile<String>{
    private final String codiceFiscale;
    private final String nome;
    private final String cosgnome;
    private final Date dataInizioRapporti; //rappresenta la data di inizio rapporti con l'azienda

    /**
     * Crea un nuovo cliente dell'azienda
     */
    public Cliente(String codiceFiscale, String nome, String cosgnome) {
        this.codiceFiscale = codiceFiscale;
        this.nome = nome;
        this.cosgnome = cosgnome;
        this.dataInizioRapporti = new Date();
    }

    public Date ottieniDataInizioRapporti(){
        return this.dataInizioRapporti;
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
    public String ottieniCodiceUnivoco() throws CodiceUnivocoNonAncoraAssegnatoException {
        return this.codiceFiscale;
    }
}
