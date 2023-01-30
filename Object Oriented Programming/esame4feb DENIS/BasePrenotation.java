import java.time.Duration;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Objects;

public class BasePrenotation implements Prenotation {

    private final Boat bookedBoat;
    private final LocalDate startingDate;
    private final LocalDate endingDate;
    private double price;

    public BasePrenotation (Boat bookedBoat, LocalDate startingDate, LocalDate endingDate) throws IllegalArgumentException {
        Objects.requireNonNull(bookedBoat);
        Objects.requireNonNull(startingDate);
        Objects.requireNonNull(endingDate);
        if ( startingDate.isBefore(LocalDate.now())) {
            throw new IllegalArgumentException("startingDate has to be a future moment");
        }
        else if ( endingDate.isBefore(startingDate) ) {
            throw new IllegalArgumentException("endingDate can't be prior to startingDate");
        }
        this.bookedBoat = bookedBoat;
        this.startingDate = startingDate;
        this.endingDate = endingDate;
        this.price = bookedBoat.getPrice() * ( ChronoUnit.DAYS.between(startingDate, endingDate) );
    }

    @Override
    public Boat getBoatDetails () {
        return this.bookedBoat;
    }

    @Override
    public double getPrice() {
        return this.price;
    }

    @Override
    public LocalDate getStartingDate() {
        return this.startingDate;
    }

    @Override
    public LocalDate getEndingDate() {
        return this.endingDate;
    }

}
