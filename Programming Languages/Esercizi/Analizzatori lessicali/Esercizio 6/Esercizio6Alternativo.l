    /*
        ESERCIZIO 6
        Selezionare in un file di testo le stringhe di caratteri che rappresentano in notazione binaria un numero multiplo di 3. 
        Solo in numeri multipli di 4 vengono stampati in uscita, separati da uno spazio, la restante parte del testo viene eliminata. 
        Il controllo di divisibilità deve essere implementato usando opportune espressioni regolari, e non l’operazione di divisione-resto.
        multipli di 4: terminano con "00"
    */
multipliTre (0|(1(01*0)*1))*
nonValidi .

%%
{multipliTre}00(" "|\n|\t) {printf("%s ",yytext);}
{nonValidi} {printf("");}

%%
void yyerror (const char *str) { fprintf(stderr, "errore: %s\n", str); }
int yywrap () { return 1; }
int main () {
    yylex();
    return 0;
}