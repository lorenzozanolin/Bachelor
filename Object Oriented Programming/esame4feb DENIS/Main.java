import java.time.LocalDate;
import java.util.List;

// D'Ambrosi Denis Matr. #147681

public class Main {

    public static void main(String args[]) {
        BookingAgency MareESole = new BookingAgency();
        PrenotationBuilder myPrenotationBuilder = MareESole.getPrenotationBuilder();

        //Check available boats in the period I'm interested to sail
        List<Boat> availableBoatsInMyInterestedPeriod = myPrenotationBuilder.checkAvailableBoats(LocalDate.of(2021, 6, 1), LocalDate.of(2021, 6, 3));

        //Filter only boats that have a length > 8 and <= 10 meters
        List<Boat> boatsThatILike = myPrenotationBuilder.filterBySize( availableBoatsInMyInterestedPeriod, BoatFactory.Dimension.TENMETERS );

        //Book a boat that I like from the offered catalog
        Prenotation myPrenotation = myPrenotationBuilder.bookABoat( boatsThatILike.get(0), LocalDate.of(2021, 6, 1), LocalDate.of(2021, 6, 3) );
        
        //Book a skipper along the boat
        myPrenotation = myPrenotationBuilder.addExtra(myPrenotation, "Skipper", 300);

        //Confirm my prenotation
        myPrenotationBuilder.confirmPrenotation(myPrenotation);

        //Retrieve my boat with my prenotation's information
        Boat myBoat = MareESole.getBoat(myPrenotation);

        //Return the boat and pay
        MareESole.returnBoat(myBoat);
    }
        
}
