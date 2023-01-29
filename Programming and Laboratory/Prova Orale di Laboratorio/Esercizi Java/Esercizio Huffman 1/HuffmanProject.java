 

import huffman_toolkit.*;
public class HuffmanProject{
  
  private static final int CHARS = InputTextFile.CHARS;
  //PARTE 1
  public static void huffmanCharCode( String src, String dst ){//produce un file con una tabella dei caratteri, codici ASCII e huffman di un file di testo
    
    int[] freq = Huffman.freqHistogram( src );//istogramma delle frequenze dei caratteri del file sorgente
    Node tree = Huffman.huffmanTree( freq );//albero di huffman del file sorgente
    String[] codes = Huffman.codeTable( tree );//codici di huffman dei caratteri del file sorgente
    
    OutputTextFile out = new OutputTextFile( dst );
    
    String head = "Le colonne indicano, in ordine: codice ASCII, carattere, occorrenze, codice di Huffman, lunghezza del codice";
    out.writeTextLine( head );
    
    for( int i=0; i<128; i++ ){
      
      if( freq[i] > 0){//scrive solo i caratteri che effettivamente compaiono nel file
        
        String s = i + "\t" + (char) i + "\t" + freq[i] + "\t" + codes[i] + "\t" + codes[i].length();
        out.writeTextLine( s );
        
        
      }
    }
    
    out.close();
    
  }
  
  //PARTE 2 
  public static void textWrite( String dst, int dim ){//scrive un testo casuale di dimensione (numero di craratteri) dim
    
    OutputTextFile out = new OutputTextFile( dst );
    long r;
    
    for( int i=0; i<dim; i++ ){
      
      r = Math.round( Math.random()*128 );//r e' un numero casuale tra 0 e 127 -> puo' rappresentare un carattere
      out.writeChar( (char) r );
      
    }
    
    out.close();

  }
  
  //PARTE 3 stima delle dimensioni compresse
  public static String dimensioniCompressePreviste(String src)
  {
       int[] freq = Huffman.freqHistogram(src);//istogramma delle frequenze dei caratteri del file sorgente
       Node tree = Huffman.huffmanTree(freq);//albero di huffman del file sorgente
       String[] codes = Huffman.codeTable(tree);//codici di huffman dei caratteri del file sorgente
       String flatTree = Huffman.flattenTree(tree); //codifica dell'albero
       String size = Integer.toString(tree.weight()); //numero di caratteri presenti nel file
       int bits = 0; //counter in bit
       int c = 0;
       
       bits = size.length() + flatTree.length(); //intestazione
       for(int i=0;i<128;i++)
       {
           if(freq[i]>0)
            c+= codes[i].length() * freq[i]; //peso totale di tutti i caratteri
       }
       bits = bits + (c/7); //divido per 7
       
       return "Dimensioni previste: "+bits+" byte";
  }
  
  //La tabella di un file casualmente generato e' piu' uniforme rispetto a quella di un file di testo normale; in particolare le lunghezze dei codici della prima restano
  //attorno alla dimensione del byte
 
  
}//class HuffmanProject
