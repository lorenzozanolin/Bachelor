/*
Scrivere un programma che, dato il nome di un file sulla riga
di comando, ne mostri il contenuto lanciando il comando ‘cat’
in modo equivalente al seguente comando da terminale: $ cat < file
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

int main(int argc, char **argv)
{
  if(argc < 2) {
    fprintf(stderr, "specificare il nome del file\n");
    return 1;
  }

  int pipes[2] = { }; //creo una pipe (canale di comunicazione)
  if(pipe(pipes) == -1) {
    perror("pipe()");
    return 1;
  }

  int fileDescriptor = open(argv[0],O_RDONLY); //apro il file in lettura
  if(fileDescriptor == -1) { //errore di apertura, open ritorna -1
    fprintf(stderr, "Errore nell’apertura del file!\n"); 
    return 2;
   }

  pid_t cat = fork(); //processo che eseguira' il cat
  switch(cat) {
    case -1:
      perror("fork()");
      exit(2);
    case 0: // figlio
      dup2(pipes[1], 1); // redirigo lo standard output del comando nella pipe come input
      close(pipes[0]); //chiudo il canale di lettura
      execlp("cat", "cat", argv[1], NULL); //eseguo il cat
      perror("cat"); // se arrivo qui, execlp() ha fallito
      return 2;
  } // il padre prosegue

  pid_t leggo = fork();
  switch(leggo) {
    case -1:
      perror("fork()");
      exit(2);
    case 0: // figlio
      close(pipes[1]);
      char * buffer = malloc(1000 * sizeof(char)); //alloco una stringa per l'output
      read(pipes[0], buffer, 1000*sizeof(char)); //mi salvo il contenuto dell'output
      printf("%s\n", buffer); //stampo il contenuto
      break;
  } // il padre prosegue

  close(pipes[0]);
  close(pipes[1]);
  // aspetto entrambi i figli
  waitpid(cat,NULL,0);
  waitpid(leggo,NULL,0);
  return 0;
}