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
  private int size; //dimensione massima temporanea, ovvero il numero di nodi inserito
  private int maxSize = 128; //dimensione massima del vettore (128 perche' e' il numero totale di caratteri ascii)

  public NodeQueue(){ //costruttore

    size = 0; //dimensione corrente = 0
    coda = new Node[maxSize]; //dimensione massima

  }

  public int size(){ //ritorna la dimensione della coda

    return size;

  }

  public Node peek(){ //prende il primo nodo senza rimuoverlo

    if( size == 0 )
      return null;
    else{

      Node min = coda[0];

      for(int i=1; i<size; i++ ){ //ricerca del nodo con peso minore

        if( min.compareTo( coda[i] ) >= 0 )
          min = coda[i];

      }

      return min; //ritorna il minimo trovato senza rimuoverlo

    }
  }

  public Node poll(){ //ritorna il nodo minore rimuovendolo

    if( size == 0 )
      return null;
    else{
      Node min = this.peek(); //si recupera una copia del minore e va a cercarne l'indice
      int i = 0;
      for(int k=0; k<size; k++){

        if( coda[k] == min ){
          i = k;  //mi salvo la posizione
          k = size; //faccio uscire dal ciclo
        }

      }

      while( size - i > 0 ){ //finche' dalla posizione che ha trovato non arriva alla fine (ultimo nodo)

        coda[i] = coda[i+1]; //shifto verso sx gli elementi successivi a quello rimosso in modo da sovrascriverlo
        i++; //incremento l'indice per continuare a scorrere la coda

      }

      coda[size] = null; //svuoto l'array all'ultima posizione
      size  = size - 1;  //riduco la dimensione totale

      return min;
    }
  }

  public void add( Node n ){

    if( size == maxSize ){  //se la dimensione massima dell'array e' gia' stata raggiunta allora devo aumentarla

      maxSize = maxSize + 1;
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
