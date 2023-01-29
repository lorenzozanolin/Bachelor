/*
 * Protocollo della classe NodeStack:
 *
 * NodeStack ns = new NodeStack()  //costruttore generico, nuovo stack di nodi
 *
 * ns.empty()        :   boolean     //verifica se lo stack e' vuoto
 *
 * ns.peek()           :   Node    //restituisce l'elemento in cima allo stack (senza rimuoverlo)
 *
 * ns.pop()            :   Node    //restituisce e rimuove l'elemento in cima allo stack
 *
 * ns.push( Node n )   :   void    //aggiunge un nodo in cima allo stack
 *
*/

public class NodeStack{

  private Node[] stk; // stack
  private int size; //size e' la posizione dell'ultimo elemento inserito, ovvero la size TEMPORANEA maxSize = 128;

  public NodeStack(){

    size = 0;
    stk = new Node[size];

  }


  public boolean empty(){

    return (size == 0);

  }

  public Node peek(){ //ritorna l'elemento salvato in ultima posizione(cima dello stack)
   if( size == 0 )
      return null;
   else
    return stk[size-1]; //non lo rimuove

  }

  public Node pop(){ //ritorna e rimuove l'elemento in cima (ovvero l'ultimo)
    if( size == 0 )
      return null;
    else{
      Node top = stk[size-1];
      stk[size-1] = null;
      size = size - 1; //decrementa la dimensione temporanea

      return top;
    }
  }


  public void push( Node n){

      Node[] supp = new Node[size+1]; //array di supporto

      for(int i=0; i<size; i++) //mi copio il vecchio array in quello di supporto
        supp[i] = stk[i];

      stk = supp; //associo il vecchio array a quello nuovo (1 cella in piu)
      stk[size] = n; //inserisce l'ultimo nodo nell'ultima posizione

      size = size + 1; //modifica la nuova dimensione

  }

}//class NodeStack
