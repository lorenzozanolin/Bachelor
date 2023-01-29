/*
 *   Bazzana Lorenzo, mat. 147569
 *   D'Ambrosi Denis, mat. 147681
 *   Zanolin Lorenzo, mat. 148199
 *
 *   Questo file contiene le istruzioni per le operazioni con strutture dati di tipo Red Black Tree
 *
*/

#include <iostream>
#include <sstream>
#include <string>
#include <math.h>

using namespace std;

typedef struct node node;
typedef struct tree tree;

/*
*   PROPRIETA' RB Tree:
*   1) Ogni nodo è rosso o nero
*   2) La radice è nera
*   3) Ogni foglia (rappresentata dal NULL) è nera
*   4) Se un nodo è rosso, entrambi i suoi figli sono neri
*   5) Per ogni nodo, tutti i cmmini semplici che vnno dal nodo alle foglie sue discendenti contengono lo stesso numero di nodi neri
*/
struct node {
    int key;
    string color;
    string value;
    node *left;
    node *right;
    node *parent;
};

// Struttura ausiliaria per tenere traccia del puntatore alla radice dell'albero
struct tree {
    node * root;
};

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//PROCEDURE AUSILIARIE

// Procedura che ritorna true se il nodo è del colore specificato, false altrimenti (le foglie sono black per definizione)
bool RB_check_color ( node * n, string color ) {
    if ( n == NULL && color == "black" ) {
        return true;
    }
    if ( n != NULL && n->color == color ) {
        return true;
    }
    return false;
}

// Procedura che ritorna il puntatore al parent di un nodo se esso esiste, NULL altrimenti
node * RB_parent ( node * n ) {
    if ( n != NULL ) {
        return n->parent;
    }
    return NULL;
}

// Procedura che ritorna il puntatore al parent del parent di un nodo, se esso e il suo parent esistono
node * RB_grandparent ( node * n ) {
    if ( n != NULL && n->parent != NULL ) {
        return n->parent->parent;
    }
    return NULL;
}

// Procedura che restituisce il figlio opposto del padre del nodo fornito, se questi ultimi due esistono
node * RB_sibling ( node * n ) {
    if ( n != NULL && n->parent != NULL ) {
        if ( n == n->parent->left ) {
            return n->parent->right;
        } else if ( n == n->parent->right ) {
            return n->parent->left;
        }
    }
    return NULL;
}

// Procedura che restituisce lo zio del nodo fornito, se esso, il suo padre e il suo nonno esistono, NULL altrimenti
node * RB_uncle ( node * n ) {
    if ( n != NULL && n->parent != NULL && n->parent->parent != NULL ) {
        node * p = RB_parent( n );
        node * g = RB_grandparent( n );
        if ( p == g->left ) {
            return g->right;
        } else if ( p == g->right ) {
            return g->left;
        }
    }
    return NULL;
}

// Procedura ausiliaria che controlla se lo zio del nodo fornito è sullo stesso lato di quest'ultimo rispetto al parent/grandparent
bool RB_check_if_uncle_on_same_side ( node * n ) {
    bool left;
    if ( RB_parent(n)->left == n ) {
        left = true;
    } else {
        left = false;
    }
    if ( (RB_grandparent(n)->left == RB_uncle(n) && left) || (RB_grandparent(n)->right == RB_uncle(n) && !left) ) {
        return true;
    } else {
        return false;
    }
}

// Procedura che cambia il colore a un nodo se è non-NULL
void RB_change_color ( node * n, string color ) {
    if ( n != NULL ) {
        n->color = color;
    }
}


//---------------------------------------------------------------------------------------------------------------------------------------------------------

//PROCEDURE DI RIBILANCIAMENTO (vengono effettuate dopo l'inserimento)

// Procedura che scambia 6 puntatori per ribilanciare il peso ruotando nodi verso in senso antiorario rispetto a un nodo perno, pur preservando gli invarianti dei BST
void RB_left_rotate ( tree *tree, node * x) {
    node * y = x->right;
    node * b = y->left;
    if ( b != NULL ) {
        b->parent = x;
    }
    x->right = b;
    y->left = x;
    y->parent = x->parent;
    x->parent = y;
    if ( y->parent != NULL ) {
        if ( y->parent->left == x ) {
            y->parent->left = y;
        } else {
            y->parent->right = y;
        }
    } else {
        tree->root = y;
    }
}

// Procedura che scambia 6 puntatori per ribilanciare il peso ruotando nodi verso in senso orario rispetto a un nodo perno, pur preservando gli invarianti dei BST
void RB_right_rotate ( tree * tree, node * x ) {
    node * y = x->left;
    node * b = y->right;
    if ( b != NULL ) {
        b->parent = x;
    }
    x->left = b;
    y->right = x;
    y->parent = x->parent;
    x->parent = y;
    if ( y->parent != NULL ) {
        if ( y->parent->left == x ) {
            y->parent->left = y;
        } else {
            y->parent->right = y;
        }
    } else {
        tree->root = y;
    }
}

