package appello_23_06_Zanolin_Lorenzo_mat148199.Sconto;

public class SpecificoAlbergo implements Sconto{
    @Override
    public String getDescription() {
        return "Sconto per albergo specifico";
    }

    @Override
    public double getSconto() {
        return 0;
    }
}
