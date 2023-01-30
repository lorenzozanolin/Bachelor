ESAME 06.07.2018

1.
cat /etc/passwd | cut -d: -f3

2.
output=$(cat /etc/passwd | cut -d: -f3)
count=0
for $i in $output
  count=$[$count + $i]
  i=$[$i+1]
echo $count
exit 0

3.
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

4.
printf("%d\n",(++x)+*p); -> 4
*p=1;
printf("%d\n",*p+(++x)); -> 3

5.
----- 1
pthread_mutex_t mutex=PTHREAD_MUTEX_INITIALIZER;
----- 2
if(pthread_create(&thread[i], NULL ,(void *)&update_log ,(void *) msg[i]) !=0)
----- 3
pthread_mutex_lock(&mutex);
----- 4
strcpy(visit_log, (char *) ptr);
----- 5
pthread_mutex_unlock(&mutex);
