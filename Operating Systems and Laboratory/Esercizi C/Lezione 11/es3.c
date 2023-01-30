/**
 * Dichiarare una struttura per la rappresentazione di un
    albero binario di ricerca (non necessariamente bilanciato),
    ed implementare le relative operazioni:

    - Una funzione create() per creare un albero con solo la radice.
    - Una funzione insert() per inserire un numero intero all’interno dell’albero.
    - Una funzione find() per trovare un valore nell’albero.
    - Una funzione remove() per rimuovere un valore dall’albero.
    - Una funzione destroy() per liberare la memoria occupata da tutti i nodi dell’albero.
    - Una funzione to_list() che restituisca una lista concatenata
    (implementata a lezione o nell’esercizio 2), contenente i valori dell’albero in ordine di visita

 *  richiamo teorico: per ogni nodo --> figlio SX è minore del padre
 *                                  --> figlio DX è maggiore del padre
 * **/

#include <stdio.h>
#include <stdlib.h>

#include "es3.h"

int main(){
   NodoAlbero * albero = NULL;

   //INSERIMENTO NODI DELL'ALBERO
   int n = 0;
   while(scanf("%d",&n) == 1){ 
      albero = insertTree(albero,n);
   }

   //CREAZIONE DI UNA LISTA e VISUALIZZAZIONE
   NodoLista * miaLista = treetoList(albero);
   listPrint(miaLista);

   return 0;

}

NodoAlbero * createTree(int data){
   NodoAlbero *ptr = malloc(sizeof(NodoAlbero));
   ptr->data = data;
   ptr->left = NULL;
   ptr->right = NULL;
   ptr->parent = NULL;
   return ptr;

}

NodoAlbero * insertTree(NodoAlbero * root,int x){
   NodoAlbero *new = createTree(x); //mi creo il nodo
   NodoAlbero *tree = root; //è l'albero
   NodoAlbero *dad;

   while(tree != NULL){
      dad = tree;
      if(new->data > tree->data) //caso >
         tree = tree->right;
      else
         tree = tree->left; //caso <=
   }
   //ora so che padre punta al padre del nodo che mi interessa
   if(dad->data < new->data){
      new->parent = dad;
      dad->right = new;
   }
   else if(dad->data > new->data){
      new->parent = dad;
      dad->left = new;
   }

   return root;
}

NodoAlbero *findTree(NodoAlbero *root, int data) {
   NodoAlbero *tree = root; 
   
   while(tree != NULL){
   if(tree->data = data)
      return tree;
   else if(tree->data < data)
      tree = tree->right;
   else
      tree = tree->left;
   }

   return NULL;
}

void removeTree(NodoAlbero * root,int data){
   NodoAlbero *enemy = findTree(root,data); //ricerco il nodo interessato e lo salvo in enemy

   if(enemy != NULL){

      if(enemy->left == NULL && enemy->right == NULL){ //nel caso non avesse figli
         free(enemy);
      }
      if(enemy->left != NULL && enemy->right != NULL){ //caso in cui ha due figli
         NodoAlbero * min = findMin(enemy); //cosi trovo il minimo 
         enemy->data = min->data;
         free(min);
      }

      //CASISTICA ROOT
      if(enemy->parent == NULL && enemy->right != NULL && enemy->left == NULL){ //se l'elemento da rimuovere e' la root e ha solo figlio dx
         root = enemy->right; //enemy e' il puntatore alla vecchia root, mentre root punta alla nuova root, ovvero il figlio dx
         free(enemy);
      }

      if(enemy->parent == NULL && enemy->left != NULL && enemy->right == NULL){ //se l'elemento da rimuovere e' la root e ha solo figlio sx
         root = enemy->left; //enemy e' il puntatore alla vecchia root, mentre root punta alla nuova root, ovvero il figlio sx
         free(enemy);
      }

      //CASISTICA NODI INTERMEDI
      if(enemy->left != NULL && enemy->right == NULL){ //ha solo figlio sx
         enemy->parent->left = enemy->left;
         enemy->left->parent = enemy->parent;
         
         free(enemy);
      }
      else if(enemy->left == NULL && enemy->right != NULL){  //ha solo figlio dx
         enemy->parent->right = enemy->right;
         enemy->right->parent = enemy->parent;
         
         free(enemy);
      }
   }
}

NodoAlbero * findMin(NodoAlbero * nodoAttuale){ //ricerco il minimo di un sottonodo
   nodoAttuale = nodoAttuale->right;

   while(nodoAttuale->left != NULL)
      nodoAttuale = nodoAttuale->left;

   return nodoAttuale;
}

void listPrint(NodoLista *head) {
  if(head == NULL) {
    putchar('\n');
    return;
  }

  printf("%d ", head->data);
  listPrint(head->next);
}

NodoLista * treetoList(NodoAlbero * root){
   if(root == NULL)
    return NULL;

   NodoLista *left_list = treetoList(root->left);
   NodoLista *right_list = treetoList(root->right);

  return
    listAppend(left_list, listAppend(createList(root->data), right_list));
}

NodoLista *listAppend(NodoLista *head1, NodoLista *head2) {
    if(head1 == NULL)
    return head2;

    NodoLista *last1 = listLast(head1);
    last1->next = head2;
    return head1;
}

NodoLista *createList(int data){
    NodoLista *ptr = malloc(sizeof(NodoLista));
    ptr->data = data;
    ptr->next = NULL;
    return ptr;
}

NodoLista *listLast(NodoLista *head) {
    if(head == NULL)
        return NULL;

    if(head->next = NULL)
        return head;
    else
        return listLast(head->next);
}