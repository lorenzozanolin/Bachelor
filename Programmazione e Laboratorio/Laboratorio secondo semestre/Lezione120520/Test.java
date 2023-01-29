package Lezione120520;
import puzzleboard.*;

public class Test
{
    public static void Gioca(int n)
    {
        PuzzleBoardC b = new PuzzleBoardC(n); //si crea una matrice randomizzata di n valori
        PuzzleBoard gui = new PuzzleBoard(n); //si crea una matrice grafica di n valori
        
        //adesso bisogna associare b a gui
        AssociaMatrice(b,gui);
        gui.display(); //mostra la matrice grafica
        
        while(true) //loop infinito
        {
            int k=gui.get(); //aspetta il click del mouse su un tassello e restituisce il valore del tassello
            SpostaPedina(b,gui,k);
            gui.display();
        }
    }
    
    private static void AssociaMatrice(PuzzleBoardC b,PuzzleBoard gui) //metodo per associare ogni valore della matrice non grafica a quella grafica
    {
        for(int i=1;i<=b.lenght();i++) //gli indici nella matrice grafica partono da 1, quelli nella PuzzleBoardC partono da 0
        {
            for(int j=1;j<=b.lenght();j++)
            {
                gui.setNumber(i,j,b.ValorePedina(i-1,j-1)); //setta i valori corrispondenti nella matrice grafica
            }
        }        
    }
    
    private static void SpostaPedina(PuzzleBoardC b,PuzzleBoard gui,int k)
    {
        int[] cOld= CercaCoordinate(b,k); //vettore che contiene le coordinate della pedina da spostare
         //cerca le coordinate del numero nella matrice associata, quindi le coordinate sono -1 rispetto a quelle della grafica
        
        b.SpostaTassello(cOld[0],cOld[1]); //aggiorno la pedina nella matrice non grafica e azzera il tassello iniziale
        //ora faccio la stessa cosa nella matrice grafica
        
        AssociaMatrice(b,gui); //riassocio le matrici per salvare i dati cambiati
        int[] cVuoto= CercaCoordinate(b,-1); //cerca le coordinate del tassello "vuoto", nella matrice non grafica
        gui.clear(cVuoto[0]+1,cVuoto[1]+1); //elimina la coordinata corrispondente
        
    }
    
    private static int[] CercaCoordinate(PuzzleBoardC b,int k) //cerca le coordinate di un tassello dato il suo valore
    { //da errore nella ricerca delle coordinate
        int[] c = new int[2];  //vettore che contiene le coordinate della pedina da spostare
        for(int i=0;i<b.lenght();i++) //cerco le coordinate
        {
            for(int j=0;j<b.lenght();j++)
            {
                if(b.ValorePedina(i,j) == k) //se la pedina alla posizione i,j e' quella cercata allora mi salvo le coordinate
                    {
                        c[0] = i;
                        c[1] = j;
                    }
            }
        } 
        return c;
    }
    
}
