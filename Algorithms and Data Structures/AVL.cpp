/*
 *   Bazzana Lorenzo, mat. 147569
 *   D'Ambrosi Denis, mat. 147681
 *   Zanolin Lorenzo, mat. 148199
 *
 *   Questo file contiene le istruzioni per le operazioni con strutture dati di tipo AVL
 *
*/

#include <iostream>
#include <sstream>
#include <string>
#include <math.h>

using namespace std;

typedef struct AVLnode node; //proprieta' degli AVL: e' un BST e per ogni nodo x, | x.left->h - x.right->h | <= 1

struct AVLnode { //struttura utilizzata per rappresentare l'albero AVL
    int key;
    int height;
    string value;
    AVLnode *left;
    AVLnode *right;
};

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//PROCEDURE AUSILIARIE 

int AVL_height ( node * tree ) { //ritorna l'altezza del nodo passato come parametro
    if ( tree == NULL ) {
        return 0;
    }
    return tree->height;
}

int AVL_get_balance ( node * n ) {  //procedura ausiliaria per verificare la proprieta' dell'AVL
    if ( n == NULL ) {
        return 0;
    }
    return AVL_height( n->left ) - AVL_height( n->right ); //ritorna la differenza di altezza tra i due (nodi) figli del nodo passato come parametro 
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//PROCEDURE DI RIBILANCIAMENTO (vengono effettuate dopo l'inserimento)

node * AVL_right_rotate( node * n ) { //procedura che effettua la rotazione verso dx dell'albero
    node *x = n->left;
    node *y = x->right;
    x->right = n; //ora x diventa la nuova root e la vecchia root (n) diventa figlio dx
    n->left = y; //il vecchio figlio dx di x ora diventa figlio sx di n
    n->height = max( AVL_height(n->left), AVL_height(n->right) ) + 1; //setto come altezza del nodo corrente l'altezza massima tra i due figli + 1
    x->height = max( AVL_height(x->left), AVL_height(x->right) ) + 1; //setto come altezza del nodo corrente l'altezza massima tra i due figli + 1
    return x;
}

node * AVL_left_rotate( node * n ) { //procedura che effettua la rotazione verso sx dell'albero
    node *x = n->right; 
    node *y = x->left; 
    x->left = n; //ora x diventa la nuova root, analogo a rightRotate
    n->right = y;
    n->height = max( AVL_height(n->left), AVL_height(n->right) ) + 1; //setto come altezza del nodo corrente l'altezza massima tra i due figli + 1
    x->height = max( AVL_height(x->left), AVL_height(x->right) ) + 1; //setto come altezza del nodo corrente l'altezza massima tra i due figli + 1
    return x;
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//INSERIMENTO (ricorsivo)

node * AVL_insert_node ( node *tree, int key, string value ) {
    if ( tree == NULL  ) {  //se l'albero inizialmente era vuoto allora creo il primo nodo 
        node *n = new node;
        n->key = key;
        n->value = value;
        n->right = NULL;
        n->left = NULL;
        n->height = 1; //l'altezza iniziale e' 1
        return n;
    } else {
        if ( key < tree->key ) { //inserimento ricorsivo a sx
            tree->left = AVL_insert_node( tree->left, key, value );
        } else { //inserimento ricorsivo a dx
            tree->right = AVL_insert_node( tree->right, key, value );
        }
        tree->height = max( AVL_height( tree->left ), AVL_height( tree->right ) ) + 1; //dopo aver inserito il figlio aggiorno l'altezza della radice
        
        int balance = AVL_get_balance( tree ); //verifica che la proprieta' dell'AVL sia rispettata
        if ( balance > 1 && key < tree->left->key ) { //caso 1a : sbilanciato a sx 
            return AVL_right_rotate( tree );
        }
        if ( balance < -1 && key > tree->right->key ) { //caso 1b : sbilanciato a dx
            return AVL_left_rotate( tree );
        }
        if ( balance > 1 && key > tree->left->key ) {  //caso sfortunato a : ribilancio a dx e poi ritorno nel caso 1a
            tree->left =  AVL_left_rotate( tree->left );
            return AVL_right_rotate( tree );
        }
        if ( balance < -1 && key < tree->right->key ) { //caso sfortunato b : ribilancio a sx e poi ritorno nel caso 1b
            tree->right = AVL_right_rotate( tree->right ); 
            return AVL_left_rotate( tree );
        }
        return tree;
    }
}

node * AVL_min_value_node ( node *tree ) { //procedura che ricerca il minimo nell'albero, dato che e' bst e' il figlio piu in basso a sx
    while ( tree->left != NULL ) {
        tree = tree->left;
    }
    return tree;
}


//---------------------------------------------------------------------------------------------------------------------------------------------------------

//RICERCA DI UN NODO (ricorsivo)

string AVL_find ( node *tree, int key ) { //ricerca del valore del nodo all'interno dell'albero
    if ( tree->key == key ) { //se trova la chiave
        return tree->value;
    } else if ( key < tree->key ) { //altrimenti si sposta su uno dei due figli
        return AVL_find( tree->left, key );
    } else {
        return AVL_find( tree->right, key );
    }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//ELIMINAZIONE ALBERO (ricorsivo)

void AVL_clear ( node *tree ) { //procedura per eliminare completamente l'albero
    if ( tree == NULL ) {
        return;
    } else {
        AVL_clear( tree->left );
        AVL_clear( tree->right);
        delete tree;
        tree = NULL;
    }
}

void AVL_print_node ( node *n ) { //procedura che stampa i valori di un nodo
    cout << n->key << ":" << n->value << ":" << n->height << " ";
}

void AVL_show ( node *tree ) { //procedura che stampa l'albero in notazione polacca
    if ( tree != NULL ) {
        AVL_print_node( tree );
        AVL_show( tree->left );
        AVL_show( tree->right );
    } else {
        cout << "NULL ";
    }
}

int main () {
    node *tree = NULL;
    string s;
    int k;
    string v;
    while ( 0 == 0 ) {
        cin >> s;
        if ( s == "insert" ) {
            cin >> v;
            k = stoi( v );
            cin >> v;
            tree = AVL_insert_node( tree, k, v );
        } else if ( s == "find" ) {
            cin >> v;
            k = stoi( v );
            cout << AVL_find (tree, k ) << "\n";
        } else if ( s == "clear" ) {
            AVL_clear( tree );
        } else if ( s == "show" ) {
            AVL_show( tree );
            cout << "\n";
        } else if ( s == "height" ) {
            cout << AVL_height( tree ) << "\n";
        } else {
            return 0;
        }
    }
    return 0;
}