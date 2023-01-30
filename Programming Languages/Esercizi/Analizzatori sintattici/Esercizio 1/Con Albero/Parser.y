%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int yylex();
int yyparse();

struct node
{
    char op;
    int value;
    struct node* left;
    struct node* right;
};

struct node* createNode(char op,int value, struct node* left, struct node* right){
    struct node* nuovoNodo = (struct node*) malloc(sizeof(struct node));
    nuovoNodo->op = op;
    nuovoNodo->value = value;
    nuovoNodo->left = left;
    nuovoNodo->right = right;
    return nuovoNodo;
}

void printTree(struct node*tree){
    if(tree->op == ' ')
        printf("%d \n",tree->value);
    else if(tree->op == '(' || tree->op == ')')
    {
        if(tree->op == '(')
            printf("(");
        else 
            printf(")");
    }
    else{
        printTree(tree->left);
        printTree(tree->right);
        printf("%d \n",tree->op);
    }
}


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
     | exp '\n' {printTree($1);}
;
//con $$ ritorno il valore alla produzione precedente e mano a mano costruisco albero
exp : NUMBER { $$= createNode(' ',$1,NULL,NULL);}
    | exp  exp '+'{ $$ = createNode('+',0,$1,$2); }
    | exp  exp '-'{ $$ = createNode('-',0,$1,$2); }
    | exp  exp '*'{ $$ = createNode('*',0,$1,$2); }
    | exp  exp '/'{ $$ = createNode('/',0,$1,$2); }
    | '(' {$$= createNode('(',0,NULL,NULL);}
    | ')' {$$= createNode(')',0,NULL,NULL);}
;

%%
int main() {
  printf("Enter the expression\n");
  yyparse();
}

int yyerror(char* s) {
  printf("\nExpression is invalid\n");
}
