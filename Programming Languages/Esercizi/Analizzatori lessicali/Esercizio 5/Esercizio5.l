    /*
        ESERCIZIO 5
        Selezionare in un file di testo le stringhe di caratteri che rappresentano un numero multiplo di quattro, nell’usuale notazione decimale. 
        Solo in numeri multipli di 4 vengono stampati in uscita, separati da uno spazio, la restante parte del testo viene eliminata. 
        Il controllo di divisibilità deve essere implementato usando opportune espressioni regolari, e non l’operazione di divisione-resto.

        MULTIPLO DI 4: se le ultime due cifre a dx sono 00, o sono un multiplo di 4 o multiplo di 25
    */
cifra [0-9]
multipliDueCifre 00|04|08|12|16|20|24|25|28|32|36|40|44|48|50|52|56|60|64|68|72|75|76|80|84|88|92|96
multiplo {cifra}*{multipliDueCifre}
nonValidi .
%%
{multiplo}(" "|\n|\t) {printf("%s ",yytext);}
{nonValidi} {printf("");}
%%
void yyerror (const char *str) { fprintf(stderr, "errore: %s\n", str); }
int yywrap () { return 1; }
int main () {
    yylex();
    return 0;
}