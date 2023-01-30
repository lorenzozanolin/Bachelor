    /*
        ESERCIZIO 1
        Il linguaggio formato da espressioni aritmetiche scritte in notazione polacca inversa e costruite a partire dalle costanti intere e le 4 operazioni aritmetiche. 
        L’analizzatore deve restituire l’albero della struttura sintattica dell’espressione ricevuta in ingresso.
        
    */
%{
#include <stdio.h>
#include "y.tab.h"
extern yylval;
%}

%%
[0-9]+ {yylval = atoi(yytext); return NUMBER;}
[a-zA-Z0-9]+ { printf("Questo non è un numero \n");}
-[0-9]+ {yylval = atoi(yytext); return NUMBER;} //i numeri con il (-) davanti vanno per forza messi attaccati
"+" {return yytext[0];}
"-" {return yytext[0];}
"/" {return yytext[0];}
"*" {return yytext[0];}
[ \t]+ /* ignora spazi bianchi e fine linea e stampa ili risultato se non è vuota*/
\n     { return yytext[0]; }

%%