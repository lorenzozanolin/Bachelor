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
  
  private Node[] stk;
  private int size;
  private int maxSize = 100;
  
  public NodeStack(){
   
    size = 0;
    stk = new Node[maxSize];
    
  }
  
  
  public boolean empty(){
   
    return (size == 0);
    
  }
  
  public Node peek(){
   if( size == 0 )
      return null;
   else
    return stk[size-1];
    
  }
  
  public Node pop(){
    if( size == 0 )
      return null;
    else{
      Node top = stk[size-1];
      stk[size-1] = null;
      size = size - 1;
      
      return top;
    }
  }

  
  public void push( Node n){
    
    if( size == maxSize ){
     
      maxSize = maxSize + 10;
      Node[] supp = new Node[maxSize];
      
      for(int i=0; i<size; i++)
        supp[i] = stk[i];
      
      stk = supp;
      
    }
    
    size = size + 1;
    stk[size-1] = n;
    
  }
  
}//class NodeStack