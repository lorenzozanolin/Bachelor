package Lezione190520;
import huffman_toolkit.*;
import java.util.*;

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
 *< / :1+2=3, C:3, T:6 >
 * G   A
 * 
 *<   / :3+3=6, T:6 >
 *  / \  C
 * G   A
 * 
 * < /  :6+6=12 >
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

public class Huffman
{
    private static final int CHARS = InputTextFile.CHARS; //codici da 0 a 127--> quindi vale 128
    //dato un nome del file di testo, esso lo apre 
    //e dice quante occorrenze ci sono in questo file di testo per ogni carattere
    
    //esercizio 1
    public static void Occorrenze(String src,String dst)
    {
        int[] occorrenze = freqHistogram(src); //vettore delle occorrenze
        Node albero = huffmanTree(occorrenze); //si costruisce l'albero di huffman
        String[] codifiche = codeTable(albero); // si costruisce il vettore che contiene i codici di huffman di ciascun carattere
        
        InputTextFile in = new InputTextFile(src);
        OutputTextFile out = new OutputTextFile(dst);
                
        String riga="";
        
        for(int i=0;i<CHARS;i++)
        {   
            if(occorrenze[i] !=0) //controllo che serve per evitare errori quando calcola la lunghezza di una codifica null
                riga = i +" "+ (char) i +" "+ occorrenze[i] +" "+ codifiche[i] +" "+ codifiche[i].length();//si crea per ogni riga il testo da inserire
                
            out.writeTextLine(riga);
            riga = "";
        }
        
         
        in.close();
        out.close();
        
    }
    
    //esercizio 2
    private static void CreaRandom(String src,String dst) //mi creo un file random
    {
        int[] freq = freqHistogram(src); //istogramma delle occorrenze..serve per contare quanti caratteri ha il primo file da confrontare
        //dato che quello random deve avere la stessa dimensione, quindi deve avere lo stesso numero di caratteri
        
        int size=0;
        
        for(int i=0;i<freq.length;i++) //per ciascun carattere conto quante occorrenze ci sono
        {
            size = size + freq[i];
        }
        //ora size contiene il numero totale di occorrenze
        
        OutputTextFile out = new OutputTextFile( dst );
        Random r = new Random(); //numero che mi serve per generare per ogni carattere quante volte dovra' comparire
          
        for( int i=0; i<size; i++ ) //ora mi creo il file random, finche size non e' a zero, ovvero finche' ho caratteri da aggiungere per arrivare allo stesso num dell'altro file
        {
            int pos = r.nextInt(128); //codifica del char da inserire --> intervallo 0-127
            char c = (char) pos; //si recupera il carattere
            out.writeChar(c);//scrive il carattere nel file
            size--; //decrementa il numero di carattere che mancano da scrivere
      
        }
        
        out.close();
        
    }
    
    public static void Confronto(String file1, String file2, String oc1, String oc2) //confronta utilizzando la funzione Occorrenze applicata sui due file diversi..quello huffman.java e quello random
    {
        Occorrenze(file1, oc1); //va a scrivere nel file oc1 tutto il numero di occorrenze del file1
        Occorrenze(file2, oc2);
    }
    
    //manca l'es 3
    public static int[] freqHistogram( String src ) // "istogramma" delle occorrenze dei caratteri
    {
        
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
  
      public static Node huffmanTree( int[] freq ){
      
        PriorityQueue<Node> q = new PriorityQueue<Node>();
        
        for( int i=0; i<CHARS; i++){
          if( freq[i] > 0 ){
            
            Node n = new Node( (char) i, freq[i] );
            q.add( n );
            
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
      
      public static String[] codeTable( Node root ){
       
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
      
      int[] freq = freqHistogram( src );
      Node root = huffmanTree( freq );
      String[] codes = codeTable( root );
      
      int size = root.weight();//numero di caratteri
      String ht = flattenTree( root );
      
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
    
}
