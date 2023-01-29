/*
 *   Bazzana Lorenzo, mat. 147569
 *   D'Ambrosi Denis, mat. 147681
 *   Zanolin Lorenzo, mat. 148199
 *
 *   Questo e' il programma per la gestione degli AVL
 *
*/

#include "trees.h"

#include <iostream>
#include <sstream>
#include <string>
#include <math.h>

using namespace std;

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//PROCEDURE AUSILIARIE 

#ifndef AVLTYPE
#define AVLTYPE

typedef struct avl avl; //proprieta' degli AVL: e' un BST e per ogni nodo x, | x.left->h - x.right->h | <= 1
struct avl { //struttura utilizzata per rappresentare l'albero AVL
    int key;
    int height;
    avl *left;
    avl *right;
};
#endif

int AVL_height ( avl * tree ) { //ritorna l'altezza del nodo passato come parametro
    if ( tree == NULL ) {
        return 0;
    }
    return tree->height;
}

int AVL_get_balance ( avl * n ) {  //procedura ausiliaria per verificare la proprieta' dell'AVL
    if ( n == NULL ) {
        return 0;
    }
    return AVL_height( n->left ) - AVL_height( n->right ); //ritorna la differenza di altezza tra i due (nodi) figli del nodo passato come parametro 
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//PROCEDURE DI RIBILANCIAMENTO (vengono effettuate dopo l'inserimento)

avl * AVL_right_rotate( avl * n ) { //procedura che effettua la rotazione verso dx dell'albero
    avl *x = n->left;
    avl *y = x->right;
    x->right = n; //ora x diventa la nuova root e la vecchia root (n) diventa figlio dx
    n->left = y; //il vecchio figlio dx di x ora diventa figlio sx di n
    n->height = max( AVL_height(n->left), AVL_height(n->right) ) + 1; //setto come altezza del nodo corrente l'altezza massima tra i due figli + 1
    x->height = max( AVL_height(x->left), AVL_height(x->right) ) + 1; //setto come altezza del nodo corrente l'altezza massima tra i due figli + 1
    return x;
}

avl * AVL_left_rotate( avl * n ) { //procedura che effettua la rotazione verso sx dell'albero
    avl *x = n->right; 
    avl *y = x->left; 
    x->left = n; //ora x diventa la nuova root, analogo a rightRotate
    n->right = y;
    n->height = max( AVL_height(n->left), AVL_height(n->right) ) + 1; //setto come altezza del nodo corrente l'altezza massima tra i due figli + 1
    x->height = max( AVL_height(x->left), AVL_height(x->right) ) + 1; //setto come altezza del nodo corrente l'altezza massima tra i due figli + 1
    return x;
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//INSERIMENTO (ricorsivo)

avl * AVL_insert ( avl *tree, avl * node ) {
    if ( tree == NULL  ) {  //se l'albero inizialmente era vuoto allora creo il primo nodo 
        return node;
    } else {
        if ( node->key < tree->key ) { //inserimento ricorsivo a sx
            tree->left = AVL_insert( tree->left, node );
        } else { //inserimento ricorsivo a dx
            tree->right = AVL_insert( tree->right, node );
        }
        tree->height = max( AVL_height( tree->left ), AVL_height( tree->right ) ) + 1; //dopo aver inserito il figlio aggiorno l'altezza della radice
        
        int balance = AVL_get_balance( tree ); //verifica che la proprieta' dell'AVL sia rispettata
        if ( balance > 1 && node->key < tree->left->key ) { //caso 1a : sbilanciato a sx 
            return AVL_right_rotate( tree );
        }
        if ( balance < -1 && node->key > tree->right->key ) { //caso 1b : sbilanciato a dx
            return AVL_left_rotate( tree );
        }
        if ( balance > 1 && node->key > tree->left->key ) {  //caso sfortunato a : ribilancio a dx e poi ritorno nel caso 1a
            tree->left =  AVL_left_rotate( tree->left );
            return AVL_right_rotate( tree );
        }
        if ( balance < -1 && node->key < tree->right->key ) { //caso sfortunato b : ribilancio a sx e poi ritorno nel caso 1b
            tree->right = AVL_right_rotate( tree->right ); 
            return AVL_left_rotate( tree );
        }
        return tree;
    }
}

avl * AVL_min_value_node ( avl *tree ) { //procedura che ricerca il minimo nell'albero, dato che e' bst e' il figlio piu in basso a sx
    while ( tree->left != NULL ) {
        tree = tree->left;
    }
    return tree;
}


//---------------------------------------------------------------------------------------------------------------------------------------------------------

//RICERCA DI UN NODO (ricorsivo)

bool AVL_find ( avl *tree, int key ) { //ricerca del valore del nodo all'interno dell'albero
    if ( tree == NULL ) { // se è arrivato a una foglia
        return false;
    } else if ( tree->key == key ) { //se trova la chiave
        return true;
    } else if ( key < tree->key ) { //altrimenti si sposta su uno dei due figli
        return AVL_find( tree->left, key );
    } else {
        return AVL_find( tree->right, key );
    }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//ELIMINAZIONE ALBERO (ricorsivo)

void AVL_clear ( avl *tree ) { //procedura per eliminare completamente l'albero
    if ( tree == NULL ) {
        return;
    } else {
        AVL_clear( tree->left );
        AVL_clear( tree->right);
        delete tree;
        tree = NULL;
    }
}

void AVL_print_node ( avl *n ) { //procedura che stampa i valori di un nodo
    cout << n->key << ":"  << n->height << " ";
}

void AVL_show ( avl *tree ) { //procedura che stampa l'albero in notazione polacca
    if ( tree != NULL ) {
        AVL_print_node( tree );
        AVL_show( tree->left );
        AVL_show( tree->right );
    } else {
        cout << "NULL ";
    }
}

