#ifndef LIST_H__
#define LIST_H__

//Includo le librerie da importare

#include <stdio.h>
#include <stdlib.h>

// Definisco tutte le procedure e strutture utilizzate in list.c
struct node { //struct nodo della lista
  int data;
  struct node *next;
};

struct node *create(int);
void destroy(struct node *);
int length(struct node *);
struct node *find(struct node *, int);
struct node *last(struct node *);
struct node *append(struct node *, struct node *);
void printlist(struct node *);

#endif