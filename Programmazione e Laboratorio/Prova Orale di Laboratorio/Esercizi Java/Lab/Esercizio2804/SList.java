package Esercizio2804;

/**
 * Liste generiche di elementi di tipo t
 * 
 * ---- SList<T>  tl = new SList<T>() // null
 * 
 * ---- tl.isNull()         : boolean // null?
 * 
 * ---- tl.car()            : int     // car
 * 
 * ---- tl.cdr()            : SList<T> // cdr
 * 
 * ---- tl.cons(e)          : SList<T>   // cons
 * 
 * ---- tl.length()         : int         // length
 *  
 * ---- tl.listRef(i)       : int       //list-ref
 * 
 * ---- tl.equals(cf)       : boolean  //equal?
 * 
 * ---- tl.append(tl)       : SList<T> //append
 * 
 * ---- tl.reverse()        : SList<T> //reverse
 * 
*/

//Questo protocollo consente di creare liste di tipo generico -->Anche interi o stringhe volendo

public class SList<T>{
  
  //Costante lista vuota: (qua non ha senso introdurre una lista vuota costante dato che dipende dal tipo)
 // public static final SList NULL_INTLIST = new IntSList();
  
  //Quali dati caratterizzano una lista di interi?
  
  private final boolean empty;
  
  private final T first;  //Private perche' non ha senso che venga usata fuori dalla classe
  
  private final SList<T> rest;
  
  
  

   
  //-----Metodi della classe
  public SList() { //costruttore generico, crea liste vuote (andando pero' a occupare diverse locazioni di memoria)
   
    empty = true;
    first = null; //irrelevante perche' la lista e' vuota
    rest = null;
    
  }
  
  public SList( T f, SList<T> r  ) {// Costruttore "specifico" (non e' il termine corretto ma da' l'idea)
  
    empty = false;
    first = f;
    rest = r;
  
  }
  
  public boolean isNull() {
   
    return empty;
    
  }
  
  public T car() {
  
    return first;
  
  }
  
  public SList<T> cdr() {
  
    return rest;
  
  }
  
  public SList<T> cons( T e ) { //Cons restituisce una nuova lista --> si deve usare un costruttore
  
    return ( new SList<T>( e, this ) );
  
  }
  
  public int length() {
    
    if( this.isNull() ) // Se non ci sono ambiguita' non occorre indicare this
      return 0;
    else
      return 1 + this.cdr().length();
    
  }
  
  public T listRef( int i ) { // 0 <= i < length
    
    if( i == 0 )
      return car();
    else
      return cdr().listRef( i - 1 );
    
  }
  
  public boolean equals( SList cf ) {
    
    if( isNull() )
      return cf.isNull();
    else if( cf.isNull() )
      return false;
    else if( car() == cf.car() )
      return cdr().equals( cf.cdr() );
    else
      return false;
      
  }
  
  public SList<T> append( SList<T> tl ) {
    
    if( isNull() )
      return tl;
    else
      return cdr().append( tl ).cons( car() );
    
  }
  
  public SList<T> reverse() {
    
    return reverseRec( new SList<T>() );
    
  }
  
  private SList<T> reverseRec( SList<T> rl ) {
   
    if( isNull() )
      return rl;
    else 
      return cdr().reverseRec( rl.cons( car() ) );
    
  }
  
  public String toString(){ //Ordina le liste in stringhe in modo che possano essere stampate
    
    if ( empty ) 
      return "()";
    else if ( rest.isNull() )
      return "(" + first + ")";
    else {
       String rep = "(" + first;
       SList r = rest;
      while ( !r.isNull() ) {
        rep = rep + ", " + r.car();
        r = r.cdr();
      }
      return ( rep + ")" );
    }
  }
    
  
}//class SList<T>