// Procedura che ristabilisce gli invarianti dei Red Black Tree dopo l'inserimento di un nodo
void RB_fixup ( tree * tree, node * x ) {
    // Quando x non è più figlio di rosso, tutti gli invarianti dei Red Black Tree sono di nuovo inviolati
    while ( RB_check_color(RB_parent(x), "red") ) {
        // Possibilità A: lo zio di x è il fratello destro del padre di x, quindi l'obiettivo è quello di ruotare a destra per ribilanciare il peso dell'albero col nuovo nodo aggiunto
        if ( RB_grandparent(x) != NULL && RB_grandparent(x)->left == RB_parent(x) ) {
            // Caso 1: Se lo zio di x è nero ed è dal lato opposto di quest'ultimo, effettuo una rotazione, ricoloro e ho finito
            if ( RB_check_color(RB_uncle(x), "black") && !RB_check_if_uncle_on_same_side(x) ) {
                node * g = RB_grandparent( x );
                RB_right_rotate( tree, g );
                RB_change_color( RB_parent(x), "black" );
                RB_change_color( g, "red" );
            // Caso 2: Se lo zio di x è nero, ma è dal suo stesso lato, effettuo una rotazione e mi riconduco al caso 1, che terminerà subito
            } else if ( RB_check_color(RB_uncle(x), "black") && RB_check_if_uncle_on_same_side(x) ) {
                node * p = RB_parent(x);
                RB_left_rotate( tree, p );
                x = p;
            // Caso 3: Se lo zio di x è rosso, non posso spostare peso ruotando verso sinistra, quindi ricoloro e sposto il problema verso l'alto
            } else if ( RB_check_color(RB_uncle(x), "red") ) {
                RB_change_color( RB_parent(x), "black" );
                RB_change_color( RB_uncle(x), "black");
                RB_change_color( RB_grandparent(x), "red");
                x = RB_grandparent(x);
            }
        // Possibilità B: analoga alla precedente, ma con lo zio fratello sinistro del padre di x
        } else {
            if ( RB_check_color(RB_uncle(x), "black") && !RB_check_if_uncle_on_same_side(x) ) {
                node * g = RB_grandparent( x );
                RB_left_rotate( tree, g );
                RB_change_color( RB_parent(x), "black" );
                RB_change_color( g, "red" );
            } else if ( RB_check_color(RB_uncle(x), "black") && RB_check_if_uncle_on_same_side(x) ) {
                node * p = RB_parent(x);
                RB_right_rotate( tree, p );
                x = p;
            } else if ( RB_check_color(RB_uncle(x), "red") ) {
                RB_change_color( RB_parent(x), "black" );
                RB_change_color( RB_uncle(x), "black");
                RB_change_color( RB_grandparent(x), "red");
                x = RB_grandparent(x);
            }
        }
    }
    // Se spostando il problema verso l'alto sono giunto alla radice, è sufficiente ricolorarla di nero e tutti gli invarianti saranno di nuovo preservati
    RB_change_color( tree->root, "black" );
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//INSERIMENTO (ricorsivo)

// Procedura che inserisce una coppia chiave-stringa in un Red Black Tree preservandone gli invarianti
void RB_insert( tree * tree, int key, string value ) {
    // Creo il nuovo nodo con i dati forniti in input
    node * n = new node;
    n->key = key;
    n->parent = n->right = n->left = NULL;
    n->color = "red";
    n->value = value;
    // Scendo nell'albero utilizzando la ricerca dicotomica fino a trovare una foglia
    node * y = NULL;
    node * x = tree->root;
    while ( x != NULL ) {
        y = x;
        if ( key < x->key ) {
            x = x->left;
        } else {
            x = x->right;
        }
    }
    // Stabilisco la relazione tra il nuovo nodo e il suo parent
    n->parent = y;
    if ( y == NULL ) {
        tree->root = n;
    } else if ( n->key < y->key ) {
        y->left = n;
    } else {
        y->right = n;
    }
    // Ripristino eventuali invarianti alterati dall'inserimento
    RB_fixup ( tree, n );
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//RICERCA DI UN NODO (ricorsivo)

// Procedura che restituisce la stringa associata a una chiave in un Red Black Tree
string RB_find ( node *tree, int key ) {
    if ( tree->key == key ) {
        return tree->value;
    } else if ( key < tree->key ) {
        return RB_find( tree->left, key );
    } else {
        return RB_find( tree->right, key );
    }
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------

//ELIMINAZIONE ALBERO (ricorsivo)

// Procedura che elimina recorsivamente tutti i nodi di un albero
void RB_clear ( node *tree ) {
    if ( tree == NULL ) {
        return;
    } else {
        RB_clear( tree->left );
        RB_clear( tree->right);
        delete tree;
        tree = NULL;
    }
}

// Procedura ausiliaria per la visualizzazione dei nodi di un Red Black Tree
void RB_print_node ( node *n ) {
    cout << n->key << ":" << n->value << ":" << n->color << " ";
}

// Procedura ricorsiva per la visualizzazione dell'albero
void RB_show ( node *tree ) {
    if ( tree != NULL ) {
        RB_print_node( tree );
        RB_show( tree->left );
        RB_show( tree->right );
    } else {
        cout << "NULL ";
    }
}

int main () {
    tree *tree = new struct tree;
    tree->root = NULL;
    string s;
    int k;
    string v;
    while ( 0 == 0 ) {
        cin >> s;
        if ( s == "insert" ) {
            cin >> v;
            k = stoi( v );
            cin >> v;
            RB_insert( tree, k, v );
        } else if ( s == "find" ) {
            cin >> v;
            k = stoi( v );
            cout << RB_find ( tree->root, k ) << "\n";
        } else if ( s == "clear" ) {
            RB_clear( tree->root );
            tree = NULL;
        } else if ( s == "show" ) {
            RB_show( tree->root );
            cout << "\n";
        } else {
            return 0;
        }
    }
    return 0;
}
