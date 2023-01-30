/*
Si scriva un programma che conti le modifiche ad un file
(specificato come primo argomento sulla riga di comando)
nell’arco di un intervallo di tempo specificato in secondi come
secondo argomento sulla linea di comando
*/

#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <time.h>
#define DIM 10

int main(int argc, char** argv){

    if(argc < 3){ //non è stata inserita alcuna opzione
        printf("Specificare l'intervallo in secondi e il nome di un file.\n");
        return 0;
    }

    char *endptr = NULL;
    int intervalloTempo = strtol(argv[1], &endptr, 10); //conversione string to long

    int fileDescriptor = open(argv[0],O_RDONLY);
    
    if(fileDescriptor == -1) { //errore di apertura, open ritorna -1
        fprintf(stderr, "Errore nell’apertura del file!\n"); 
        return 2;
    }

    struct stat sb; //struttura che contiene le proprieta' del file

    if(fstat(fileDescriptor,&sb) == -1) {
        fprintf(stderr, "%s: errore nell’accesso al file %s: %s\n",
        argv[0], fileDescriptor, strerror(errno));
        return 1;
    }

    clock_t before = clock(); //mi salvo il tempo corrente
    int countModifiche = 0; //counter delle modifiche
    time_t tempoDaConfrontare = sb.st_mtime; //mi salvo il parametro del file.. ultima modifica

    while(before <= intervalloTempo) {
        
        if(stat(fileDescriptor, &sb) == -1) {
            fprintf(stderr, "%s: errore nell’accesso al file %s: %s\n",
            argv[0], fileDescriptor, strerror(errno));
            return 1;
        }

        if(sb.st_mtime != tempoDaConfrontare) {
            printf("Il file %s e’ stato modificato\n", fileDescriptor);
            countModifiche++;
            tempoDaConfrontare = sb.st_mtime; //aggiorno lo stato
            return 0;
        }

        sleep(intervalloTempo);
    }

    printf("Il file %s è stato modificato %d volte negli ultimi %ld secondi\n",
         fileDescriptor, countModifiche, intervalloTempo);

    close(fileDescriptor);
    return 0;
}