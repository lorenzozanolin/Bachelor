/*
Si scriva un programma che legga in modalità binaria dieci
numeri interi dal file /dev/urandom, e li stampi sullo schermo,
utilizzando funzioni POSIX per l’accesso ai file
*/
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#define DIM 10

int main(){

    int fileDescriptor = open("/dev/urandom",O_RDONLY);
    int array[DIM]={0}; //array di interi

    if(fileDescriptor == -1) { //errore di apertura, open ritorna -1
        fprintf(stderr, "Errore nell’apertura del file!\n"); 
        return 2;
    }


    int nItems = read(fileDescriptor,array,sizeof(int)*DIM); //legge sizeof(array)bytes dal fd e li salva nell'array

    if(nItems == -1){
        fprintf(stderr, "Errore nella lettura del file!\n"); 
        return 2;
    }
    
    printf("Sono stati letti correttamente %d byte\n",nItems);
    for(int i=0;i<10;i++){
        printf("Posizione %d : %d",i,array[i]);
    }

    close(fileDescriptor);
    return 0;
}