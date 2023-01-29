#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <iostream>
#include <sstream>
#include <iomanip>

//------ Metodi bst

#define BSTTYPE
typedef struct bst bst;

struct bst {
    int key;
    bst *left;
    bst *right;
};

struct bst_tree {
    bst * root;
};

// inserisce un nuovo nodo in tree con chiave k intera
// si assume che l'albero non contenga gia' un nodo di chiave k
bst * BST_insert( bst *tree, bst * node );
// resituisce il nodo di tree di chiave minima
bst * BST_min_value_node( bst *tree );
// restituisce true se key è contenuta in tree, false altrimenti
bool BST_find( bst *tree, int key );
// elimina l'albero tree
void BST_clear( bst *tree );
// stampa la chiave e il valore del nodo n
void BST_print_node( bst *n );
// stampa preoder dell'albero tree
void BST_show( bst *tree );

//------ Metodi avl
#define AVLTYPE
typedef struct avl avl; 

struct avl {
    int key;
    int height;
    avl *left;
    avl *right;
};

struct avl_tree {
    avl * root;
};

//ritorna l'altezza del nodo passato come parametro
int AVL_height ( avl * tree );
//procedura ausiliaria per verificare la proprieta' dell'AVL
int AVL_get_balance ( avl * n );
//procedura che effettua la rotazione verso dx dell'albero 
avl * AVL_right_rotate( avl * n );
 //procedura che effettua la rotazione verso sx dell'albero
avl * AVL_left_rotate( avl * n );
//inserisce il nodo node nell'albero radicato in tree
avl * AVL_insert ( avl *tree, avl * node );
//procedura che ricerca il minimo nell'albero, dato che e' bst e' il figlio piu in basso a sx
avl * AVL_min_value_node ( avl *tree );
//ricerca del valore del nodo all'interno dell'albero
bool AVL_find ( avl *tree, int key );
//procedura per eliminare completamente l'albero
void AVL_clear ( avl *tree );

//procedura che stampa i valori di un nodo
void AVL_print_node ( avl *n );
//procedura che stampa l'albero in notazione polacca
void AVL_show ( avl *tree );

//------ Metodi rbt
#define RBTYPE
typedef struct rb rb;
typedef struct rb_tree rb_tree;

struct rb {
    int key;
    char color;
    rb *left;
    rb *right;
    rb *parent;
};

struct rb_tree {
    rb * root;
};

// Procedura che ritorna true se il nodo è del colore specificato, false altrimenti (le foglie sono black per definizione)
bool RB_check_color ( rb * n, char color );
// Procedura che ritorna il puntatore al parent di un nodo se esso esiste, NULL altrimenti
rb * RB_parent ( rb * n );
// Procedura che ritorna il puntatore al parent del parent di un nodo, se esso e il suo parent esistono
rb * RB_grandparent ( rb * n );
// Procedura che restituisce il figlio opposto del padre del nodo fornito, se questi ultimi due esistono
rb * RB_sibling ( rb * n );
// Procedura che restituisce lo zio del nodo fornito, se esso, il suo padre e il suo nonno esistono, NULL altrimenti
rb * RB_uncle ( rb * n );
// Procedura ausiliaria che controlla se lo zio del nodo fornito è sullo stesso lato di quest'ultimo rispetto al parent/grandparent
bool RB_check_if_uncle_on_same_side ( rb * n );
// Procedura che cambia il colore a un nodo se è non-NULL
void RB_change_color ( rb * n, char color );
// Procedura che scambia 6 puntatori per ribilanciare il peso ruotando nodi verso in senso antiorario rispetto a un nodo perno, pur preservando gli invarianti dei BST
void RB_left_rotate ( rb_tree *tree, rb * x);
// Procedura che scambia 6 puntatori per ribilanciare il peso ruotando nodi verso in senso orario rispetto a un nodo perno, pur preservando gli invarianti dei BST
void RB_right_rotate ( rb_tree * tree, rb * x );
// Procedura che ristabilisce gli invarianti dei Red Black Tree dopo l'inserimento di un nodo
void RB_fixup ( rb_tree * tree, rb * x );
// Procedura che inserisce una chiave in un Red Black Tree preservandone gli invarianti
void RB_insert( rb_tree * tree, rb * node );
// Procedura che restituisce la stringa associata a una chiave in un Red Black Tree
bool RB_find ( rb *tree, int key );
// Procedura che elimina recorsivamente tutti i nodi di un albero
void RB_clear ( rb *tree );
// Procedura ausiliaria per la visualizzazione dei nodi di un Red Black Tree
void RB_print_node ( rb *n );
// Procedura ricorsiva per la visualizzazione in forma polacca dell'albero
void RB_show ( rb *tree );

//------ Operazioni di inizializzazione
// Inizializza un vettore di n nodi bst precedente allocati, secondo il metodo inittype
void initialise( bst * array, int n, int inittype);
// Inizializza un vettore di n nodi avl precedente allocati, secondo il metodo inittype
void initialise( avl * array, int n, int inittype);
// Inizializza un vettore di n nodi rbt precedente allocati, secondo il metodo inittype
void initialise( rb * array, int n, int inittype);

// Inizializza i nodi con chiavi casuali
void initialise_random_array ( bst * array, int n );
// Inizializza i nodi con chiavi casuali
void initialise_random_array ( avl * array, int n );
// Inizializza i nodi con chiavi casuali
void initialise_random_array ( rb * array, int n );

// Inizializza i nodi con chiavi crescenti
void initialise_linear_array ( bst * array, int n );
// Inizializza i nodi con chiavi crescenti
void initialise_linear_array ( avl * array, int n );
// Inizializza i nodi con chiavi crescenti
void initialise_linear_array ( rb * array, int n );

// Inizializza i nodi in modo che l'albero risultante sia bilanciato
int initialise_balanced_array ( bst *arr, int p, int q, int i, int n );
// Inizializza i nodi in modo che l'albero risultante sia bilanciato
int initialise_balanced_array ( avl *arr, int p, int q, int i, int n );
// Inizializza i nodi in modo che l'albero risultante sia bilanciato
int initialise_balanced_array ( rb *arr, int p, int q, int i, int n );

//------ Operazioni per l'esecuzione delle operazioni

// Esegue n operazioni di ricerca e m <= n operazioni di inserimento nell'albero tree, prelevando i nodi dall'array array
void execute_operations ( int n, bst * array, bst_tree * tree );
// Esegue n operazioni di ricerca e m <= n operazioni di inserimento nell'albero tree, prelevando i nodi dall'array array
void execute_operations ( int n, avl * array, avl_tree * tree );
// Esegue n operazioni di ricerca e m <= n operazioni di inserimento nell'albero tree, prelevando i nodi dall'array array
void execute_operations ( int n, rb * array, rb_tree * tree );


//------ Metodi getTimes
#define INSERTTIMES

typedef struct InsertTimes InsertTimes;

struct InsertTimes{

    long time;
    double std_deviation;

};

// Utility per la differenza tra struct timespec
int timespec_subtract(struct timespec *result, struct timespec *x, struct timespec *y);
// Calcola la deviazione standard di un vettore di tempi
double getStdDeviation(long *times, int len);
// Procedura per calcolare la risoluzione del sistema
long getResolution();
// Procedura per la registrazione dei tempi ammortizzati di ricerca e inserimento
InsertTimes getTimes(int Ni, struct timespec *t_min);
