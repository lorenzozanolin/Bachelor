%{
#include <stdio.h>
#include <string.h>

void yyerror(const char *str)
{fprintf(stderr, "errore: %s\n", str);}
int yywrap() {return 1;}
int yyparse();
int yylex();
int main() {yyparse();}
%}

%token NUMERO TOKRISCALDAMENTO STATO TOKOBIETTIVO TOKTEMP

%%

comandi: /* vuoto */
      | comandi comando
      ;

comando: interruttore_riscaldamento
      | imposta_obiettivo
      ;

interruttore_riscaldamento: TOKRISCALDAMENTO STATO
      {if($2) printf("\t Riscaldamento acceso \n");
        else printf("\t Riscaldamento spento \n");} 
      ;

imposta_obiettivo: TOKOBIETTIVO TOKTEMP NUMERO
       {printf("\t Temperatura impostata a %d \n", $3);}
       ;
