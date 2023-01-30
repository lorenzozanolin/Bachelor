ESAME 28.06.2019

1.
find -type d -ls | grep 'r.xr.xr.x'

2.
if ! test -d $1
then
 echo Inserire una directory valida
fi

nFile=$(find $1 -type f | wc -l)
nDir=$(find $1 -type d | wc -l)
echo numero file: $nFile
echo numero dir: $nDir
exit 0

3.
#include<stdio.h>
#include<stdlib.h>

struct node_t{
    int data;
    struct node_t *left;
    struct node_t *right;
};

typedef struct node_t Node;

void listPrint(Node *);
void delete_node(Node *root);

int main(){

    printf("Inserimento nodo");
    Node *tree = malloc(sizeof(Node));
    tree->data = 3;

    tree->left = malloc(sizeof(struct node_t));
    tree->right = malloc(sizeof(struct node_t));
    tree->left->data = 2;
    tree->left->right =  NULL;
    tree->left->left = NULL;

    tree->right->data = 5;
    tree->right->left = malloc(sizeof(struct node_t));
    tree->right->left->data = 4;
    tree->right->left->right = NULL;
    tree->right->left->left = NULL;

    tree->right->right = malloc(sizeof(struct node_t));
    tree->right->right->data = 7;
    tree->right->right->left = malloc(sizeof(struct node_t));
    tree->right->right->left->data =6;
    tree->right->right->right= NULL;
    listPrint(tree);
    delete_node(root);
    return 0;
}

void delete_node(Node * root){
    if(root->left == NULL && root->right == NULL){
        free(root);
    }
    else{
        if(root->right != NULL)
            delete_node(root->right);
        if(root->left  != NULL)
            delete_node(root->left);
    }
}

4.
|||||
 |||
  |

5.
1-> pthread_mutex_lock(&mutex);
2-> if(full()) pthread_cond_wait(&not_full_buffer,&mutex);
3-> pthread_cond_signal(&not_empty);
4-> pthread_mutex_unlock(&mutex);
5-> pthread_mutex_lock(&mutex);
6-> if(empty()) pthread_cond_wait(&not_empty,&mutex);
7-> pthread_cond_signal(&not_full_buffer);
8-> pthread_mutex_unlock(&mutex);
