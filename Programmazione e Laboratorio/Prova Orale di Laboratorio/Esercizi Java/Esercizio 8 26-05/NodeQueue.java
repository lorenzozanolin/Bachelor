/*
 * Protocollo della classe NodeQueue:
 *
 * NodeQueue nq = new NodeQueue()  //costruttore generico, nuova coda di nodi
 *
 * nq.size()        :   int     //numero di elementi della coda
 *
 * nq.peek()        :   Node    //restituisce l'elemento di peso minore (senza rimuoverlo dalla coda)
 *
 * nq.poll()        :   Node    //restituisce e rimuove l'elemento di peso minore
 *
 * nq.add( Node n ) :   void    //aggiunge un nodo alla coda
 *
*/
public class NodeQueue{

  private Node[] coda;
  private int size;
  private int maxSize = 100;

  public NodeQueue(){

    size = 0;
    coda = new Node[maxSize];

  }

  public int size(){

    return size;

  }

  public Node peek(){

    if( size == 0 )
      return null;
    else{

      Node min = coda[0];

      for(int i=1; i<size; i++ ){

        if( min.compareTo( coda[i] ) >= 0 )
          min = coda[i];

      }

      return min;

    }
  }

  public Node poll(){

    if( size == 0 )
      return null;
    else{
      Node min = this.peek();
      int i = 0;
      for(int k=0; k<size; k++){

        if( coda[k] == min ){
          i = k;  //mi salvo la posizione
          k = size; //faccio uscire dal ciclo
        }

      }

      while( size - i > 0 ){

        coda[i] = coda[i+1]; //shifto verso sx gli elementi successivi a quello rimosso in modo da sovrascriverlo
        i++;

      }

      coda[size] = null; //svuoto l'array all'ultima posizione
      size  = size - 1;  //riduco la dimensione totale

      return min;
    }
  }

  public void add( Node n ){

    if( size == maxSize ){  //se la dimensione massima dell'array e' gia' stata raggiunta allora devo aumentarla

      maxSize = maxSize + 10;
      Node[] supp = new Node[maxSize]; //uso un array ausiliario di dimensione maggiore

      for(int i=0; i<size; i++) //salvo tutte le celle del vecchio array nel nuovo array
        supp[i] = coda[i];

      coda = supp; //assegno al vecchio vettore quello nuovo che ha una dimensione piu grande

    }
    //altrimenti nel caso ci fosse ancora spazio
    size = size + 1; //incremento
    coda[size-1] = n; //inserisco

  }

}//class NodeQueue
