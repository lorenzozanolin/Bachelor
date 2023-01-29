/*
 *   Bazzana Lorenzo, mat. 147569
 *   D'Ambrosi Denis, mat. 147681
 *   Zanolin Lorenzo, mat. 148199
 *
 *   Questo file contiene le istruzioni per le operazioni con strutture dati di tipo BST
 *
*/


#include <iostream>
#include <sstream>
#include <string>

using namespace std;

typedef struct bst bst; //PROPRIETA' BST: ∀ nodo x, ∀y appartenente a Left(x), ∀z appartenente a Right(x) => y < x < z  

struct bst { //struttura utilizzata per rappresentare l'albero AVL
    int key;
    string value;
    bst *left;
    bst *right;
};

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//INSERIMENTO (ricorsivo)

// si assume che l'albero non contenga gia' un nodo di chiave k
bst * bst_insert_node ( bst *tree, int key, string value ) { 
    if ( tree == NULL  ) {//se tree e'un albero nuovo creo un nodo con chiave key e valore value
        bst *n = new bst;
        n->key = key;
        n->value = value;
        n->right = NULL;
        n->left = NULL;
        return n;
    } else {//altrimenti inserisco il nodo nel sottoalbero destro o sinistro
        if ( key < tree->key ) {
            tree->left = bst_insert_node( tree->left, key, value );
        } else {
            tree->right = bst_insert_node( tree->right, key, value );
        }
        return tree;
    }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//PROCEDURE AUSILIARIE 


bst * bst_min_value_node ( bst *tree ) { // resituisce il nodo di tree di chiave minima
    while ( tree->left != NULL ) {
        tree = tree->left;
    }
    return tree;
}


void bst_print_node ( bst *n ) { // stampa la chiave e il valore del nodo n
    cout << n->key << ":" << n->value << " ";
}


void bst_show ( bst *tree ) { // stampa preoder dell'albero tree
    if ( tree != NULL ) {
        bst_print_node( tree );
        bst_show( tree->left );
        bst_show( tree->right );
    } else {
        cout << "NULL ";
    }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//RICERCA DI UN NODO (ricorsivo)

// cerca il nodo di chiave key nell'albero tree
string find ( bst *tree, int key ) {
    if ( tree->key == key ) {
        return tree->value;
    } else if ( key < tree->key ) {
        return find( tree->left, key );
    } else {
        return find( tree->right, key );
    }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//ELIMINAZIONE ALBERO (ricorsivo)

void bst_clear ( bst *tree ) {
    if ( tree == NULL ) {
        return;
    } else {
        bst_clear( tree->left );
        bst_clear( tree->right);
        delete tree;
        tree = NULL;
    }
}



/*int main () {
    bst *tree = NULL;
    string s;
    int k;
    string v;
    while (1) {
        cin >> s;
        if ( s == "insert" ) {
            cin >> v;
            k = stoi( v );
            cin >> v;
            tree = bst_insert_node( tree, k, v );
        } else if ( s == "find" ) {
            cin >> v;
            k = stoi( v );
            cout << find (tree, k ) << "\n";
        } else if ( s == "clear" ) {
            bst_clear( tree );
        } else if ( s == "show" ) {
            bst_show( tree );
            cout << "\n";
        } else {
            return 0;
        }
    }
    return 0;
}*/