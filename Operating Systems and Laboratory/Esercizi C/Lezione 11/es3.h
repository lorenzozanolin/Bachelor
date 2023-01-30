//albero
struct nodeT
{
    int data;
    struct nodeT *left;
    struct nodeT *right;
    struct nodeT *parent;
};

typedef struct nodeT NodoAlbero;

NodoAlbero * createTree(int);
NodoAlbero * insertTree(NodoAlbero *,int);
NodoAlbero * findTree(NodoAlbero *,int data);
void removeTree(NodoAlbero *,int);
NodoAlbero * deleteTree(NodoAlbero *);
NodoAlbero * findMin(NodoAlbero *);

//liste concatenate
struct node{
    int data;
    struct node *next;
};

typedef struct node NodoLista; //facendo cosi non devo ogni volta ripetere il tipo
void listPrint(NodoLista *);
NodoLista * treetoList(NodoAlbero *);
NodoLista *listAppend(NodoLista*, NodoLista *);
NodoLista *createList(int);
NodoLista *listLast(NodoLista *);