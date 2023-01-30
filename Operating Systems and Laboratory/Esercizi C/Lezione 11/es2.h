struct node{
    int data;
    struct node *next;
};

typedef struct node Node; //facendo cosi non devo ogni volta ripetere il tipo

Node * createList(int);
int listLength(Node *);
Node * listFind(Node *,int data);
Node * listLast(Node *);
Node * listAppend(Node *,struct node *);
void listDestroy(Node *);
void listPrint(Node *);