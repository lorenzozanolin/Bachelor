import java.util.Objects;

public class BookingAgency {

    private final BoatFactory boatFactory;
    private final Fleet fleet;
    private final PrenotationBuilder prenotationBuilder;
    private final Calendar<Prenotation> prenotationCalendar;

    public BookingAgency() {
        this.boatFactory = new BoatFactory();
        this.fleet = new Fleet();
        this.prenotationCalendar = new ConcreteCalendar<Prenotation>();
        this.prenotationBuilder = new PrenotationBuilder(this.fleet, this.prenotationCalendar);
    }

    public PrenotationBuilder getPrenotationBuilder() {
        assert(this.prenotationBuilder != null);
        return this.prenotationBuilder;
    }

    public Boat createNewBoat(BoatFactory.Dimension size, BoatFactory.NumberOfMasts numberOfMasts, BoatFactory.Brand brand, double basePrice) {
        return boatFactory.getBaseBoat(size, numberOfMasts, brand, basePrice);
    }

    public Boat applyExtraToBoat(Boat decoratedBoat, String description, double extraPrice) {
        return boatFactory.addExtras(decoratedBoat, description, extraPrice);
    }

    public void registerBoat(Boat newBoat) {
        Objects.requireNonNull(newBoat);
        assert(this.fleet != null);
        fleet.addBoatToFleet(newBoat);
    }

    public Boat getBoat(Prenotation clientPrenotation) {
        Objects.requireNonNull(clientPrenotation);
        assert(this.fleet != null);
        return this.fleet.getBoat(clientPrenotation);
    }

    public void returnBoat(Boat bookedBoat) {
        Objects.requireNonNull(bookedBoat);
        assert(this.fleet != null);
        this.fleet.returnBoat(bookedBoat);
    }

}
