%{
  /* Definition section */
    #include <stdio.h>
    int yylex();
    int yyerror(char *s);
%}

%token NUMBER ID
// setting the precedence and associativity of operators
%left '+' '-'
%left '*' '/'

/* Rule Section */
%%
input: 
       | input line
;
line : '\n'
       | exp '\n'{ printf("Result = %d\n", $$);}
;
exp :
  exp '+' exp { $$ = $1 + $3; }
  | exp '-' exp { $$ = $1 - $3; }
  | exp '*' exp { $$ = $1 * $3; }
  | exp '/' exp { $$ = $1 / $3; }
  | '-' NUMBER { $$ = -$2; }
  | '-' ID { $$ = -$2; }
  | '(' exp ')' { $$ = $2; }
  | NUMBER { $$ = $1; }
  | ID { $$ = $1; }
;
%%

int main() {
  printf("Enter the expression\n");
  yyparse();
}

/* For printing error messages */
int yyerror(char* s) {
  printf("\nExpression is invalid\n");
}
