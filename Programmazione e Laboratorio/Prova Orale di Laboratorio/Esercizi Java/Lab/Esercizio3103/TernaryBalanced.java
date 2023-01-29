package Esercizio3103;
    
    /*
     (define btr-succ ; val: stringa di -/./+
        (lambda (btr) ; btr: stringa di -/./+
            (let ((n (string-length btr))) ; (brt = "." oppure inizia con "+")
                (let ((lsb (string-ref btr (- n 1))))
                 (if (= n 1)
                    (if (char=? lsb #\+)
                    "+-"
                    "+")
                 (let ((pre (substring btr 0 (- n 1))))
                    (if (char=? lsb #\+)
                        (string-append (btr-succ pre) "-")
                        (string-append pre (if (char=? lsb #\-) "." "+"))
                        ))
                 )))
         ))
     * */
     
    public class TernaryBalanced
    {
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
