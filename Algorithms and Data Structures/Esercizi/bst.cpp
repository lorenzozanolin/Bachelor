#include <iostream>
#include <sstream>
#include <string>

using namespace std;

typedef struct node node;

struct node {
    int key;
    string value;
    node *left;
    node *right;
};

node * insert_node ( node *tree, int key, string value ) {
    if ( tree == NULL  ) {
        node *n = new node;
        n->key = key;
        n->value = value;
        n->right = NULL;
        n->left = NULL;
        return n;
    } else {
        if ( key < tree->key ) {
            tree->left = insert_node( tree->left, key, value );
        } else {
            tree->right = insert_node( tree->right, key, value );
        }
        return tree;
    }
}

node * min_value_node ( node *tree ) {
    while ( tree->left != NULL ) {
        tree = tree->left;
    }
    return tree;
}

node * delete_node ( node *tree, int key ) {
    if ( tree == NULL ) {
        return tree;
    }
    if ( key < tree->key ) {
        tree->left = delete_node( tree->left, key );
        return tree;
    } else if ( key > tree->key ) {
        tree->right = delete_node( tree->right, key );
        return tree;
    } else {
        if ( tree->left == NULL ) {
            node *temp = tree->right;
            delete tree;
            return temp;
        } else if ( tree->right == NULL ) {
            node *temp = tree->left;
            delete tree;
            return temp;
        } else {
            node *successor = min_value_node( tree->right );
            tree->key = successor->key;
            tree->value = successor->value;
            tree->right = delete_node( tree->right, successor->key );
        }
        return tree;
    }
}

string find ( node *tree, int key ) {
    if ( tree->key == key ) {
        return tree->value;
    } else if ( key < tree->key ) {
        return find( tree->left, key );
    } else {
        return find( tree->right, key );
    }
}

void clear ( node *tree ) {
    if ( tree == NULL ) {
        return;
    } else {
        clear( tree->left );
        clear( tree->right);
        delete tree;
        tree = NULL;
    }
}

void print_node ( node *n ) {
    cout << n->key << ":" << n->value << " ";
}

void show ( node *tree ) {
    if ( tree != NULL ) {
        print_node( tree );
        show( tree->left );
        show( tree->right );
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
            tree = insert_node( tree, k, v );
        } else if ( s == "remove" ) {
            cin >> v;
            k = stoi( v );
            tree = delete_node( tree, k );
        } else if ( s == "find" ) {
            cin >> v;
            k = stoi( v );
            cout << find (tree, k ) << "\n";
        } else if ( s == "clear" ) {
            clear( tree );
        } else if ( s == "show" ) {
            show( tree );
            cout << "\n";
        } else {
            return 0;
        }
    }
    return 0;
}