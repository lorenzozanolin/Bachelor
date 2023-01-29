package Esercizio0505;

/**
 * Costruzione classi
 * 
 * lista vuota: null ---> creare un oggetto del tipo IntSList vuoto
 * ---- IntSList  il = new IntSList() // null
 * 
 * confronto con lista vuota: null?
 * ---- il.isNull()         : boolean // null?
 * 
 * accesso al primo elemento della lista: car
 * ---- il.car()            : int     // car
 * 
 * accesso al resto della lista: cdr
 * ---- il.cdr()            : IntSList // cdr
 * 
 * unione di liste: cons
 * ---- il.cons(n)          : IntSList    // cons
 * 
 * lunghezza liste: length
 * ---- il.length()         : int         // length
 *  
 * accesso a un elemento della lista:
 * ---- il.listRef(i)       : int       //list-ref
 * 
 * confronto lunghezza liste:
 * ---- il.equals(cf)       : boolean  //equal?
 * 
 * apposizione di liste:
 * ---- il.append(tl)       : IntSList //append
 * 
 * rovesciamento liste:
 * ---- il.reverse()        : IntSList //reverse
 * 
*/


public class IntSList{
  
  //Costante lista vuota:
  public static final IntSList NULL_INTLIST = new IntSList();
  
  //Quali dati caratterizzano una lista di interi?
  
  private final boolean empty;
  
  private final int first;  //Private perche' non ha senso che venga usata fuori dalla classe
  
  private final IntSList rest;
  
  
  

   
  //-----Metodi della classe
  public IntSList() { //costruttore generico, crea liste vuote (andando pero' a occupare diverse locazioni di memoria)
   
    empty = true;
    first = 0;
    rest = null;
    
  }
  
  public IntSList( int f, IntSList r  ) {// Costruttore "specifico" (non e' il termine corretto ma da' l'idea)
  
    empty = false;
    first = f;
    rest = r;
  
  }
  
  public boolean isNull() {
   
    return empty;
    
  }
  
  public int car() {
  
    return first;
  
  }
  
  public IntSList cdr() {
  
    return rest;
  
  }
  
  public IntSList cons( int n ) { //Cons restituisce una nuova lista --> si deve usare un costruttore
  
    return ( new IntSList( n, this ) );
  
  }
  
  public int length() {
    
    if( this.isNull() ) // Se non ci sono ambiguita' non occorre indicare this
      return 0;
    else
      return 1 + this.cdr().length();
    
  }
  
  public int listRef( int i ) { // 0 <= i < length
    
    if( i == 0 )
      return car();
    else
      return cdr().listRef( i - 1 );
    
  }
  
  public boolean equals( IntSList cf ) {
    
    if( isNull() )
      return cf.isNull();
    else if( cf.isNull() )
      return false;
    else if( car() == cf.car() )
      return cdr().equals( cf.cdr() );
    else
      return false;
      
  }
  
  public IntSList append( IntSList tl ) {
    
    if( isNull() )
      return tl;
    else
      return cdr().append( tl ).cons( car() );
    
  }
  
  public IntSList reverse() {
    
    return reverseRec( NULL_INTLIST );
    
  }
  
  private IntSList reverseRec( IntSList rl ) {
   
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
      IntSList r = rest;
      while ( !r.isNull() ) {
        rep = rep + ", " + r.car();
        r = r.cdr();
      }
      return ( rep + ")" );
    }
  }
    
  
}//class IntSList

// Nota: la modifica di liste con cons() in realta' non modifica le liste preesistenti ma crea una nuova lista;
//Questo e' reso ancora piu' esplicito dal "final" delle variabili caratterizzanti

/*
 * Esempi:
 * 
 *  ( new IntSList() ).cons( 5 ) --> (5) 
 *  
 * oppure:
 *    IntSList il = new IntSList();
 *    il.isNull() ---> true
 *    
 *    il.cons( 5 );
 *    il.isNull() ---> false
 * 
 * 
 *    il = il.cons(4)
 *    il --> (4 5)
*/