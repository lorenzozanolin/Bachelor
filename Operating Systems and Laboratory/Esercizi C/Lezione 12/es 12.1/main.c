#include "list.h" //cosi non devo includere stdio e stdlbin

//Prova di inserimento e visualizzazione di una lista
int main(){

    int n = 0;
    printf("Inserisci un numero, io creo la lista. \n");
    struct node * lista = create(scanf("%d",&n));

    printf("Ora la visualizzo \n");
    printlist(lista);
    return 0;
}