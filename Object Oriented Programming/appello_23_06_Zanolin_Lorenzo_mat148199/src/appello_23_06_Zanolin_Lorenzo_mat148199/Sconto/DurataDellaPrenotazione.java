package appello_23_06_Zanolin_Lorenzo_mat148199.Sconto;

public class DurataDellaPrenotazione implements Sconto{
    @Override
    public String getDescription() {
        return "Sconto per la durata della prenotazione";
    }

    @Override
    public double getSconto() {
        return 0;
    }
}
