//es17
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>

typedef struct node node;

struct node {
    int key;
    node* left;
    node* right;
    int h;
};


node *build_tree(){
  char s[100];
  scanf("%s",s);

  if(strcmp(s,"NULL") == 0)
    return NULL;

  int k = atoi(s);
  node *n = malloc(sizeof(node));
  n->key=k;

  node *l = build_tree();
  node *r = build_tree();
  n->left = l;
  n->right = r;
  n->h = -1;

  return n;
}

void stampa(node *n){

  if(n == NULL)
    printf("NULL");
    return;

  printf("%i\n",n->key);

  stampa(n->left);
  stampa(n->right);
}

int verificaBST(node* n,int min,int max){
  if(n == NULL)
    return 1;
  if((n->key <= min) || (n->key >= max))
    return 0;

  return verificaBST(n->left,min,n->key) && verificaBST(n->right,n->key,max);
}

//verifica se e' bst
int main(){

  node* tree = build_tree();
  printf("%d\n", verificaBST(tree, INT_MIN, INT_MAX));
  return 0;

}
