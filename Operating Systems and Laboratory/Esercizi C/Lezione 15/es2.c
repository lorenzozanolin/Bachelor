/*
Scrivere un programma che, dato sulla riga di comando il nome di un file, esegua quanto segue:
- Ogni riga del file sarà del formato:
    -----------------------------------------------
    comando1 arg1 ... argn | comando2 arg2 ... argn
    -----------------------------------------------

- Per ogni tale riga, il programma deve eseguire comando1 e comando2, 
con relativi argomenti, collegando con una pipe lo standard output del primo allo standard input del secondo
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

//SINTASSI EXECVP --> execvp(cmd,argomenti); es. execvp("ls",argv); e argv[0]="ls", argv[1]="-la", argv[2]="NULL"

char **readline(FILE *); //legge da il file una riga e ritorna un' array di stringhe contenente tutte le parole separate
int findDivisor(char **);
void execLines(char **);

int main(int argc, char **argv) {
  if(argc != 2) {
    fprintf(stderr, "Utilizzo: /es2 [file]\n");
    return 1;
  }

  FILE *fp = fopen(argv[1], "r");
  if (!fp) {
    fprintf(stderr, "Errore nell'apertura del file %s\n", argv[1]);
    return 2;
  }


  int divisor; //divisore che salva la posizione del file dove si trova il simbolo di "|" che verrà sostituito con lo 0
  
  while(!feof(fp)) { //finchè non arriva alla fine del file con la lettura della lineaComandi

    int pipes[2] = { }; //crea la pipe
    if(pipe(pipes) == -1) {
      perror("Errore nell'invocazione di pipe()\n");
      return 2;
    }

    char **lineaComandi = malloc(32 * sizeof(char *)); //legge l'intera riga
    lineaComandi = readline(fp); //dalla riga letta si crea un array di stringhe contenente i vari comandi
    divisor = findDivisor(lineaComandi); //sostituisce al posto di "|" uno 0 e restituisce la poszione del divisore

    if (divisor == 0) {
      perror("Inserire una pipe valida\n");
      return 3;
    }

    // PRIMO COMANDO -> mi salvo il primo comando
    char **primoComando = malloc((divisor+1) * sizeof(char*)); 
    for (int i = 0; i < divisor; i++) {
      primoComando[i] = *(lineaComandi+i);
    }
    primoComando[divisor] = NULL; //in ultima posizione ci va sempre un NULL

    pid_t cmd1 = fork(); //processo che lo esegue
    
    switch(cmd1) {
      case -1:
        perror("fork()");
        exit(2);
      case 0: // figlio
        dup2(pipes[1], 1); // redirigo stdout
        close(pipes[0]); //chiudo canale di lettura
        execvp(primoComando[0], primoComando);
        perror("Errore durante l'esecuzione del primo comando\n"); // se arrivo qui, execvp() ha fallito
        return 4;
    } // il padre prosegue

    pid_t cmd2 = fork();
    switch(cmd2) {
      case -1:
        perror("fork()");
        exit(2);
      case 0: // figlio
        close(pipes[1]);
        dup2(pipes[0], 0); // redirigo stdin
        execvp(lineaComandi[divisor+1],(lineaComandi+divisor+1)); //eseguo il secondo comando
        perror("Errore durante l'esecuzione del secondo comando\n"); // se arrivo qui, execlp() ha fallito
    } // il padre prosegue

    // aspetto entrambi i figli
    waitpid(cmd1,NULL,0);
    //waitpid(cmd2,NULL,0);

    free(primoComando);
    free(lineaComandi);

    close(pipes[0]);
    close(pipes[1]);

  }

  return 0;
}


char **readline(FILE *file){

    char * parola = malloc(sizeof(char) * 32); //una singola parola, termina con 0 e ogni volta che trovo uno spazio la salvo nel vettore e la rialloco
    char ** vettParole = malloc(sizeof(char *)*32); //vettore che conterra' tutte le parole della riga
    
    int i=0,j=0; //i contatore dei caratteri di una parola, j contatore di quante parole ho nel vettore riga

    *(vettParole) = malloc(sizeof(char) * 32); //alloco per la prima cella lo spazio

    for(char c=fgetc(file); c!= '\n'; c=fgetc(file)){
        
        if(c == ' '){ //se trova uno spazio vuol dire che una parola e' finita
            parola[i] = 0; //carattere terminatore 
            strcpy((vettParole[j]),parola); //inserisco la parola
            j++;
            i=0; //azzero il counter della parola singola
            free(parola);
            char * parola = malloc(sizeof(char) * 32); //rialloco la parola da inserire
            vettParole[j] = malloc(sizeof(char) * 32); //alloco la cella successiva nell'array
        
        } else if(c == EOF){
            parola[i] = 0; //carattere terminatore 
            strcpy((vettParole[j]),parola); //inserisco la parola
            break;
        
        } else{ //altrimenti se ha trovato un carattere normale
            parola[i]=c; //salvo il cattere letto
            i++; 
        }
    }

    strcpy((vettParole[j]),parola); //nel caso uscisse perche' ha trovato '\n' 
    free(parola);
    return vettParole; //ritorno la riga scritta dentro ad un vettore di char*, esso conterra' anche il carattere "|"
    free(vettParole);
}

int findDivisor(char **lines) { //funzione che trova il divisore dentro il vettore e lo sostituisce con lo 0, in modo che per il primo comando arrivi a leggere (la execvp) fino a li
  int i = 0;
  while (i < 32) {
    if (strcmp(lines[i], "|") == 0) {
      lines[i] = 0; //sostituisco il valore "|" con 0 (null)
      return i;
    }
    i++;
  }
  return 0;
}