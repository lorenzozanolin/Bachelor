import java.time.LocalDate;

/**
 * This interface aims to provide a protocol to work with events that have a starting and an ending date.
 * An event could be a prenotation or a timed discount.
 */

public interface Event {

    /**
     * @return: the date in which an event starts;
     */
    public LocalDate getStartingDate();

    /**
     * @return: the date in which an event starts. Can't be prior to the date provided by getStartingDate()
     */
    public LocalDate getEndingDate();
    
}
