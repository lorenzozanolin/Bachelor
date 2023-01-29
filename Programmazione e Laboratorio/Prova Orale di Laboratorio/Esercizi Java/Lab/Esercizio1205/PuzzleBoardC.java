package Esercizio1205; //versione non grafica della classe PuzzleBoard--> si colleghera' ad essa
import java.util.Random; 
/* protocollo appropriato, che comprenda:
• Un costruttore per istanziare un modello della tavoletta;
• Un metodo per verificare se i tasselli sono ordinati;
• Un metodo per verificare se un dato tassello può essere spostato;
• Un metodo per mostrare in forma testuale (stringa) la configurazione;
• Un metodo per spostare un dato tassello.
*/
public class PuzzleBoardC
{
    private static final int VUOTO = -1; //indica che la casella e' vuota
    private static int mat[][]; //matrice che contiene i tasselli ->static e' condiviso da tutti
    private static int l = 0; //dimensione della matrice
    
    public PuzzleBoardC(int n) // costruttore per istanziare un modello della tavoletta
    {
        mat=new int[n][n];
        l=n;
        CreaOrdinata();
    }
    
    public static boolean InOrder() // metodo per verificare se i tasselli sono ordinati
    {
        int c=1; //contatore per verificare se tutti i tasselli sono ordinati
        for(int i=0;i<l;i++)
        {
            for(int j=0;j<l;j++)
            {
                if(mat[i][j] == c) //se la riga selezionata non contiene i numeri ordinati
                    c++;
                else
                    return false;
            }
        }
        return true;
    }
    
    private static void SettaPedina(int i,int j,int num) //setta alle coordinate ij il numero num
    {
        mat[i][j] = num;
    }
    
    private static void AzzeraPedina(int i,int j) //azzera alle coordinate ij il numero num
    {
        mat[i][j] = VUOTO;
    }
    
    private static void CreaOrdinata() //crea una matrice ordinata
    {
        int c=1; //valore della prima pedina
        for(int i=0;i<l;i++)
        {
            for(int j=0;j<l;j++)
            {
                SettaPedina(i,j,c); //ogni volta si crea una nuova pedina assegnandole il numero del counter
                c++; //incrementa il counter
            }
        }
        
        mat[l-1][l-1]=VUOTO; //all'ultima posizione lo azzera per avere lo spazio vuoto
        
        CreaCasuale(); //una volta creata ordinata, mischia le caselle
    }
    
    private static void CreaCasuale() //data la matrice ordinata lui la randomizza
    {
        Random r = new Random();
        int low = 1;
        int high = l;
        
        for(int i=0;i<l;i++)
        {
            int i1 = r.nextInt(high-low) + low; //prima riga casuale
            int j1 = r.nextInt(high-low) + low; //prima colonna casuale
            
            int i2 = r.nextInt(high-low) + low; //seconda riga casuale
            int j2 = r.nextInt(high-low) + low; //seconda colonna casuale
            
            int x=mat[i2][j2]; //salvo il valore della seconda
            SettaPedina(i2,j2,mat[i1][j1]); //setta in posizione i2,j2 il valore mat[i1][j1]
            SettaPedina(i1,j1,x);
        }
               
    }
    
    private static int CercaDirezione(int i,int j) //ritorna la direzione di spostamento(ovvero trova dov'e' la casella vuota)
    {
        //per evitare problemi agli estremi sono stati aggiunti dei vincoli in modo che non vada in out of bounds
        
            if(j!=l-1 && mat[i][j+1] == VUOTO) //dx
               return 1;
            else if(j!=0 && mat[i][j-1] == VUOTO) //sx
               return 2;
            else if(i!=l-1 && mat[i+1][j] == VUOTO) //dwn
               return 3;
            else if(i!=0 && mat[i-1][j] == VUOTO) //up
               return 4;
            else
               return 0; //non c'e' nessun tassello disponibile
        
        
    }
    
    public static void SpostaTassello(int i,int j)
    {
        int dir = CercaDirezione(i,j); //direzione dello spostamento possibile (autoseleziona)
        
        if(dir == 0) //se non ha spazi vuoti nei posti adiacenti
            return; //esci dalla funzione senza fare niente
        
        switch(dir) //direzione: 1dx 2sx 3down 4up
        {
           case 1: SettaPedina(i,j+1,mat[i][j]);
                   break;
           case 2: SettaPedina(i,j-1,mat[i][j]);
                   break;
           case 3: SettaPedina(i+1,j,mat[i][j]);
                   break;
           case 4: SettaPedina(i-1,j,mat[i][j]);
                   break; 
        }
        AzzeraPedina(i,j); //azzero la pedina in cui devo eliminarlo
    }
    
    public static String PrintConfig()
    {
        String s=" ";
        for(int i=0;i<l;i++)
        {
            for(int j=0;j<l;j++)
            {
                s=s+mat[i][j]+" ";
            }
            s= s + "|||"; //vado a capo
        }
        return s;
    }
    
    public static int lenght()
    {
        return l;
    }
    
    public static int ValorePedina(int i,int j) //ritorna il valore della pedina in posizione i,j
    {
        return mat[i][j];
    }
    
}
