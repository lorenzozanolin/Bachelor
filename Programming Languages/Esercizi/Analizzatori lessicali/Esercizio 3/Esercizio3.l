    /*ESERCIZIO 3: rimuovere i commenti
    Rimuovere i commenti da un testo Java. 
    */
%{
   int nParantesi = 0; 
%}
cifra [0-9]
lettera [a-zA-Z]
simbolo "//"
commentoUnaRiga {simbolo}.*
%%
{commentoUnaRiga} {printf(" \n");}
"/*".* {nParantesi++;}
"*/".* {nParantesi--;
      if(nParantesi == 0)
        printf(" \n");}
%%
void yyerror (const char *str) { fprintf(stderr, "errore: %s\n", str); }
int yywrap () { return 1; }
int main () {
    yylex();
    return 0;
}
