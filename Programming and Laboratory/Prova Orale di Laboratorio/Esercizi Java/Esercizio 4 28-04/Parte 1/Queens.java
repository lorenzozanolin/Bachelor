
/*
 * Rompicapo delle "n regine"
 *
 * Ultimo aggiornamento: 12/04/2018
 *
 *
 * Dato astratto "configurazione della scacchiera":  Board
 *
 * Operazioni:
 *
 *   new Board( int n )           :  costruttore (scacchiera vuota)
 *
 *   size()                       :  int
 *
 *   queensOn()                   :  int
 *
 *   underAttack( int i, int j )  :  boolean
 *
 *   addQueen( int i, int j )     :  Board
 *
 *   arrangement()                :  String
 *
 *
 * Board b;
 *
 *   new Board(n)           costruttore della scacchiera n x n vuota;
 *   b.size()               dimensione n della scacchiera b;
 *   b.queensOn()           numero di regine collocate nella scacchiera b;
 *   b.underAttack(i,j)     la posizione <i,j> e' minacciata?
 *   b.addQueen(i,j)        scacchiera che si ottiene dalla configurazione b
 *                          aggiungendo una nuova regina in posizione <i,j>
 *                          (si assume che la posizione non sia minacciata);
 *   b.arrangement() :      descrizione "esterna" della configurazione
 *                          (convenzioni scacchistiche).
 */


public class Queens {


  public static final SList<Board> NULL_BOARDLIST = new SList<Board>();
  
  
  /*
   * I. Numero di soluzioni:
   *
   *
   * Il numero di modi diversi in cui si possono disporre n regine
   *
   *   numberOfSolutions( n )
   *
   * in una scacchiera n x n e' dato dal numero di modi diversi in
   * cui si puo' completare la disposizione delle regine a partire
   * da una scacchiera n x n inizialmente vuota
   *
   *   numberOfCompletions( new Board(n) )
   */
  
  public static int numberOfSolutions( int n ) {
    
    return numberOfCompletions( new Board(n) );
  }
  
  
  /*
   * Il numero di modi in cui si puo' completare la disposizione
   * a partire da una scacchiera b parzialmente configurata
   *
   *   numberOfCompletions( b )   : int
   *
   * dove k regine (0 <= k < n) sono collocate nelle prime k righe
   * di b, si puo' determinare a partire dalle configurazioni
   * che si ottengono aggiungendo una regina nella riga k+1 in tutti
   * i modi possibili (nelle posizioni che non sono gia' minacciate)
   *
   *   for ( int j=1; j<=n; j=j+1 ) {
   *     if ( !b.underAttack(i,j) ) { ... b.addQueen(i,j) ... }
   *   }
   *
   * calcolando ricorsivamente per ciascuna di queste il numero
   * di modi in cui si puo' completare la disposizione
   *
   *   numberOfCompletions( b.addQueen(i,j) )
   *
   * e sommando i valori che ne risultano
   *
   *   count = count + numberOfCompletions( ... )
   *
   * Se invece la scacchiera rappresenta una soluzione (q == n)
   * c'e' un solo modo (banale) di completare la disposizione:
   * lasciare le cose come stanno!
   */
  
  private static int numberOfCompletions( Board b ) {
  
    int n = b.size();
    int q = b.queensOn();
    
    if ( q == n ) {
    
      return 1;
    
    } else {
    
      int i = q + 1;
      int count = 0;
      
      for ( int j=1; j<=n; j=j+1 ) {
        if ( !b.underAttack(i,j) ) {
        
          count = count + numberOfCompletions( b.addQueen(i,j) );
      }}
      return count;
    }
  }
  
  
  /*
   * II. Lista delle soluzioni:
   *
   * Confronta il programma precedente!
   */
  
  public static SList<Board> listOfAllSolutions( int n ) {
  
    return listOfAllCompletions( new Board(n) );
  }
  
  
  private static SList<Board> listOfAllCompletions( Board b ) {
  
    int n = b.size();
    int q = b.queensOn();
    
    if ( q == n ) {
    
      return ( NULL_BOARDLIST.cons(b) );
    
    } else {
    
      int i = q + 1;
      SList<Board> solutions = NULL_BOARDLIST;
      
      for ( int j=1; j<=n; j=j+1 ) {
        if ( !b.underAttack(i,j) ) {
        
          solutions = solutions.append( listOfAllCompletions(b.addQueen(i,j)) );
      }}
      return solutions;
    }
  }
  
  
  // Eventuale programma principale
  
  public static void main( String args[] ) {
  
    int n = Integer.parseInt( args[0] );
    
    System.out.println( numberOfSolutions(n) );
    System.out.println( listOfAllSolutions(n) );
  }


}  // class Queens
