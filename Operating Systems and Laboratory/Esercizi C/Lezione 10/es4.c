/*
Scrivere un programma che legga una sequenza di numeri dallo standard
input, e:
􏰀 Se l’utente ha passato l’opzione -r sulla riga di comando, stampi i numeri in ordine inverso.
􏰀 Se l’utente ha passato l’opzione -s, stampi i numeri ordinati in senso crescente.
􏰀 Se l’utente ha passato l’opzione -S, stampi i numeri ordinati in senso decrescente.
􏰀 Se l’utente non ha passato alcuna opzione, stampare un messaggio di errore e non fare nulla (ancora prima di leggere alcunché)
-->  ./args _ _ _
*/
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

void stampa(int*, int);
void reverseStampa(int* ,int);
void ascendingSort(int*, int);
void descendingSort(int*,int);

int main(int argc, char** argv){
  //CONTROLLO INIZIALE
  if(argc < 2){ //non è stata inserita alcuna opzione
    printf("Non hai immesso alcuna opzione.");
    return 0;
  }

  int n=0;
  while(n == 0){
  //argc -> numero di elementi in input + cosa fare
  printf("Quanti numeri verranno inseriti? ");
  scanf("%d", &n);
  if(n == 0) printf("Inserire un numero maggiore di zero!");
  }

  /*
  Se volessi fare un inserimento dove non chiedo il numero di elementi in input, usando quindi malloc e realloc
    int size = 10;
    int *array = malloc(size * sizeof(int));
    int read = 0;

    while(scanf("%d", &array[read]) == 1) {
      if(++read == size) {
        size *= 2;
        array = realloc(array, size * sizeof(int));
      }
    }
  */

  int arr[n]; //oppure invece che instanziare un array cosi potevo usare la malloc() --> int *arr = malloc(n*sizeof(int))
  int i=0;
  //inserimento nel vettore
  while (i < n && scanf("%d", &arr[i]) == 1) {
                i++;
            }

  if(strcmp(argv[1],"-r") == 0){  //controllo sul primo elemento, ovvero la prima stringa
    reverseStampa(arr,n);
  }

  if(strcmp(argv[1],"-s") == 0){  //controllo sul primo elemento, ovvero la prima stringa
    ascendingSort(arr,n);
    stampa(arr,n);
  }

  if(strcmp(argv[1],"-S") == 0){  //controllo sul primo elemento, ovvero la prima stringa
    descendingSort(arr,n);
    stampa(arr,n);
  }

  return 0;
}

void stampa(int* vet, int l){
  for(int i = 0;i<l;i++){
    printf("%d\n",*(vet+i)); //stampo il valore puntato
  }

}

void reverseStampa(int* vet, int l){
  for(int i=l-1;i>=0;i--){
    printf("%d\n",vet[i]);
  }
}

void ascendingSort(int *array, int size){
           int j = 0;
           int key = 0;
        for (int i = 1; i < size; ++i) {
            j = i - 1;
                   key = *(array + i);
                   while (j >= 0 && *(array + j) >= key) {
                           *(array + j + 1) = *(array + j);
                           j = j - 1;
                   }
                   *(array + j + 1) = key;
        }
}

void descendingSort(int *array, int size){
            int j = 0;
            int key = 0;
            for (int i = 1; i < size; ++i) {
                    j = i - 1;
                    key = *(array + i);
                    while (j >= 0 && *(array + j) <= key) {
                            *(array + j + 1) = *(array + j);
                            j = j - 1;
                    }
                    *(array + j + 1) = key;
           }
}
