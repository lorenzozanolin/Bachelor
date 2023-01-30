public class BaseBoat implements Boat {

    private final BoatFactory.Dimension size;
    private final BoatFactory.Brand brand;
    private final BoatFactory.NumberOfMasts numberOfMasts;
    private final double basePrice;

    BaseBoat(BoatFactory.Dimension size, BoatFactory.Brand brand, BoatFactory.NumberOfMasts numberOfMasts, double basePrice) {
        this.size = size;
        this.brand = brand;
        this.numberOfMasts = numberOfMasts;
        this.basePrice = basePrice;
    }

    @Override
    public double getPrice() {
        return this.basePrice;
    }

    @Override
    public BoatFactory.Dimension getSize() {
        return this.size;
    }

    @Override
    public BoatFactory.Brand getBrand() {
        return this.brand;
    }

    @Override
    public BoatFactory.NumberOfMasts getMasts() {
        return this.numberOfMasts;
    }

}
