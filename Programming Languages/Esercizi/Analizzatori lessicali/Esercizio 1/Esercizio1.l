    /*ESERCIZIO 1: 
    Riconoscere in un file di testo le seguenti classi di lessemi:
        parole chiave: var, function, procedure, while, do, if then, else, for
        identificatori: stringhe che iniziano con una lettere minuscola dell’alfabeto seguite da lettere, cifre, e i simboli ’_‘,’-’.
        costanti numeriche: sequenze di cifre,
        operatori: “+”, “++”, “-”, “–”, “=”, “==”,
    */
cifra [0-9]
lettera [a-zA-Z]
simbolo _|\-
parole var|procedure|while|do|"if then"|else|for
identificatori [a-z]({lettera}|{cifra}|{simbolo})*
costanti {cifra}+
operatori \+|"++"|\-|"--"|=|"=="

%%
{parole}  {printf("Parola : %s",yytext);}
{identificatori}  {printf("Identificatore : %s",yytext);}
{costanti}  {printf("Costante : %s",yytext);}
{operatori}  {printf("Operatore : %s",yytext);}
%%
void yyerror (const char *str) { fprintf(stderr, "errore: %s\n", str); }
int yywrap () { return 1; }
int main () {
    yylex();
    return 0;
}

