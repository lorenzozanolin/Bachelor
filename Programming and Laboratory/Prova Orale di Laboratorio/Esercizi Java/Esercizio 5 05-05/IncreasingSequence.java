public class IncreasingSequence{
  
  public static int llis( int[] s ) { // s[i] > 0 per i in [0,n-1], dove n = s.length 
    return llisRec( s, 0, 0 );
  }
  
  public static int llisRec( int[] s, int i, int t ) {
    final int n = s.length;
    if( i == n )
      return 0;
    else if( s[i] <= t )
      return llisRec( s, i+1, t );
    else
      return Math.max( 1+llisRec( s, i+1, s[i] ), llisRec( s, i+1, t ) );
  }
  
  
  // Versione top-down con memoization -----------------------------------                  
  public static int llisMem( int[] s ){
    
    int l = s.length;
    int[][] vet = new int[ l+1 ][ l+1 ];// vet matrice l+1 x l+1 in cui il primo paramentro rappresenta la lunghezza della sottosequenza e il secondo e' il massimo trovato finora
    // in particolare il secondo indice "j" permette di trovare il massimo guardando s[j]
    
    for( int i=0; i<=l; i++ ){//inizializzazione della matrice
      for( int k=0; k<=l; k++ ){
      vet[i][k] = UNKNOWN;
      }}
    //v[i][j] rappresenta la lunghezza della sottosequenza crescente che con inizia l'elemento s[i] e ha per elemento massimo s[j]
    
    
    int[] newS = new int[ l+1 ];// l'array newS ha gli stessi elementi di s piu' uno nuovo in coda uguale a 0 (per trattare il caso t=0)
    for( int i=0; i<l; i++ )
      newS[i] = s[i];
    newS[l] = 0;
    
    return llisMemSupp( newS, vet, 0, l );
    
  }
  
  private static final int UNKNOWN = -1;// valore non definito uguale a -1 perche' 0 puo' essere un valore restituito da llis
  
  private static int llisMemSupp( int[] s, int[][] v, int i, int j ){
    
    final int l = s.length - 1;// l e' la lunghezza della sequenza originale
    if( v[i][j] == UNKNOWN){// se v[i][j] non e' ancora stato calcolato lo calcola normalmente e lo registra 
      if( i == l )
        v[i][j] = 0;
      else if( s[i] <= s[j] )
        v[i][j] = llisMemSupp( s, v, i+1, j );
      else
        v[i][j] = Math.max( 1+llisMemSupp( s, v, i+1, i ), llisMemSupp( s, v, i+1, j ) );
    }
    return v[i][j];
  }
  
 //-------------------------------------------------------------------------------------- 
  
  
  public static IntSList lis( int[] s ){//val: lista contenente la sottosequenza crescente piu' lunga
    
    int l = s.length;
    IntSList[][] vet = new IntSList[ l+1 ][ l+1 ];
    
    for( int i=0; i<=l; i++ ){//inizializzazione della matrice
      for( int k=0; k<=l; k++ ){
      vet[i][k] = NULL_INTLIST;
      }}
    
    int[] newS = new int[ l+1 ];// l'array newS ha gli stessi elementi di s piu' uno nuovo in coda uguale a 0 (per trattare il caso t=0)
    for( int i=0; i<l; i++ )
      newS[i] = s[i];
    newS[l] = 0;
    
    return lisRec( newS, vet, 0, l );
    
  }
  
  private static final IntSList NULL_INTLIST = new IntSList();
    
  private static IntSList lisRec( int[] s, IntSList[][] m, int i, int j ){
    
    final int l = s.length - 1;// l e' la lunghezza della sequenza originale
    if( m[i][j] == NULL_INTLIST){// se v[i][j] non e' ancora stato calcolato lo calcola normalmente 
      if( i == l )
        m[i][j] = NULL_INTLIST;
      else if( s[i] <= s[j] )
        m[i][j] = lisRec( s, m, i+1, j );
      else{
        IntSList sl1 = lisRec( s, m, i+1, i ).cons( s[i] );
        IntSList sl2 = lisRec( s, m, i+1, j );
        if( sl1.length() < sl2.length() )//calcolo della lista con piu' elementi
          m[i][j] = sl2;
        else if( sl1.length() > sl2.length() )
          m[i][j] = sl1;
        else{
          double rand = Math.random();
          if( rand <= 0.5 )
            m[i][j] = sl1;
          else
            m[i][j] = sl2;
        }
      }
    }
    return m[i][j];  
  }
  
  
 //--------------------------------- 
  
  
  public static int llis2( int[] s ){// Conta quanti elementi della matrice vengono utilizzati
    
    int l = s.length;
    int[][] vet = new int[ l+1 ][ l+1 ];// vet matrice l+1 x l+1 in cui il primo paramentro rappresenta la lunghezza della sottosequenza e il secondo e' il massimo trovato finora
    // in particolare il secondo indice "j" permette di trovare il massimo guardando s[j]
    
    for( int i=0; i<=l; i++ ){//inizializzazione della matrice
      for( int k=0; k<=l; k++ ){
      vet[i][k] = UNKNOWN;
      }}
    vet[0][0] = 0; //vet[0][0] viene usato come contatore per registrare quante componenti dell'array sono state modificate; vet[0][0] infatti non viene mai utilizzato durante la ricorsione
    //v[i][j] rappresenta la lunghezza della sottosequenza crescente che con l'elemento s[i] e ha per elemento massimo v[j]
    
    
    int[] newS = new int[ l+1 ];// l'array newS ha gli stessi elementi di s piu' uno nuovo in coda uguale a 0 (per trattare il caso t=0)
    for( int i=0; i<l; i++ )
      newS[i] = s[i];
    newS[l] = 0;
    
    return llisRec2( newS, vet, 0, l );
    
  }
  
  private static int llisRec2( int[] s, int[][] v, int i, int j ){
    
    final int l = s.length - 1;// l e' la lunghezza della sequenza originale
    if( v[i][j] == UNKNOWN){// se v[i][j] non e' ancora stato calcolato lo calcola normalmente 
      if( i == l ){
        v[i][j] = 0;
        v[0][0]++;
      }
      else if( s[i] <= s[j] ){
        v[i][j] = llisRec2( s, v, i+1, j );
        v[0][0]++;
      }
      else{
        v[i][j] = Math.max( 1+llisRec2( s, v, i+1, i ), llisRec2( s, v, i+1, j ) );
        v[0][0]++;
      }
    }
    
    if( (i == 0) && (j==l) )
      
      System.out.println( v[0][0] );// vengono riempite l*(l+1)/2 celle perche' la ricorsione segue una struttura a "piramide" (l = n+1)
      //in particolare e' simile a una matrice triangolare
      //Per visualizzare la matrice: 
      //import java.util.Arrays;
      //System.out.println(Arrays.deepToString(v));
    return v[i][j];
  }
  
  
  
  
  
  public static long test(){// test efficienza
     
    int i;
    int[] s = new int[ 30 ];
    
    for( int k=0; k<30; k++ )
      s[k] = k+1;
    
    long t0 = System.currentTimeMillis();
    
    i = llis(s);
      
    long t1 = System.currentTimeMillis();
    System.out.println( t1 - t0 );
    
    i = llisMem(s);
    
    long t2 = System.currentTimeMillis();
    System.out.println( t2 - t1 );
    
    return i;
    
  }
  
}//class IncreasingSequence
