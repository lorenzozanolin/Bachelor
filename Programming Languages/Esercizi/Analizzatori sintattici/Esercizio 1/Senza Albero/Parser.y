%{
    #include "Tree.h"
    #include <string.h>
    #include <math.h>
    #include <stdio.h>

    int yylex();
    int yyerror(char *s);
    
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%
 /* REGOLE E AZIONI SEMANTICHE */
input:
      | input line
;
line : '\n'
     | exp '\n' {printPTree();}
;

exp : NUMBER {createLeaf($1);} //inserisce nel nodo il numero
    | exp  exp '+'{ createNode("   +   ",strlen("   +   ")); } //inserisce nel nodo l operatore
    | exp  exp '-'{ createNode("   -   ",strlen("   -   ")); }
    | exp  exp '*'{ createNode("   *   ",strlen("   *   ")); }
    | exp  exp '/'{ createNode("   /   ",strlen("   /   ")); }
;

%%

int main() {
  printf("Inserire l'operazione in notazione polacca inversa:\n");
  yyparse();
}

int yyerror(char* s) {
  printf("\nErrore nell'espressione inserita!\n");
}

