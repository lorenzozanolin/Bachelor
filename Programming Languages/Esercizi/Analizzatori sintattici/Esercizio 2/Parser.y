%{
    #include <stdio.h>
    int yylex();
    int yyerror(char *s);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%
input:
      | input line
;
line : '\n'
       | exp '\n'{ printf("Result = %d\n", $$);}
;
exp :
  '+' exp  exp { $$ = $2 + $3; }
  |'-' exp  exp { $$ = $2 - $3; }
  |'*' exp  exp { $$ = $2 * $3; }
  |'/' exp  exp { $$ = $2 / $3; }
  | '(' exp ')' { $$ = $2; }
  | NUMBER { $$ = $1; }
;
%%

int main() {
  printf("Enter the expression\n");
  yyparse();
}

int yyerror(char* s) {
  printf("\nExpression is invalid\n");
}
