/**
 * Riscrivere le funzioni length(), find(), last(), append(), e destroy() per le liste concatenate utilizzando un approccio ricorsivo.
 * **/

#include <stdio.h>
#include <math.h>

#include "es2.h" //libreria con le dichiarazioni

Node *createList(int data) {
    Node *ptr = malloc(sizeof(Node));
    ptr->data = data;
    ptr->next = NULL;
    return ptr;
}

int listLength(Node *head) {
    if(head->next = NULL)
        return 0;
    else
        return 1+ listLength(head->next);
}

Node *listFind(Node *head, int data) {     
    if(head == NULL)
    return NULL;

    if(head->data == data)
    return head;

    return listFind(head->next, data);
}

Node *listLast(Node *head) {
    if(head == NULL)
        return NULL;

    if(head->next = NULL)
        return head;
    else
        return listLast(head->next);
}

Node *listAppend(Node *head1, Node *head2) {
    if(head1 == NULL)
    return head2;

    Node *last1 = last(head1);
    last1->next = head2;
    return head1;
}

void listDestroy(Node *head) {
    
    if(head == NULL)
    return;

    Node *next = head->next;

    free(head);
    list_destroy(next);
}

void listPrint(Node *head) {
  if(head == NULL) {
    putchar('\n');
    return;
  }

  printf("%d ", head->data);
  list_print(head->next);
}