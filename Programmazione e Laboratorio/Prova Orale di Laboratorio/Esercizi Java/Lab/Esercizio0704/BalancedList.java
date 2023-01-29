package Esercizio0704;

public class BalancedList
{ 
 public static StringSList NextNumbers (String btr, int n) //metodo che riceve un numero in notazione ternaria e ritorna una lista che contiene oltre a btr i suoi (n-1) successivi
 {
    StringSList l = new StringSList(btr,StringSList.NULL_STRINGLIST); //si crea una lista dove inserisce il primo elemento btr (il primo parametro contiene il primo elemento, il secondo e' il resto della lista), ovvero quello ricevuto in input e mancano i successivi n-1 elementi
    
    for(int i=1;i<=n-1;i++)
    {
        String succ = BtrSucc(l.car()); //mi calcolo il successivo del numero nella lista
        l=l.cons(succ); //inserisco il nuovo calcolato che finira' in prima alla lista..cosi il successivo all'iterazione dopo verra' calcolato sul car che effettivamente e' l'ultimo elemento inserito
    }
    System.out.println(l.reverse());
    return l.reverse(); //ritorno la lista rovesciata in modo da riordinarla
 }
 
 public static String BtrSucc(String btr)
 {
       int n = btr.length(); //n e' la lunghezza della stringa btr
       char lsb = btr.charAt(n-1);  //lsb e' l'ultimo carattere
            
       if(n==1)   //se la stringa ha solo un carattere
       {
         if(lsb == '+')  //e se e' un +
           return "+-";  //allora ritorna il successivo
         else            //altrimenti se e' un .
           return "+";   //ritorna un +
       }
       else    //altrimenti se la stringa ha piu di un carattere
       {   
         String pre = btr.substring(0,n-1); //pre e' tutto il resto della stringa escluso lsb
         if(lsb=='+')  //se la sua ultima cifra e' un +
           return BtrSucc(pre) + "-"; //richiama ricorsivamente la funzione incrementando il successivo carattere e sottraendo a quello ricorrente
                
         else if(lsb=='-') //se l'ultimo carattere e un - allora lo incrementa in .
           return pre + ".";
                    
         else   //se l'ultimo carattere e' un . allora lo incrementa in +
          return pre + "+"; 
       }
  }    
}
