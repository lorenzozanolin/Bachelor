    /*ESERCIZIO 4: Selezionare, in un file di testo, le stringhe di caratteri che rappresentano un numero in notazione romana.
     Solo i numeri romani devo essere stampati in uscita, separati da uno spazio, la restante parte del testo viene eliminata.
    */
unita I|II|III|IV|V|VI|VII|VIII|IX
decine X{unita}|XX{unita}|XXX{unita}|XL{unita}|L{unita}|LX{unita}|LXX{unita}|LXXX{unita}|XC{unita}|X|XX|XXX|XL|L|LX|LXX|LXXX|XC
centinaia C{decine}|CC{decine}|CCC{decine}|CD{decine}|D{decine}|DC{decine}|DCC{decine}|DCCC{decine}|CM{decine}|C|CC|CCC|CD|D|DC|DCC|DCCC|CM
migliaia M{centinaia}|MM{centinaia}|MMM{centinaia}|M|MM|MMM
nonValidi .  

%%
{migliaia}(" "|\n|\t) {printf("%s ",yytext);}
{centinaia}(" "|\n|\t) {printf("%s ",yytext);}
{decine}(" "|\n|\t) {printf("%s ",yytext);}
{unita}(" "|\n|\t) {printf("%s ",yytext);}
{nonValidi} {printf("");}

%%
void yyerror (const char *str) { fprintf(stderr, "errore: %s\n", str); }
int yywrap () { return 1; }
int main () {
    yylex();
    return 0;
}