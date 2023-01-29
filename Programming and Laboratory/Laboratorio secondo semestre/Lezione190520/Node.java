package Lezione190520;

public class Node implements Comparable<Node>
{
    private char character;
    private int weight;
    private Node left;
    private Node right;
    
    public Node(char chr,int wgt)
    {
        character = chr;
        weight = wgt;
        left = null;
        right = null;
    }
    
    public Node(Node lft, Node rgt)
    {
        character= (char) 0; //prima posizione nel codice ascii
        weight = lft.weight() + rgt.weight();
        left = lft;
        right = rgt;
    }
    
    public boolean isLeaf()
    {
        return (left == null);
    }
    
    public int weight()
    {
        return weight;
    }
    
    public Node left()
    {
        return left();
    }
    
    public Node right()
    {
        return right();
    }
    
    public char character()
    {
        return character;
    }
    
    
    public int compareTo(Node n) //confronta i nodi e vede chi e' tra i due il nodo piu piccolo
    {
        //-1 se il nodo ha minor peso di n
        //0  se il nodo ha stesso peso di n
        //1  se il nodo ha maggior peso di n
        if(weight< n.weight())
            return -1;
        else if (weight == n.weight())
            return 0;
        else
            return 1;
    }
}        // metti qui il tuo codice
