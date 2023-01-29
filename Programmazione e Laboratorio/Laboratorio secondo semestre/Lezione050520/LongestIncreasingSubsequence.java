package Lezione050520;


public class LongestIncreasingSubsequence
{   
    private static final int UNKNOWN = 0;
    //calcola la lunghezza della più lunga sottosequenza di s strettamente crescente
    //imponendo l’ulteriore vincolo che gli elementi della sottosequenza debbano essere strettamente maggiori del valore di un terzo parametro t
    //versione ricorsiva non efficiente
    
    public static int llis( int[] s ) // s[i] > 0 per i in [0,n-1], dove n = s.length
    { 
       return llisRec( s, 0, 0 );
    }


    private static int llisRec( int[] s, int i, int t ) 
    {
       final int n = s.length;
       
       if ( i == n ) //caso base, in cui ha finito lo scorrimento
       {
         return 0;
       } 
       else if ( s[i] <= t ) //se il numero contenuto e' minore del vincolo
       {
         return llisRec( s, i+1, t );
       } 
       else 
       {
         return Math.max( 1+llisRec(s,i+1,s[i]), llisRec(s,i+1,t) );
       }
    }
    
    //PARTE 1
    
    public static int llisMem( int[] s ) //versione che utilizza memoization (top-down) //sto modificando il vettore, ovvero lo 0 e' in ultima posizione e quindi gli indici tornano conformi
    {
       int l = s.length;
       int[][] mat = new int[ l+1 ][ l+1 ]; // vet matrice l+1 x l+1 in cui il primo paramentro rappresenta la lunghezza della sottosequenza e il secondo e' il massimo trovato finora
        
       for( int i=0; i<=l; i++ ) ///questa e' la matrice con le corrispondenti intersezioni tra numero(da aggiungere) ed estremo corrente
       {
         for(int j=0;j<=l;j++)
         {
             mat[i][j] = -1; //con -1 intendo che la matrice non e' stata scritta
         }
         
       }
       
       int[] newS = new int[ l+1 ]; //vettore che contiene i limiti (per aggiungerci lo 0 DAVANTI, quindi tute le i sono shiftate)
       
       for( int i=0; i<l; i++ )
       {
         newS[i] = s[i]; //shifto in avanti di 1 gli elementi del vecchio vettore perche' devo aggiungerci lo 0
       }
       
       newS[l]=0; //ora il primo vettore contiene lo 0
        
       return llisMemRec( newS, mat, 0, l); //indici i e j (i parte da l perche' vale 0)
    
    }
    
    private static int llisMemRec( int[] v, int[][] h, int i, int j ) //i e j sono gli indici che considerano i numeri
    {
       if(h[i][j] == -1) //se la posizione corrente nella matrice non e' ancora stata esplorata...
       {
           if(i == v.length-1) //quando non ha piu numeri nella lista(degli elementi dati in input) e vuol dire che non puo piu scendere verso il basso nella matrice, ovvero arriva alla posizione della lista che contiene 0
               h[i][j] = 0;
           else if(v[i]<=v[j]) //se il nuovo numero e' minore o uguale dell'estremo corrente (ovvero il numero precedentemente inserito)
                h[i][j] = llisMemRec(v,h,i+1,j); //mi sposto in verticale (verso il basso) nella matrice delle corrispondenze
                
           else  //se il nuovo numero e' maggiore del limite precedente
                h[i][j] = Math.max( 1+llisMemRec(v, h, i+1, i), llisMemRec( v, h, i+1, j)); //gli cambia i nuovi parametri e si sposta sia diagonalmente verso il basso(sx->dx) e sia verso il basso verticalmente
       }
       
       return h[i][j];
    }
    
    //PARTE 2
    public static IntSList lis(int []s) // determinare una sottosequenza crescente più lunga
    {
       int l = s.length;
       IntSList[][] mat = new IntSList[ l+1 ][ l+1 ]; // vet matrice l+1 x l+1 in cui il primo paramentro rappresenta la lunghezza della sottosequenza e il secondo e' il massimo trovato finora
       
       for( int i=0; i<=l; i++ ) ///questa e' la matrice con le corrispondenti intersezioni tra numero(da aggiungere) ed estremo corrente
       {
         for(int j=0;j<=l;j++)
         {
             mat[i][j] = listaNulla; //con listaNulla intendo che la matrice non e' stata scritta
         }
         
       }
       
       int[] newS = new int[ l+1 ]; //vettore che contiene i limiti (per aggiungerci lo 0 DAVANTI, quindi tute le i sono shiftate)
       
       for( int i=0; i<l; i++ )
       {
         newS[i] = s[i]; //shifto in avanti di 1 gli elementi del vecchio vettore perche' devo aggiungerci lo 0
       }
       
       newS[l]=0; //ora il primo vettore contiene lo 0
        
       return lisRec( newS, mat, 0, l); //indici i e j (i parte da l perche' vale 0)
    }
    
