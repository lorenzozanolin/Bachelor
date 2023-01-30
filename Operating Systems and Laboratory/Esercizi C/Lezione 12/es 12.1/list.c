/*
 * Funzioni per la manipolazione di liste concatenate
 */

#include "list.h"

// Crea un nodo
struct node *create(int data) {
  struct node *ptr = malloc(sizeof(struct node));
  ptr->data = data;
  ptr->next = NULL;

  return ptr;
}

// Restituisce la lunghezza di una lista
int length(struct node *head) {
  if(head == NULL)
    return 0;

  return 1 + length(head->next);
}

/*
 * Trova un elemento all'interno della lista e restituisce il nodo che lo
 * contiene, oppure NULL se il nodo non viene trovato.
 */
struct node *find(struct node *head, int data) {
  if(head == NULL)
    return NULL;

  if(head->data == data)
    return head;

  return find(head->next, data);
}

// Restituisce l'ultimo elemento di una lista, o NULL se la lista è NULL
struct node *last(struct node *head) {
  if(head == NULL)
    return NULL;

  if(head->next == NULL)
    return head;

  return last(head->next);
}

// Concatena la lista puntata da head2 in fondo alla lista puntata da head1
struct node *append(struct node *head1, struct node *head2) {
  if(head1 == NULL)
    return head2;

  struct node *last1 = last(head1);
  last1->next = head2;

  return head1;
}

// Stampa i valori di una lista
void printlist(struct node *head) {
  if(head == NULL) {
    putchar('\n');
    return;
  }

  printf("%d ", head->data);
  printlist(head->next);
}

// Distrugge tutti i nodi di una lista
void destroy(struct node *head) {
  if(head == NULL)
    return;

  struct node *next = head->next;

  free(head);
  destroy(next);
}

