package Esercizio2104;

public class Board
{
    private final int size;
    private final int nRegine; //il numero di regine
    private final String config;
    private final IntSList cRighe;
    private final IntSList cColonne; //codifiche delle righe minacciate
    private final IntSList cDiagAsc;
    private final IntSList cDiagDisc;

    private static final String ROWS = "123456789ABCDEF"; //contiene tutte le righe->Alfabeto
    private static final String COLS = "abcdefghijklmno"; //contiene tutte le colonne->Alfabeto

    public Board(int n)
    {
        size = n;
        nRegine = 0;
        config = ""; //stringa vuota perche' non c'e' nessuna coppia di coordinate in cui ci sono regine
        cRighe = IntSList.NULL_INTLIST;
        cColonne = IntSList.NULL_INTLIST;
        cDiagAsc = IntSList.NULL_INTLIST;
        cDiagDisc = IntSList.NULL_INTLIST;

    }

    private Board(int n,int q,String conf,IntSList r, IntSList c, IntSList du, IntSList dd)
    {
        size=n;
        nRegine=q;
        config=conf;
        cRighe = r;
        cColonne = c;
        cDiagAsc = du;
        cDiagDisc = dd;
    }

    public int Size()
    {
        return size;
    }

    public int queensOn()
    {
        return nRegine;
    }

    public boolean underAttack(int i,int j) //controlla se le coordinate inserite sono minacciate
    {
        //controllo
        //controllo diagonali ascendenti -> le diagonali vengono riconosciute da una costante,
        //ovvero la differenza tra ascissa e ordinata, di ciascuna casella di una diagonale x, e' costante
        return underAttackRec(i,j,cRighe,cColonne,cDiagAsc,cDiagDisc);
    }

    private boolean underAttackRec( int i, int j, IntSList r, IntSList c, IntSList du, IntSList dd )
    {
       if( r.isNull())//se una delle liste e' vuota significa che la posizione <i,j> non puo' essere minacciata --> caso base
         return false;
       else if( (r.car() == i) || (c.car() == j) || (du.car() == i-j) || (dd.car() == i+j) ) //controllo se l'indice della posizione che mi sono salvato appartiene a qualche lista di posti "minacciati"
         return true;
       else
         return underAttackRec( i, j, r.cdr(), c.cdr(), du.cdr(), dd.cdr() );

  }

    public String arrangement() //configurazione
    {
        return config;
    }

    public Board addQueen(int i,int j)
    {


        return new Board(
                        size, //la dimensione rimane invariata
                        nRegine+1, //aggiungo una regina
                        config + " "+ COLS.substring(j,j+1) + ROWS.substring(i,i+1) + " ", //aggiungo le nuove coordinate
                        cRighe.cons(i), //aggiorno le varie liste
                        cColonne.cons(j),
                        cDiagAsc.cons(i-j),
                        cDiagDisc.cons(i+j)
                        );
    }
}