    private final static IntSList listaNulla = new IntSList();
    
    private static IntSList lisRec(int[]v,IntSList[][]mat,int i,int j)
    {
       if(mat[i][j] == listaNulla) //se la posizione corrente nella matrice non e' ancora stata esplorata...
       {
           if(i == v.length-1) //quando non ha piu numeri nella lista e vuol dire che non puo piu scendere verso il basso nella matrice, ovvero arriva alla posizione della lista che contiene 0
               mat[i][j] = listaNulla;
           else if(v[i]<=v[j]) //se il nuovo numero e' minore o uguale dell'estremo corrente (ovvero il numero precedentemente inserito)
               mat[i][j] = lisRec(v,mat,i+1,j); //mi sposto in verticale (verso il basso) nella matrice delle corrispondenze
                 
           else  //se il nuovo numero e' maggiore del limite precedente
                mat[i][j] = Better(new IntSList(v[i],lisRec(v, mat, i+1, i)),lisRec(v, mat, i+1, j)); //gli cambia i nuovi parametri e si sposta sia diagonalmente verso il basso(sx->dx) e sia verso il basso verticalmente
       }
       
       return mat[i][j];
    }
    
    private static IntSList Better(IntSList s1, IntSList s2) //confronta la lunghezza delle due liste
    {
        int l1=s1.length();
        int l2=s2.length();
        
        if(l1<l2)
            return s2;
        else if(l2<l1)
            return s1;
        else //nel caso fossero uguali
            return s2;
    }
    
    //PARTE 3
    public static int llisCounter( int[] s ) //conta quante volte viene utilizzata la memoization, ovvero quante volte vengono riutilizzati i dati calcolati
    {
       int l = s.length;
       int[][] mat = new int[ l+1 ][ l+1 ]; // vet matrice l+1 x l+1 in cui il primo paramentro rappresenta la lunghezza della sottosequenza e il secondo e' il massimo trovato finora
        
       for( int i=0; i<=l; i++ ) ///questa e' la matrice con le corrispondenti intersezioni tra numero(da aggiungere) ed estremo corrente
       {
         for(int j=0;j<=l;j++)
         {
             mat[i][j] = -1; //con -1 intendo che la matrice non e' stata scritta
         }
         
       }
       
       int[] newS = new int[ l+1 ]; //vettore che contiene i limiti (per aggiungerci lo 0 DAVANTI, quindi tute le i sono shiftate)
       
       for( int i=0; i<l; i++ )
       {
         newS[i] = s[i]; //shifto in avanti di 1 gli elementi del vecchio vettore perche' devo aggiungerci lo 0
       }
       
       newS[l]=0; //ora il primo vettore contiene lo 0
       int c= 0; //contatore
       int lun= llisMemRec2( newS, mat, 0, l,c);
       return c;
    
    }
    
    private static int llisMemRec2( int[] v, int[][] h, int i, int j,int c) //i e j sono gli indici che considerano i numeri
    {
       if(h[i][j] == -1) //se la posizione corrente nella matrice non e' ancora stata esplorata...
       {
           if(i == v.length-1) //quando non ha piu numeri nella lista(degli elementi dati in input) e vuol dire che non puo piu scendere verso il basso nella matrice, ovvero arriva alla posizione della lista che contiene 0
               h[i][j] = 0;
           else if(v[i]<=v[j]) //se il nuovo numero e' minore o uguale dell'estremo corrente (ovvero il numero precedentemente inserito)
                h[i][j] = llisMemRec2(v,h,i+1,j,c+1); //mi sposto in verticale (verso il basso) nella matrice delle corrispondenze
                
           else  //se il nuovo numero e' maggiore del limite precedente
                h[i][j] = Math.max( 1+llisMemRec2(v, h, i+1, i,c+1), llisMemRec2( v, h, i+1, j,c+1)); //gli cambia i nuovi parametri e si sposta sia diagonalmente verso il basso(sx->dx) e sia verso il basso verticalmente
       }
       return h[i][j];
    }
}
