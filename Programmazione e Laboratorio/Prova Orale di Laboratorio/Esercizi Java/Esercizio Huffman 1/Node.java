 

/*
 * Node n = new Node( c, w ); // c carattere, w peso
 * 
 * Node p = new Node( l, r );// nuovo albero a partire da due sottoalberi l e r
 * 
 * Node q;
 * 
 * q.isLeaf() : boolean
 * 
 * q.character() : char
 * q.weight() : int
 * 
 * q.left() : Node
 * q.right() : Node
 * 
 */
public class Node implements Comparable<Node>{//la classe Node implementa la comparazione (gli oggetti node sono comparabili)
  
  private final char character;
  private final int weight;
  private final Node left;
  private final Node right;
  
  
  public Node( char chr, int wgt ){
    
    character = chr;
    weight = wgt;
    left = null;
    right = null;
    
  }
  
  public Node( Node lft, Node rgt ){
    
    character = (char) 0;
    weight = lft.weight() + rgt.weight();
    left = lft;
    right = rgt;
     
  }
  
  public boolean isLeaf(){
    
    return ( left == null );
    
  }
  
  public char character(){
    
    return character;
    
  }
  
  public int weight(){
    
    return weight;
    
  }
  
  public Node left(){
    
    return left;
    
  }
  
  public Node right(){
    
    return right;
    
  }
  
  public int  compareTo( Node n  ){
    
    if( weight < n.weight() )
      return -1;
    else if( weight > n.weight )
      return 1;
    else 
      return 0;
      
      
  }
  
}//class Node