/*
Si scriva un programma che legga in modalità binaria dieci
numeri interi dal file /dev/urandom, e li stampi sullo schermo,
utilizzando funzioni ISO per l’accesso ai file
*/

#include <stdio.h>
#include <errno.h>
#include <string.h>
#define DIM 10

int main(){

    FILE *file = fopen("/dev/urandom", "rb"); //apro il file in modalita' binaria (rb)
    int array[DIM]={0}; //array di interi

    if(!file) {
        fprintf(stderr, "Errore nell’apertura del file!\n");
        return 2;
    }

    int nItems = fread(array,sizeof(int),sizeof(array),file); //legge (dim array = 10) * (dim int) byte dal file e li salva in array. Ritorna il numero di elementi letti

    printf("Sono stati letti correttamente %d byte\n",nItems);
    for(int i=0;i<10;i++){
        printf("Posizione %d : %d",i,array[i]);
    }

    fclose(file);
    return 0;
}