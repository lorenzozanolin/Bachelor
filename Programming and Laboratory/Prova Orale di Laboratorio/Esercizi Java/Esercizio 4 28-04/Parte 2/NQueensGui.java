import queens.*;

public class NQueensGui{
  
  public static void nQueensSolutions( int n ){//Visualizza tutte le soluzioni del rompicapo con scacchiere di dimensione n
    
    SList<Board> boardL = Queens.listOfAllSolutions( n );//boardL lista di tutte le board che sono soluzioni del rompicapo
    nQueensBoard( boardL );// visualizzazione delle board tramite il metodo nQueensBoard
  }

  private static void nQueensBoard( SList<Board> boardL ) {// Visualizza tutte le board della lista passata come argomento
    
    int size = boardL.car().size(); // tutte le board della lista hanno la stessa dimensione, quindi per sapere la dimensione di tutte basta controllare il primo elemento
    
    ChessboardView gui = new ChessboardView( size );
    
    while( !boardL.isNull() ){// finche' la lista non e' vuota...
      gui.setQueens( boardL.car().toString() );//... visualizza la prima scacchiera nella lista...
      boardL = boardL.cdr();//... e la "scarta", riducendo la dimensione della lista, poi ripete facendo vedere a ogni iterazione la scacchiera successiva 
    }
    
  }
  
  
  
  
}//class NQueensGui