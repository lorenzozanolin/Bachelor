package appello_23_06_Zanolin_Lorenzo_mat148199.Sconto;

public class ClientiFedeli implements Sconto {
    @Override
    public String getDescription() {
        return "Sconto cliente fedele";
    }

    @Override
    public double getSconto() {
        return 0;
    }
}
