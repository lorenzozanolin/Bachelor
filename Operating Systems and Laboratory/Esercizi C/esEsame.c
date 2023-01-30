#include <stdio.h>
#include <stdlib.h>

int main(){

    int rows,columns;
    printf("Inserisci il n. di righe e di colonne della matrice\n");
    scanf("%d %d",&rows,&columns);

    int ** matrix = malloc(sizeof(int*)*rows); //la matrice va vista come un vettore di vettori, ogni riga è un vettore
    printf("Inserisci gli elementi della matrice :\n");

    for(int i=0;i<rows;i++){
        int * row = malloc(sizeof (int)* columns); //inserisco il vettore riga
        for(int j=0;j<columns;j++){
            printf("Inserisci l’elemento a%d%d:\n",i,j);
            scanf("%d",&row[j]);
        }
        matrix[i]=row;                              //mi sposto alla riga successiva
    }
    printf("Matrice inserita:\n");
    for(int i=0;i<rows;i++){
        for(int j=0;j<columns;j++){
            printf("%d ",matrix[i][j]);
        }
        printf("\n");
    }

    int **trasposta = malloc(sizeof (int*)*rows);
    for(int i=0;i<rows;i++){
        int * row2 = malloc(sizeof (int)* columns);
        for(int j=0;j<columns;j++){
            row2[j]= matrix[j][i];
        }
        trasposta[i]=row2;
    }

    printf("Matrice trasposta:\n");
    for(int i=0;i<rows;i++){
        for(int j=0;j<columns;j++){
            printf("%d ",trasposta[i][j]);
        }
        printf("\n");
    }

    return 0;
}
