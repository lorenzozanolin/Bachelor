import java.time.LocalDate;

/**
 * This interface aims to provide an API that allows to retrieve information of
 * boat prenotations
 */

public interface Prenotation extends Event{

    /**
     * @return: a (>0) double that shows the total price of the prenotation.
     */
    public double getPrice();

    /**
     * @return: a Non-Null instance of Boat linked to the prenotation;
     */
    public Boat getBoatDetails();

    /**
     * @return: the starting date of the prenotation
     */
    public LocalDate getStartingDate();

    /**
     * @return: the ending date of the prenotation
     */
    public LocalDate getEndingDate();
    
}
