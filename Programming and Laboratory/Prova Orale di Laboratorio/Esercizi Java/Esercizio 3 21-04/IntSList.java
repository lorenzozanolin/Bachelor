package Lezione210420;

public class IntSList
{

  // ----- Costante lista vuota (condivisa)
  
  public static final IntSList NULL_INTLIST = new IntSList();
  
  
  // ----- Rappresentazione interna di una lista: private!
  
  private final boolean empty;             // oggetti immutabili:
  private final int first;                 // variabili di istanza "final"
  private final IntSList rest;
  
  
  // ----- Operazioni di base sulle liste, mutuate da Scheme
  
  public IntSList() {                      // creazione di una lista vuota
                                           // Scheme: null
    empty = true;
    first = 0;                             // valore irrilevante in questo caso
    rest = null;
  }
  
  public IntSList( int e, IntSList il ) {  // creazione di una lista non vuota:
                                           // Scheme: cons
    empty = false;
    first = e;
    rest = il;
  }
  
  
  public boolean isNull() {                // verifica se una lista e' vuota
                                           // Scheme: null?
    return ( empty );
  }
  

  public int car() {                       // primo elemento di una lista
                                           // Scheme: car
    return first;                          // si assume: lista non vuota
  }
  
  
  public IntSList cdr() {                  // resto di una lista
                                           // Scheme: cdr
    return rest;                           // si assume: lista non vuota
  }
  
  
  // ----- Realizzazione alternativa (sostanzialmente equivalente) del "cons"
  
  public IntSList cons( int e ) 
  {          // costruzione di nuove liste
                                           // Scheme: cons
    return new IntSList( e, this );
  }
  
  
  // ----- Operazioni aggiuntive, definite in termini dei precedenti metodi
  
  public int length() {                    // lunghezza di una lista
                                           // Scheme: length
    if ( isNull() ) {
      return 0;
    } else {
      return ( 1 + cdr().length() );
    }
  }
  
  
  public int listRef( int k ) {            // elemento in posizione k
                                           // Scheme: list-ref
    if ( k == 0 ) {
      return car();
    } else {
      return ( cdr().listRef(k-1) );
    }
  }
  
  
  public boolean equals( IntSList il ) {   // contronto di liste
                                           // Scheme: equal?
    if ( isNull() || il.isNull() ) {
      return ( isNull() && il.isNull() );
    } else if ( car() == il.car() ) {
      return cdr().equals( il.cdr() );
    } else {
      return false;
    }
  }
  
  
  public IntSList append( IntSList il ) {  // fusione di liste
                                           // Scheme: append
    if ( isNull() ) {
      return il;
    } else {
      // return new IntSList( car(), cdr().append(il) );
      return ( cdr().append(il) ).cons( car() );
    }
  }
  
  
  public IntSList reverse() {              // rovesciamento di una lista
                                           // Scheme: reverse
    return reverseRec( new IntSList() );
  }
  
  private IntSList reverseRec( IntSList re ) {
  
    if ( isNull() ) {                      // metodo di supporto: private!
      return re;
    } else {
      // return cdr().reverseRec( new IntSList(car(),re) );
      return cdr().reverseRec( re.cons(car()) );
    }
  }
  
  
  // ----- Rappresentazione testuale (String) di una lista
  
  public String toString() {               // ridefinizione del metodo generale
                                           // per la visualizzazione testuale
    if ( empty ) {
      return "()";
    } else if ( rest.isNull() ) {
      return "(" + first + ")";
    } else {
      String rep = "(" + first;
      IntSList r = rest;
      while ( !r.isNull() ) {
        rep = rep + ", " + r.car();
        r = r.cdr();
      }
      return ( rep + ")" );
    }
  }


}  // class IntSList
