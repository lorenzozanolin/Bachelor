#include <iostream>
#include <string>
#include <sstream>

using namespace std;

typedef struct node node;

struct node {
    int key;
    node* left;
    node* right;
};

struct node *build_tree() {
    string s;
    cin >> s;
    if ( s == "NULL" ) {
        return NULL;
    }
    int key = stoi(s);
    struct node *n = (node *) malloc(sizeof(node));
    n->key = key;
    node *left = build_tree();
    node *right = build_tree();
    n->left = left;
    n->right = right;
    return n;
}

void print_tree ( node *n ) {
    if ( n == NULL ) {
        return;
    } else {
        print_tree ( n->left );
        cout << n->key << " ";
        print_tree ( n->right );
    }
}

int main () {
    node *tree = build_tree();
    print_tree( tree );
    return 0;
}