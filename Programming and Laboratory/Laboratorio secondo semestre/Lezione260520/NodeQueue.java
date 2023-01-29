package Lezione260520;


/*
 * public NodeQueue() costruttore: creazione della coda vuota
 * public int size() restituisce il numero di elementi contenuti nella coda
 * public Node peek() restituisce l’elemento con “peso minore” (senza rimuoverlo dalla coda)
 * public Node poll() restituisce e rimuove dalla coda l’elemento con “peso minore”
 * public void add( Node n ) aggiunge un nuovo elemento n alla coda

 */
public class NodeQueue
{
    private static int size;
    private static Node[] array;
    
    public NodeQueue()
    {
        size = 0;
        array = new Node[0];
    }
    
    public static int Size()
    {
        return size;
    }
    
    public static Node Peek()
    {
        Node n;
        n = array[RicercaMin()]; //trova il nodo con peso minimo
        
        return n;
    }
    
    private static int RicercaMin() //ricerca l'elemento con peso minore
    {
        int weight = 1000000; //peso massimo
        int pos = -1;
        
        for(int i=0;i<size;i++)
        {
            if(array[i].weight() < weight)
                pos = i;
        }
        
        return pos;
    }
    
}
