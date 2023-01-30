ESAME 13.9.2019

1.
cat etc/passed | cut -d':' -f6 | grep '^/home' | wc -l --> GREP '^/home' impone che /home sia la prima parte della stringa, cosi non trova es. /ciao/home


2.
counter=0
for i in /home/*   -->  cerca in tutte le cartelle sottostanti, cioe' solo dello stesso livello
  do
    if test -d $i
      then
      	counter=$[$counter+1]
    fi
  done
echo $counter
exit 0


3.
#include <stdio.h>
#include <stdlib.h>

struct Node{
  int key;
  struct Node *p;
};

struct Node* create();
void insert(struct Node*,int);
void visualizza(struct Node *);

int main(){
  struct Node *l = create();
  visualizza(l);
  return 0;
}

struct Node* create(){
  int n;
  struct Node *list = malloc(sizeof(struct Node));
  while(scanf("%d \n",&n) != -1){ //ha registrato un valore non valido
      insert(list,n);
  }
  return list;
}

void insert(struct Node* n,int x){
  if(n == NULL)
    new->key = x;
  while(n->p != NULL){
    n = n->p;
  }
  struct Node * new = malloc(sizeof(struct Node));
  new->p = NULL;
  new->key = x;
  n->p = new;
}

void visualizza(struct Node *n){
  while(n->p != NULL){
    printf("%d",n->key);
    struct Node *p = n->p;
    free(n);
    n = p;
  }
  printf("%d",n->key);
  free(n);
}


4.
#include <stdio.h>
##include <unistd.h>
