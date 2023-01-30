    /*
        ESERCIZIO 7
        Riconoscere, in un file di testo, le sequenze di caratteri che rappresentano un numero in uno dei seguenti formati:

        numero intero: stringa di cifre decimali, eventualmente precedute dal segno (+/-)
        numero frazionari: coppia di stringhe di cifre intervallate da un punto ed eventualmente precedute dal segno, una delle due stringe, ma non entrambe può essere vuota.
        floating point: numero intero o frazionario, seguito da “e”, oppure “E”, seguito da un numero intero.
        Per ciascuna sequenza riconosciuta, stampare in uscita: la sequenza stessa, il tipo di numero rappresentato, il numero di cifre usate nella rappresentazione.
    */
%{
   int counterCifre = 0; 
%}
cifra [0-9]
operatore (\+|\-)?
intero {operatore}{cifra}+
frazionario {operatore}{cifra}*"."{cifra}+|{intero} 
floatingPoint {intero}"e"{intero}|{frazionario}"e"{intero}
nonValidi .
%%
{intero}(" "|\n|\t) { for(int i=0;i<yyleng-1;i++)
                     {
                        if(yytext[i]>='0' && yytext[i]<='9')
                            counterCifre++;
                     }
                        printf("%s, intero, numero di cifre: %d \n",yytext,counterCifre);
                        counterCifre = 0;
                    }
{frazionario}(" "|\n|\t) { for(int i=0;i<yyleng-1;i++)
                            {
                                if(yytext[i]>='0' && yytext[i]<='9')
                                    counterCifre++;
                            }
                            printf("%s, frazionario, numero di cifre: %d \n",yytext,counterCifre);
                            counterCifre = 0;
                        }
{floatingPoint}(" "|\n|\t) { for(int i=0;i<yyleng-1;i++)
                            {
                                if(yytext[i]>='0' && yytext[i]<='9')
                                    counterCifre++;
                            }
                             printf("%s, floating point, numero di cifre: %d \n",yytext,counterCifre);
                             counterCifre = 0;
                          }

{nonValidi} {printf("");}
%%
void yyerror (const char *str) { fprintf(stderr, "errore: %s\n", str); }
int yywrap () { return 1; }
int main () {
    yylex();
    return 0;
}
