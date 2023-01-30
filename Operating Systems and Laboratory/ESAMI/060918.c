1.
cat /etc/passwd | cut -d: -f3 | sort -n

2.
limite=$1
output=$(cat /etc/passwd | cut -d: -f3 | sort -n)
for i in $output
 do
  if test $i -gt $limite
   then
    echo $i
  fi
 done
exit 0

3.
#include <stdio.h>
#include <stdlib.h>

int main(){

    int rows;
    printf("Inserisci il n. di righe e di colonne della matrice\n");
    scanf("%d",&rows); //matrice quadrata

    int ** matrix = malloc(sizeof(int*)*rows); //la matrice va vista come un vettore di vettori, ogni riga è un vettore
    printf("Inserisci gli elementi della matrice :\n");

    for(int i=0;i<rows;i++){
        int * row = malloc(sizeof (int)* rows); //inserisco il vettore riga
        for(int j=0;j<rows;j++){
            printf("Elemento a%d%d:\n",i,j);
            scanf("%d",&row[j]);
        }
        matrix[i]=row;                              //mi sposto alla riga successiva
    }
    printf("Matrice inserita:\n");
    for(int i=0;i<rows;i++){
        for(int j=0;j<rows;j++){
            printf("%d ",matrix[i][j]);
        }
        printf("\n");
    }

    int diag=1;

    for(int i=0;i<rows;i++){
      diag=diag*matrix[i][i];
    }
    printf("Prodotto sulla diagonale: %d",diag);
    return 0;
}

4.
printf("%d\n",(++ x)*(*p)); --> stampa 4, prima incrementa x e poi prende il valore col puntatore
printf("%d\n",(*p)*(++ x)); --> stampa 2

5.
1 --> pthread_mutex_lock(&mutex);
2 --> if(full()) pthread_cond_wait(&not_full_buffer,&mutex);
3 --> signal(&not_empty_buffer);
4 --> pthread_mutex_unlock(&mutex);
5 --> pthread_mutex_lock(&mutex);
6 --> if(empty()) pthread_cond_wait(&not_empty_buffer,&mutex);
7 --> signal(&not_full_buffer);
8 --> pthread_mutex_unlock(&mutex);
