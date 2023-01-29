package Esercizio3103;
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
      int n = bin.length(); // n lunghezza del numero
      String head; // head parte della stringa precedente al carattere da cambiare
      String tail;// tail parte della stringa successiva al carattere da cambiare
      char c;// c carattere da cambiare

      for( int i=0; i<n; i++){// a ogni iterazione considero il carattere in posizione i e lo cambio
        head = bin.substring( 0, i);
        tail = bin.substring( i+1, n);
        c = bin.charAt( i );

        if( c == '1')// se c e' 1 allora unisco la parte precedente a 0 e alla parte successiva
          bin = head + "0" + tail;
        else// altrimenti faccio la stessa cosa con l'1
          bin = head + "1" + tail;

      }

      return bin;
    }
}
