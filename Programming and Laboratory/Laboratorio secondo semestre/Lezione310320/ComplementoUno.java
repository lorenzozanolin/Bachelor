package Lezione310320;
/*(define ones-complement  ; val: stringa di 0/1
    (lambda (bin)          ; bin: stringa di 0/1
        (if (string=? bin "")
            ""
            (string-append
                (ones-complement (substring bin 0 (- (string-length bin) 1)))
                (bit-complement (substring bin (- (string-length bin) 1)))
                ))
    ))

    
    
(define bit-complement   ; val: stringa
  (lambda (bit)          ; bit: stringa
    (if (string=? bit "0")
        "1"
        "0"
        )))
   */
public class ComplementoUno
{
    public static String OnesComplement(String bin)
    {
        char[] binI = bin.toCharArray(); //converto la stringa in un vettore di char

        if (bin=="")  //se la stringa e' vuota allora ritorna null
            return "";
         
        else
        {
            for(int i=0;i<bin.length();i++)
            {
                if(binI[i] == '0') //se il char alla posizione i e' 0 allora lo cambio in 1
                    binI[i]='1';
                else if(binI[i] == '1') //viceversa
                    binI[i]='0';  
            }
        }
        
        return String.valueOf(binI);    //ritorno il vettore riconvertendolo in String
    }
}
