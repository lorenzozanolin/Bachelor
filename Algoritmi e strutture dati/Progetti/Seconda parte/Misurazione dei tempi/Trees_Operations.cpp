/*
 *   Bazzana Lorenzo, mat. 147569
 *   D'Ambrosi Denis, mat. 147681
 *   Zanolin Lorenzo, mat. 148199
 *
 *   Questo file contiene le procedure da eseguire per inizializzare i nodi e conseguentemente le chiavi da inserire negli alberi.
 *   Al fine di effettuare l'analisi dei tempi medi e ammortizzati, per escludere i tempi di allocazione della memoria dalla misurazione, è necessario 
 *   infatti predisporre un array di nodi già inizializzati, da ricercare ed inserire poi attraverso le procedure execute_operations().
 *   Gli algoritmi di inizializzazione differiscono dal criterio con cui vengono generate le chiavi da assegnare
 *   ai nodi: in particolare, vengono utilizzate tre tipi di sequenze di interi (pseudocasuale, lineare monotona e
 *   bilanciata) al fine di registrare i tempi d'esecuzione delle operazioni sulle strutture dati nel caso medio, ottimo e pessimo.
 *
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#include "trees.h"

#define RANDOM 0
#define LINEAR 1
#define BALANCED 2

using namespace std;

void initialise( bst * array, int n, int inittype){
    
    switch(inittype){

        case LINEAR: initialise_linear_array( array, n );
        break;
        case BALANCED: initialise_balanced_array( array, 0, n, 0, n);
        break;
        default: initialise_random_array( array, n) ;

    }

}

void initialise( avl * array, int n, int inittype){
    
    switch(inittype){

        case LINEAR: initialise_linear_array( array, n );
        break;
        case BALANCED: initialise_balanced_array( array, 0, n, 0, n);
        break;
        default: initialise_random_array( array, n) ;

    }

}

void initialise( rb * array, int n, int inittype){
    
    switch(inittype){

        case LINEAR: initialise_linear_array( array, n );
        break;
        case BALANCED: initialise_balanced_array( array, 0, n, 0, n);
        break;
        default: initialise_random_array( array, n) ;

    }

}

/*------------------------------- Random Array -------------------------------
 * Queste procedure servono a studiare il caso medio delle operazioni di ricerca/inserimento all'interno degli alberi.
 * A ogni ciclo viene generato un numero casuale..
*/

void initialise_random_array ( bst * array, int n ) {
    srand ( time(NULL) );
    int k;
    for ( int i = 0; i < n; i++ ) {
        k = rand();
        array[i].key = k;
        array[i].left = array[i].right = NULL;
    }
}

void initialise_random_array ( avl * array, int n ) {
    srand ( time(NULL) );
    int k;
    for ( int i = 0; i < n; i++ ) {
        k = rand();
        array[i].key = k;
        array[i].left = array[i].right = NULL;
        array[i].height = 1;
    }
}

void initialise_random_array ( rb * array, int n ) {
    srand ( time(NULL) );
    int k;
    for ( int i = 0; i < n; i++ ) {
        k = rand();
        array[i].key = k;
        array[i].left = array[i].right = array[i].parent = NULL;
        array[i].color = 'r';
    }
}

/*------------------------------- Linear Array -------------------------------
 * Queste procedure servono a studiare il caso peggiore per le operazioni di ricerca/inserimento in un BST.
 * A ogni ciclo viene generato un intero in ordine strettamente crescente (col fine di far degenerare i BST in
 * liste concatenate).
*/

void initialise_linear_array ( bst * array, int n ) {
    for ( int k = 0; k < n; k++ ) {
        array[k].key = k;
        array[k].left = array[k].right = NULL;
    }
}

void initialise_linear_array ( avl * array, int n ) {
    for ( int k = 0; k < n; k++ ) {
        array[k].key = k;
        array[k].left = array[k].right = NULL;
        array[k].height = 1;
    }
}

void initialise_linear_array ( rb * array, int n ) {
    for ( int k = 0; k < n; k++ ) {
        array[k].key = k;
        array[k].left = array[k].right = array[k].parent = NULL;
        array[k].color = 'r';
    }
}


/*------------------------------- Balanced Array -------------------------------
 * Queste procedure servono a studiare le performance dei tre alberi nel caso migliore per le operazioni di ricerca/inserimento in un BST.
 * Preso in considerazione inizialmente una coda contentente solo l'intervallo [0,n-1], vengono estratti sequenzialmente i valori
 * intermedi agli intervalli presenti in coda, che vengono successivamente divisi a metà e rimessi in coda se hanno lunghezza >=1;
 * La terminazione è data dallo svuotamento della coda. 
*/

int initialise_balanced_array(bst *arr, int p, int q, int i, int len){

    if(q-p >= 1 && i < len){

        int r = (q+p)/2;
        arr[i].key = r;
        arr[i].left = NULL;
        arr[i].right = NULL;
        i = initialise_balanced_array(arr, p, r, i+1, len);
        i = initialise_balanced_array(arr, r+1, q, i+1, len);
        return i;

    }

    return i-1;

}

int initialise_balanced_array(avl *arr, int p, int q, int i, int len){

    if(q-p >= 1 && i < len){

        int r = (q+p)/2;
        arr[i].key = r;
        arr[i].left = NULL;
        arr[i].right = NULL;
        arr[i].height = 1;
        i = initialise_balanced_array(arr, p, r, i+1, len);
        i = initialise_balanced_array(arr, r+1, q, i+1, len);
        return i;

    }

    return i-1;

}

int initialise_balanced_array(rb *arr, int p, int q, int i, int len){

    if(q-p >= 1 && i < len){

        int r = (q+p)/2;
        arr[i].key = r;
        arr[i].left = NULL;
        arr[i].right = NULL;
        arr[i].parent = NULL;
        arr[i].color = 'r';
        i = initialise_balanced_array(arr, p, r, i+1, len);
        i = initialise_balanced_array(arr, r+1, q, i+1, len);
        return i;

    }

    return i-1;

}


/*------------------------------- Procedure per l'esecuzione delle operazioni -------------------------------
 * Queste procedure eseguono operazioni di find() ed insert() sull'albero passato come input per misurarne le
 * performance temporali. I nodi devono essere già allocati e inizializzati correttamente all'interno dell'array
 * attraverso la chiamata di una delle procedure di initialise.
 * Le funzioni execute_operations() effettuabo n operazioni di find() e O(n) operazioni di insert().
*/

void execute_operations ( int n, bst * array, bst_tree * tree ) {
    for ( int i = 0; i < n; i++ ) {
        if ( !BST_find(tree->root, array[i].key) ) {
            tree->root = BST_insert( tree->root, &array[i] );
        }
    }
}

void execute_operations ( int n, avl * array, avl_tree * tree ) {
    for ( int i = 0; i < n; i++ ) {
        if ( !AVL_find(tree->root, array[i].key) ) {
            tree->root = AVL_insert( tree->root, &array[i] );
        }
    }
}

void execute_operations ( int n, rb * array, rb_tree * tree ) {
    for ( int i = 0; i < n; i++ ) {
        if ( !RB_find(tree->root, array[i].key) ) {
            RB_insert( tree, &array[i] );
        }
    }
}
