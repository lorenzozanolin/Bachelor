import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.Objects;

public class Fleet {

    private List<Boat> currentFleet;
    private List<Boat> rentedBoats;

    Fleet() {
        this.currentFleet = new ArrayList<Boat>();
        this.rentedBoats = new ArrayList<Boat>();
    }

    public Boat getBoat(Prenotation clientPrenotation) throws IllegalArgumentException {
        Objects.requireNonNull(clientPrenotation);
        assert(currentFleet != null);
        assert(rentedBoats != null);
        if ( currentFleet.contains(clientPrenotation.getBoatDetails()) ) {
            throw new IllegalArgumentException( "Boat not available");
        } else if ( rentedBoats.contains(clientPrenotation.getBoatDetails()) ) {
            throw new IllegalArgumentException( "Boat was already rented");
        }
        this.currentFleet.remove(clientPrenotation.getBoatDetails());
        this.rentedBoats.add(clientPrenotation.getBoatDetails());
        assert(!rentedBoats.isEmpty());
        return clientPrenotation.getBoatDetails();
    }

    public void returnBoat(Boat clientBoat) throws IllegalArgumentException {
        Objects.requireNonNull(clientBoat);
        assert(currentFleet != null);
        if ( currentFleet.contains(clientBoat) ) {
            throw new IllegalArgumentException("Boat is already in the fleet");
        } else if ( !rentedBoats.contains(clientBoat) ) {
            throw new IllegalArgumentException("Boat was not been rented");
        }
        this.currentFleet.add(clientBoat);
        this.rentedBoats.remove(clientBoat);
        assert(!currentFleet.isEmpty());
    }

    public void addBoatToFleet(Boat newBoat) {
        Objects.requireNonNull(newBoat);
        assert(currentFleet != null);
        assert(rentedBoats != null);
        this.currentFleet.add(newBoat);
    }

    public List<Boat> getCompleteFleet() {
        assert(this.currentFleet != null);
        assert(this.rentedBoats != null);
        List<Boat> completeFleet = new ArrayList<Boat>();
        ListIterator<Boat> boatIterator = currentFleet.listIterator();
        while ( boatIterator.hasNext() ) {
            completeFleet.add(boatIterator.next());
        }
        boatIterator = rentedBoats.listIterator();
        while ( boatIterator.hasNext() ) {
            completeFleet.add(boatIterator.next());
        }
        return completeFleet;
    }
    
}
