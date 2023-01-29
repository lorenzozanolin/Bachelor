 

// Codifica di Huffman

/*Codifica utilizzata per comprimere i file di testo
 * 
 * Es: sequenza di 12 basi nucleiche:
 * A T T C T A C C T T G T
 * 
 * Codifica binaria standard (tipo ASCII): due bit per distinguere tra quattro simboli:
 * A 00
 * T 01
 * C 10
 * G 11
 * 
 * Rappresentazione della sequenza: 2x12 = 24 bit
 * 
 * 0 0 0 1 0 1 1 0 0 1 0 0 1 0 1 0 0 1 0 1 1 1 0 1
 * 
 * 
 * Concetto di "Peso" dei simboli = numero di occorrenze (frequenza) coppie simbolo/peso ordinate per peso crescente:
 * 
 * < G:1, A:2, C:3, T:6 > ----> Il peso dipende da quante volte il carattere compare
 * 
 * 
 * Costruzione dell'albero di Huffman: aggregazione dei 2 elementi di minor peso e riordinamento (per mantenere l'ordine crescente):
 *< / \:1+2=3, C:3, T:6 >
 * G   A
 * 
 *<   / \:3+3=6, T:6 >
 *  / \  C
 * G   A
 * 
 * < /  \:6+6=12 >
 *  / \   T
 * / \  C
 * G  A
 * 
 * In questo albero i simboli con frequenze piu' elevate stanno piu' vicini alla radice
 * Dato che l'albero e' binario si puo' definire un percorso per raggiungere un carattere: destra, sinistra, destra destra ecc
 * Inoltre possiamo associare un bit alla direzione: 0 sinistra, 1 destra
 * 
 * Quindi si puo' rifare la tabella che associa dei bit al carattere:
 * 
 * A 001    (sinistra, sinistra, destra)
 * T   1    (destra)
 * C  01    (sinistra, destra)
 * G 000    (sinistra, sinistra, sinistra)
 * 
 * Nuova rappresentazione della sequenza (compressa):
 * 
 * A   T T C   T A    C   C   T T  G   T
 * 001 1 1 01  1 001  01  01  1 1  000 1  ----> 21 bit (3 bit in meno 12%)
 * 
 * La decodifica avviene seguendo i bit come istruzioni per scendere attraverso l'albero e ricavare in questo modo il carattere
 * (Si seguono i bit finche' non si arriva a una foglia, quindi non si possono confondere i caratteri)
 * 
 */
import huffman_toolkit.*;
import java.util.*;

public class Huffman{
  
  private static final int CHARS = InputTextFile.CHARS;
  public static int[] freqHistogram( String src ){// --> PER OGNI CARATTERE SI SALVA (NELLA POSIZIONE DELLA SUA CODIFICA) QUANTE VOLTE COMPARE
    
    int[] freq = new int[ CHARS ];
    
    for( int i=0; i<CHARS; i++ )
      freq[i] = 0;
    
    InputTextFile in = new InputTextFile( src );
    
    while( in.textAvailable() ){
      
      char c = in.readChar();
      freq[c]++;
      
    }
    in.close();
    
    return freq;
    
  }
  
  public static Node huffmanTree( int[] freq ){ //--> si crea l'albero partendo dai singoli nodi
  
    PriorityQueue<Node> q = new PriorityQueue<Node>(); //usa una priorityQueue
    
    for( int i=0; i<CHARS; i++){
      if( freq[i] > 0 ){
        
        Node n = new Node( (char) i, freq[i] ); //per ogni carattere si prende un nodo e gli associa come peso il # di volte che compare
        q.add( n ); //lo aggiunge alla coda 
        
      }
    }
    
    while( q.size() > 1 ) {
     
      Node l = q.poll();//poll estrae l'elemento piu' in "avanti"
      Node r = q.poll();
      Node n = new Node( l, r );
      
      q.add( n );
    }
    return q.poll();//devo estrarre l'elemento rimanente perche' e' un node e q e' un poll
  }
  
  public static String[] codeTable( Node root ){ //--> CREA LA CODIFICA PER ACCEDERE AD UN SINGOLO CARATTERE, es. A -> 001
   
    String[] codes = new String[ CHARS ];
    
    fillTable( root, "", codes );
    
    return codes;
    
  }
  
  public static void fillTable( Node n, String pre, String[] codes ){
    
    if( n.isLeaf() ){
      char c = n.character();
      codes[c] = pre;
    }
    else{
      fillTable( n.left(), pre+"0", codes );
      fillTable( n.right(), pre+"1", codes );
    }
    
  }
  
/*Per poter decomprimere e interpretare un file codificato con Huffman bisogna aggiungere l'intestazione, che comprende:
 *Dimensione del file
 * Codifica dell'albero di Huffman
 * 
 * Codifica dell'albero:
 * @ nodo intermedio
 * Carattere per rappresentare una foglia
 * 
 * Dato che l'albero e' binario non abbiamo bisogno di altro
 * 
 * Es:
 * < /  \:6+6=12 >
 *  / \   T
 * / \  C
 * G  A
 * Diventa
 * @@@GACT
 * 
 * Per chiarezza:
 * {@[@(@GA)C]T}
 * 
 * In un albero binario si hanno n foglie e n-1 nodi interni
 */
  
  public static String flattenTree( Node n ){//"Appiattisce l'albero"
    
    if( n.isLeaf() ){
      
      if( (n.character() == '@') || ( n.character() == '\\'))//Problema: come facciamo a sapere che la @ non fa parte del documento?
        //--> si usa un carattere di controllo \ --> \@
        //Adesso pero' bisogna fare lo stesso controllo con il \
        return "\\" + n.character();
      else
        return "" + n.character();
      
    }
    else{
      
      return "@" +  flattenTree( n.left() ) + flattenTree( n.right() );
      
    }
  }
    
    //Creazione del file compresso
    public static void compress( String src, String dst ){
      
      int[] freq = freqHistogram( src ); //si crea il vettore delle occorrenze
      Node root = huffmanTree( freq );  //si crea l'albero
      String[] codes = codeTable( root ); //per ogni carattere si crea la codifica
      
      int size = root.weight();//numero di caratteri
      String ht = flattenTree( root ); //si crea la codifica dell'albero 
      
      InputTextFile in = new InputTextFile( src );
      OutputTextFile out = new OutputTextFile( dst );
      
      out.writeTextLine( "" + size );//intestazione: dimensione dell'albero
      out.writeTextLine( ht );// codifica dell'albero
      
      for( int i=0; i<size; i++ ){//scrittura del file compresso
       
        char c = in.readChar();
        out.writeCode( codes[c] );//writeCode interpreta una sequenza di 0 e 1 e le scrive come sequenza di bit
        
        
      }
      
      in.close();
      out.close();
      
    }
    
    /*Questa tecnica puo' essere applicata soltanto una volta perche' ad applicazioni successive le dimensioni del file aumentano
     *Questo dipende da come i bit (gia' compressi una volta) vanno a inserirsi nei byte --> implica che il testo viene codificato circa nello stesso modo ma bisogna codificare
     *anche l'intestazione --> questo porta ad occupare piu' spazio
     */
    
  
}//class Huffman
