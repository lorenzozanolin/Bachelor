/*
 *   Bazzana Lorenzo, mat. 147569
 *   D'Ambrosi Denis, mat. 147681
 *   Zanolin Lorenzo, mat. 148199
 *
 *   Implementazione albero di ricerca
 *
*/

#include "trees.h"

#include <iostream>
#include <sstream>
#include <string>

using namespace std;

#ifndef BSTTYPE
#define BTSTYPE
typedef struct bst bst;

struct bst {
    int key;
    bst *left;
    bst *right;
};
#endif

// inserisce un nuovo nodo in tree con chiave k intera
// si assume che l'albero non contenga gia' un nodo di chiave k
bst * BST_insert ( bst *tree, bst * node ) { 
    if ( tree == NULL  ) {//se tree e'un albero nuovo creo un nodo con chiave key e valore value
        return node;
    } else {//altrimenti inserisco il nodo nel sottoalbero destro o sinistro
        if ( node->key < tree->key ) {
            tree->left = BST_insert( tree->left, node );
        } else {
            tree->right = BST_insert( tree->right, node );
        }
        return tree;
    }
}

// resituisce il nodo di tree di chiave minima
bst * BST_min_value_node ( bst *tree ) {
    while ( tree->left != NULL ) {
        tree = tree->left;
    }
    return tree;
}

// restituisce true se key è contenuta in tree, false altrimenti
bool BST_find ( bst *tree, int key ) {
    if ( tree == NULL ) {
        return false;
    } else if ( tree->key == key ) {
        return true;
    } else if ( key < tree->key ) {
        return BST_find( tree->left, key );
    } else {
        return BST_find( tree->right, key );
    }
}

// elimina l'albero tree
void BST_clear ( bst *tree ) {
    if ( tree == NULL ) {
        return;
    } else {
        BST_clear( tree->left );
        BST_clear( tree->right);
        delete tree;
        tree = NULL;
    }
}

// stampa la chiave e il valore del nodo n
void BST_print_node ( bst *n ) {
    cout << n->key << " ";
}

// stampa preoder dell'albero tree
void BST_show ( bst *tree ) {
    if ( tree != NULL ) {
        BST_print_node( tree );
        BST_show( tree->left );
        BST_show( tree->right );
    } else {
        cout << "NULL ";
    }
}

