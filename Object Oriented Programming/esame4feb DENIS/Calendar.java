import java.time.LocalDate;
import java.util.List;

/**
 * This interface provides an API to register events into a calendar and to retrieve them.
 * Events have to provide a protocol to access the beginning and the ending date and could be prenotations, timed discounts, etc...
 */

public interface Calendar<T extends Event> {

    /**
     * Modifies the concrete type by adding an event of type T to the calendar.
     * @param event: the event that needs to be scheduling. Required Non null.
     * @param startingDate: the starting Date of the event. Required Non null.
     * @param endingDate: the ending Date of the event. Required Non null.
     * @throws IllegalArgumentException if the startingDate is prior to this moment's time or if endingDate is prior to startingDate.
     * In any of these two cases, the event isn't scheduled into the calendar.
     */
    public void addEvent(T event) throws IllegalArgumentException;

    /**
     * Modifies the concrete type by removing an event of type T from the calendar.
     * @param event: the event that needs to be removed. Required Non null.
     * @throws InvalidArgumentException if event is not found in the calendar. In this case no changes are made to the calendar.
     */
    public void removeEvent(T event) throws IllegalArgumentException;

    /**
     * Returns a list of events which timespan includes this moment.
     * @return: the list of current events.
     */
    public List<T> getCurrentEvents();

    /**
     * Returns a list of events which will take place on a future date and time.
     * @param time: the date of interest
     * @return: a list of future events which timespan includes time.
     * @throws IllegalArgumentException if time is prior to this moment.
     */
    public List<T> getFutureEvents(LocalDate date) throws IllegalArgumentException;
    
}
