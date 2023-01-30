package appello_23_06_Zanolin_Lorenzo_mat148199;

public class Cliente{

    private String nome;
    private String cognome;
    private String codiceFiscale;

    public Cliente(String nome, String cognome, String codiceFiscale) {
        this.nome = nome;
        this.cognome = cognome;
        this.codiceFiscale = codiceFiscale;
    }

    /**
     *
     * @return il codice fiscale del cliente
     */
    public String getCodiceFiscale(){
        return codiceFiscale;
    }
}
