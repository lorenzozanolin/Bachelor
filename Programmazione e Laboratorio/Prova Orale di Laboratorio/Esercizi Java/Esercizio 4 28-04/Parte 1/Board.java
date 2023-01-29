/*
 * Protocollo della classe "Board":
 * 
 * Board b = new Board( n );
 * 
 * b.size()          :   int;
 * b.queensOn()      :   int
 * b.underAttack( i, j )   :   boolean
 * b.arrangement()         :   String
 * 
 * b.addQueen( i, j)       : Board
 * 
 */

public class Board{
  
  private final int size;
  private final int queens;
  
  private final SList<Integer> enRows;// endangered rows - righe minacciate su cui c'e' gia' una regina
  private final SList<Integer> enCols;
  private final SList<Integer> enDiagUp;// diagonali ascendenti minacciate
  private final SList<Integer> enDiagDown;
  
  private final String config;
  private static final String ROWS = " 123456789ABCDEF"; //contiene tutte le righe
  private static final String COLS = " abcdefghijklmno"; //contiene tutte le colonne
  
  public Board( int n ){
   
    size = n;
    queens = 0;
    enRows = new SList<Integer>();
    enCols = new SList<Integer>();
    enDiagUp = new SList<Integer>();
    enDiagDown = new SList<Integer>();
    config = "";
    
  }
  
  private Board( int n, int q, SList<Integer> r, SList<Integer> c, SList<Integer> du, SList<Integer> dd, String arr ){
    
    size = n;
    queens = q;
    enRows = r;
    enCols = c;
    enDiagUp = du;
    enDiagDown = dd;
    config = arr;
    
  }
  
  public int size(){
   
    return size;
    
  }
  
  public int queensOn(){
   
    return queens;
    
  }
  
  public boolean underAttack( int i, int j){
   
    return underAttackRec( i, j, enRows, enCols, enDiagUp, enDiagDown );
    
  }
  
  private boolean underAttackRec( int i, int j, SList<Integer> r, SList<Integer> c, SList<Integer> du, SList<Integer> dd ){
    
    if( r.isNull() )//se una delle liste e' vuota significa che la posizione <i,j> non puo' essere minacciata
      return false;
    else if( (r.car() == i) || (c.car() == j) || (du.car() == i-j) || (dd.car() == i+j) )
      return true;
    else
      return underAttackRec( i, j, r.cdr(), c.cdr(), du.cdr(), dd.cdr() );
    
  }
  
  public Board addQueen( int i, int j ){
    
    return new Board( this.size,
                      this.queens+1,
                      this.enRows.cons(i),
                      this.enCols.cons(j),
                      this.enDiagUp.cons(i-j),
                      this.enDiagDown.cons(i+j),
                      this.config + " "+ COLS.substring(j, j+1) + ROWS.substring(i, i+1) );
                       
    
  }

  public String toString(){
   
    return config;
    
  }
    
  
}//class Board
