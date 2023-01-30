    /*ESERCIZIO 2: rimuovere i commenti
    Rimuovere i commenti da un testo Haskell. 
    I commenti Haskell, hanno due possibili formati:
        iniziano con la stringa di caratteri -- e terminano con il ritorno a capo
        iniziano con la stringa di caratteri {- e terminano con la stringa -}
    */
%{
   int nParantesi = 0; 
%}
cifra [0-9]
lettera [a-zA-Z]
simbolo "--"
commentoUnaRiga {simbolo}.*\n
%%
{commentoUnaRiga} {printf(" ");}
"{-" {nParantesi++; printf(" ");}   //se incontra un inizio di commento allora lo elimina e incrementa il counter
"-}" {nParantesi--; printf(" ");}  //se incontra un fine di commento allora lo elimina e decrementa il counter
. {if(nParantesi == 0) //per ogni altro carattere, lo stampa solamente se è al di fuori di un commento su più righe
    printf("%s",yytext);}


%%
void yyerror (const char *str) { fprintf(stderr, "errore: %s\n", str); }
int yywrap () { return 1; }
int main () {
    yylex();
    return 0;
}
