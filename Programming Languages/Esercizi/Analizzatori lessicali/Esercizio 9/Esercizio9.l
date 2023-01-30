    /*
        ESERCIZIO 9
        Ricevuto in input una sequenza di sostantivi nelle lingua italiana, trasformare al plurale i sostantivi femminili e al singolare quelli maschili. 
        Il programma può applicare una semplice regola generale per catalogare un sostantivo come femminile-maschile, singolare-plurale ma deve riuscire a 
        gestire almeno una decina di eccezioni a questo regola (es. mano, tema, radio, parentesi, uomo).
    */
%{
   char* converti(char*,int,char);
%}
lettera [a-zA-Z]
consonante [bBcCdDfFgGhHlLmMnNpPqQrRsStTvVwWyYzZ]
femminile {lettera}*[aA]
maschile {lettera}*[eEiIoOuU]|{lettera}*{consonante}
eccezioni parentesi|mano|radio|uomo|tema
nonValidi .
%%
(t|T)emi(" "|\n|\t) {yytext[yyleng-2] = 'a';printf("%s",yytext);} //sostituisce la i con la a, nel caso del tema
(c|C)ani(" "|\n|\t) {yytext[yyleng-2] = 'e';printf("%s",yytext);}
(u|U)omini(" "|\n|\t) {printf("uomo");}

{eccezioni}(" "|\n|\t) {
                        printf("%s",yytext);
                      }
{femminile}(" "|\n|\t) {
                        printf("%s",converti(yytext,yyleng,'f'));
                      }

{maschile}(" "|\n|\t) {
                        printf("%s",converti(yytext,yyleng,'m'));
                      }
{nonValidi} {printf("");}
%%
char* converti (char* token, int len, char tipo) {
    switch(tipo){
        case 'm':{  //caso maschio
                    if(yytext[yyleng-2] == 'i') //se termina per i sostituisco con o
                        yytext[yyleng-2] = 'o';
                    if(yytext[yyleng-2] == 'I')
                        yytext[yyleng-2] = 'O';
                    break;
                 }
        case 'f':{  //caso femmina
                    if(yytext[yyleng-2] == 'a') //se termina con a sostituisco con e
                        yytext[yyleng-2] = 'e';
                    if(yytext[yyleng-2] == 'A')
                        yytext[yyleng-2] = 'E';
                    break;
                 }
    }
    return yytext;
}
void yyerror (const char *str) { fprintf(stderr, "errore: %s\n", str); }
int yywrap () { return 1; }
int main () {
    yylex();
    return 0;
}
