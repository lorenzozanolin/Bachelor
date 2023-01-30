public class BoatFactory {

    public enum Dimension { SEVENMETERS, EIGHTMETERS, TENMETERS, FOURTEENMETERS, TWENTYMETERS };
    public enum Brand { XYACHTS, BAVARIA, GRANDSOLEIL, BENETEAU };
    public enum NumberOfMasts { ONE, TWO };

    public Boat getBaseBoat(Dimension size, NumberOfMasts numberOfMasts, Brand brand, double basePrice) {
        return new BaseBoat(size, brand, numberOfMasts, basePrice);
    }

    public Boat addExtras(Boat baseBoat, String description, double extraPrice) {
        return new BoatExtra(baseBoat, description, extraPrice);
    }


}
