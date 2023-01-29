/*
 * Protocollo della classe "Board":
 * 
 * Board b = new Board( n );
 * 
 * b.size()          :   int
 * b.queensOn()      :   int
 * b.underAttack( i, j )   :   boolean
 * b.arrangement()         :   String
 * 
 * b.addQueen( i, j );
 * b.removeQueen( i, j );
 * 
 */


public class Board{
  
  private final int size;
  private int queens;
  private int[] rowAttack;//array di inter che dice quante regine ci sono su una certa riga
  private int[] colAttack;
  private int[] dg1Attack;
  private int[] dg2Attack;
  private String config;
  
  private static final String ROWS = " 123456789ABCDEF";
  private static final String COLS = " abcdefghijklmno";
  
  
  
  public Board( int n ) {
    
    size = n;
    queens = 0;
    rowAttack = newArray(n);
    colAttack = newArray(n);
    dg1Attack = newArray( 2*n -1 );
    dg2Attack = newArray( 2*n -1 );
    config = "";
      
  }
  
  private static int[] newArray( int k ){
    
    int[] v = new int[k];
    for( int i=0; i<k; i++ )
    {
      v[i] = 0;
      
    }
    return v;
    
  }
  
  
  public int size() {
    
    return size;
    
  }
  
  public int queensOn() {
    
    return queens;
    
  }
  
  //Una regina in (i,j) e' minacciata sse e' minacciata dall'ultima regina o se era gia' minacciata prima di mettere l'ultima regina
  public boolean underAttack( int i, int j ) {
    
    return ( (rowAttack[i-1]>0) || (colAttack[j-1]>0) || (dg1Attack[i-j+size-1]>0) || (dg2Attack[i+j-2]>0) );// -1 perche' gli array partono da 0
    
  }
  
  public String arrangement() {
    
    return config;
    
  }
  
  public void addQueen( int i, int j ) {
    
    String pos = COLS.substring(j, j+1) + ROWS.substring(i, i+1);
    
    if(!config.contains(pos)){
      queens = queens + 1;
      rowAttack[i-1]++;
      colAttack[j-1]++;
      dg1Attack[i-j+size-1]++;
      dg2Attack[i+j-2]++;
      config = config + " "+ pos; 
      
    }
  }
  
  public void removeQueen( int i, int j ) {
    
    String pos = COLS.substring(j, j+1) + ROWS.substring(i, i+1);
    
    if(config.contains(pos)){
      queens = queens - 1;
      rowAttack[i-1]--;
      colAttack[j-1]--;
      dg1Attack[i-j+size-1]--;
      dg2Attack[i+j-2]--;
      int k = config.indexOf(" " + pos );
      config = config.substring( 0, k ) + config.substring(k+3); 
    
    }
  }
  
  public boolean isFreeRow( int i ){
   
    String row = ROWS.indexOf(i + "") + "";
    return !(config.contains(row));
    
  }
  
  public void addQueen( String pos){
    
    if(!config.contains(pos)){
      int row = ROWS.indexOf(pos.substring(0,1));
      int col = COLS.indexOf(pos.substring(1));

      queens = queens + 1;
      rowAttack[row-1]++;
      colAttack[col-1]++;
      dg1Attack[row-col+size-1]++;
      dg2Attack[row+col-2]++;
      config = config + " " + pos; 
      
    }
  }
  
  public String toString(){
    
    return config;
    
  }
    
  
  
}