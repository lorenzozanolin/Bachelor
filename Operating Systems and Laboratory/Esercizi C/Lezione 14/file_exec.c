/*
Scrivere un programma C chiamato file_exec, che riceva sulla riga di comando:
- Il nome di un file.
- Un comando da eseguire completo di argomenti, tra cui eventualmente un argomento costituito da un solo simbolo ’@’.
Il programma deve leggere il file riga per riga, eseguendo il
comando specificato nella riga di comando una volta per ogni
riga, sostituendo ad ogni occorrenza di ’@’ nella linea di
comando, il contenuto della riga corrente del file

*/
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#define DIM 1000

//SINTASSI EXECVP --> execvp(cmd,argomenti); es. execvp("ls",argv); e argv[0]="ls", argv[1]="-la", argv[2]="NULL"

char **getParameters(char **,int,char*); //funzione che dati i parametri passati da linea di comando
void removeChar(char *, char); //per rimuovere dal nome dei file contenuti nel file di testo, es il '\r' o '\n'

int main(int argc, char**argv){ 

    FILE *file = fopen(argv[1],"r"); //apro il file in lettura
    char *command = argv[2]; //il comando da eseguire
    char *name = malloc(sizeof(char)*DIM); //contiene il nome di ciascun file contenuto nel file principale

    while(fgets(name,DIM,file) != NULL){
        //devo togliere l'ultimo carattere di name '\n' e sostituirlo con uno 0
        //name = name
        int pid = fork(); //creo un figlio --> il figlio riprende da qua sotto, da dopo la fork
        removeChar(name,'\r'); //rimuovo '\r'
        removeChar(name,'\n'); //rimuovo '\n'
        if(pid == 0){
            printf("\n%s:\n",name); //vado a capo
            execvp(command,getParameters(argv,argc,name)); //esegue il comando -> comando parametri nomefile
            perror("execvp fallita");
        }
        wait(NULL); //aspetta il figlio
    }
    fclose(file);
    free(name);
    return 0;
}

char **getParameters(char **a,int size,char* name ){ //funzione per prendere i parametri passati in input
    char ** parameters = (char **)malloc(sizeof(char *)*(size-1)); //alloco un array di stringhe di dimensione size - 1 perche alla fine devo inserirci un NULL e devo togliere dall'inizio 2 parametri

    for(int i=2;i<size;i++){
        if(strcmp(a[i],"@") != 0) //finche non arriva al carattere @
            parameters[i-2]=a[i]; //si salva il contenuto dei parametri
        else{ //altrimenti se e' arrivato alla @ sostituisce con il nome del file
            parameters[i-2] = name;
        }
    }
    parameters[size-2] = NULL; //ultima posizione deve essere null
    return parameters;

}

void removeChar(char *str, char garbage) {

    char *src, *dst;
    for (src = dst = str; *src != '\0'; src++) {
        *dst = *src;
        if (*dst != garbage) dst++;
    }
    *dst = '\0';
}