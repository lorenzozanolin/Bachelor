package appello_23_06_Zanolin_Lorenzo_mat148199.Sconto;

public class PeriododellAnno implements Sconto{
    @Override
    public String getDescription() {
        return "Sconto per periodo dell'anno";
    }

    @Override
    public double getSconto() {
        return 0;
    }
}
