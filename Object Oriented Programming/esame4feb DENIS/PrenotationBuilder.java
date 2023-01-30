import java.time.LocalDate;
import java.util.List;
import java.util.ListIterator;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * This class aims to provide an ADT for clients to use in order to book a boat and customize their prenotation.
 * The rep invariant is that agencyFleet and prenotationCalendar are never null.
 */


public class PrenotationBuilder {

    private final Fleet agencyFleet;
    private final Calendar<Prenotation> prenotationCalendar;

    /**
     * Returns a new instance of PrenotationBuilder
     * @param agencyFleet: an Object that keeps track of the agency's boats. Required Non Null
     * @param prenotationCalendar: an Object that keeps track of the agency's prenotation calendar. Required Non Null.
     * @return: a new instance of PrenotationBuilder
     */
    public PrenotationBuilder(Fleet agencyFleet, Calendar<Prenotation> prenotationCalendar) {
        Objects.requireNonNull(agencyFleet);
        Objects.requireNonNull(prenotationCalendar);
        this.agencyFleet = agencyFleet;
        this.prenotationCalendar = prenotationCalendar;
    }

    public List<Boat> checkAvailableBoats(LocalDate startingDate, LocalDate endingDate) {
        List<Prenotation> beforePrenotations = prenotationCalendar.getFutureEvents(startingDate);
        List<Prenotation> afterPrenotations = prenotationCalendar.getFutureEvents(endingDate);
        List<Boat> completeFleet = agencyFleet.getCompleteFleet();
        ListIterator<Prenotation> consideredPrenotation = beforePrenotations.listIterator();
        while (consideredPrenotation.hasNext()) {
            completeFleet.remove(consideredPrenotation.next().getBoatDetails());
        }
        consideredPrenotation = afterPrenotations.listIterator();
        while (consideredPrenotation.hasNext()) {
            completeFleet.remove(consideredPrenotation.next().getBoatDetails());
        }
        return completeFleet;
    }

    public List<Boat> filterByMastsNumber(List<Boat> unfilteredList, BoatFactory.NumberOfMasts numberOfMasts) {
        return unfilteredList.stream().filter(b -> (b.getMasts() == numberOfMasts)).collect(Collectors.toList());
    }

    public List<Boat> filterBySize(List<Boat> unfilteredList, BoatFactory.Dimension size) {
        return unfilteredList.stream().filter(b -> (b.getSize() == size)).collect(Collectors.toList());
    }

    public Prenotation bookABoat(Boat boatToBook, LocalDate startingDate, LocalDate endingDate) throws IllegalArgumentException{
        if (!checkAvailableBoats(startingDate, endingDate).contains(boatToBook)) {
            throw new IllegalArgumentException("The boat is not available for the given timespan");
        }
        return new BasePrenotation(boatToBook, startingDate, endingDate);
    }

    public Prenotation addExtra(Prenotation basePrenotation, String description, double extraPrice) {
        return new PrenotationExtra(basePrenotation, description, extraPrice);
    }

    public void confirmPrenotation(Prenotation acceptedPrenotation) {
        this.prenotationCalendar.addEvent(acceptedPrenotation);
    }

}
