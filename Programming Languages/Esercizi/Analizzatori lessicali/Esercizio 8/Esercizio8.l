    /*
        ESERCIZIO 8
        Riconoscere stringhe di cifre e caratteri, che rappresentano i numeri in uno dei seguenti formati:

        numero interi: stringa di cifre decimali, eventualmente precedute dal segno (+/-)
        numeri esadecimali: stringa di cifre esadecimali (0-9, a-f, A-F) preceduta dalla sequenze “0x”, oppure una stringa di cifra esadecimali seguita da ‘H’.
        numeri ottali: stringa di cifre ottali (0-7) preceduta dalla sequenze “0o”, oppure una stringa di cifre ottali seguite da ‘O’.
        Per ciascuna stringa riconosciuta stampare in uscita il formato del numero riconosciuto, il suo valore decimale.
    */
%{
   int valoreDecimale = 0; 
   int converti(char*,int);
%}
cifraDecimale [0-9]
cifraEsadecimale [0-9a-fA-F] 
cifraOttale [0-7]
intero (\-|\+)?{cifraDecimale}+
esadecimale "0x"{cifraEsadecimale}+|{cifraEsadecimale}+"H"
ottale "0o"{cifraOttale}+|{cifraOttale}+"O"
nonValidi .
%%
{intero}(" "|\n|\t) {for(int i=0; i<yyleng;i++)
                        {
                            if(yytext[i]>='0' && yytext[i]<='9')
                                    valoreDecimale = (valoreDecimale * 10) + (int)yytext[i] - '0';
                        }
                        printf("Letto: %s Formato: intero, valore decimale: %d \n",yytext,valoreDecimale);
                        valoreDecimale=0;
                    }

{esadecimale}(" "|\n|\t) {   valoreDecimale = converti(yytext,yyleng);
                            printf("Letto: %s Formato: esadecimale, valore decimale: %d \n",yytext,valoreDecimale);
                            valoreDecimale=0;
                        }
{ottale}(" "|\n|\t) {   valoreDecimale = converti(yytext,yyleng);
                        printf("Letto: %s Formato: ottale, valore decimale: %d \n",yytext,valoreDecimale);
                        valoreDecimale=0;
                    }
{nonValidi} {printf("");}
%%
int converti (char* token, int len) {
    if (token[1] == 'x') {
        return (int)strtol(token+2, NULL, 16);
    } else if (token[len-1] == 'H') {
        token[len-1] = 0;   //setto a 0 perche deve essere il terminatore
        return (int)strtol(token, NULL, 16);
    } else if (token[1] == 'o') {
        return (int)strtol(token+2, NULL, 8);
    } else {
        token[len-1] = 0; //setto a 0 perche deve essere il terminatore
        return (int)strtol(token, NULL, 8);
    }
}
void yyerror (const char *str) { fprintf(stderr, "errore: %s\n", str); }
int yywrap () { return 1; }
int main () {
    yylex();
    return 0;
}
