public class BoatExtra implements Boat{

    private final Boat decoratedBoat;
    private final String description;
    private final double extraPrice;

    public BoatExtra (Boat boatToDecorate, String descriptionOfExtra, double extraPrice) {
        this.decoratedBoat = boatToDecorate;
        this.description = descriptionOfExtra;
        this.extraPrice = extraPrice;
    }

    @Override
    public double getPrice() {
        return this.decoratedBoat.getPrice() + this.extraPrice;
    }

    @Override
    public BoatFactory.Dimension getSize() {
        return this.decoratedBoat.getSize();
    }

    @Override
    public BoatFactory.Brand getBrand() {
        return this.decoratedBoat.getBrand();
    }

    @Override
    public BoatFactory.NumberOfMasts getMasts() {
        return this.decoratedBoat.getMasts();
    }
    
}
