/*
Scrivere un programma C, versione semplificata del comando
Unix cmp per il confronto di due file, che stampa la prima
linea su cui i file differiscono
*/
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#define SIZE 1000 //nr massimo di caratteri

int main(){

    FILE *file1 = fopen("C:/Users/User/Desktop/file1.txt", "r"); //apro il primo file
    FILE *file2 = fopen("C:/Users/User/Desktop/file2.txt", "r");
    int counter=1;

    if(!file1) {
        fprintf(stderr, "Errore nell’apertura del primo file!\n");
        return 2;
    }

    if(!file2) {
        fprintf(stderr, "Errore nell’apertura del secondo file!\n");
        return 2;
    }

    char *stringa1 = malloc(SIZE * sizeof(char)); //riga del primo file --> IMPORTANTE ALLOCARE LA MEMORIA DELLA STRINGA SENNO NON POSSO SALVARCI DENTRO NIENTE
    char *stringa2 = malloc(SIZE * sizeof(char)); //riga del secondo file

    while(fgets(stringa1,SIZE,file1) != NULL && fgets(stringa2,SIZE,file2) != NULL){ //cosi legge riga per riga
        if(strcmp(stringa1,stringa2) == 0)
            counter++;
        else{
            printf("I due file differiscono alla riga numero %d\n",counter);
            break;
        }
    }

    fclose(file1);
    fclose(file2);
    return 0;
}