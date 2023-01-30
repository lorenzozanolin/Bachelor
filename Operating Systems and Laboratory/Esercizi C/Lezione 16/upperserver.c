#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/un.h> // per struct sockaddr_un
#include <sys/socket.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "common.h"

void upperlines(int in, int out);
void handle_sigchld(int);

int main (int argc, char **argv)
{
  // imposto l'handler per SIGCHLD, in modo da non creare processi zombie
  signal(SIGCHLD, handle_sigchld);

  // apro il socket di ascolto
  int sock = socket(AF_LOCAL, SOCK_STREAM, 0);
  if(sock == -1) {
    perror("socket()");
    return 1;
  }

  // imposto l'indirizzo del socket server
  struct sockaddr_un addr = {
    .sun_family = AF_LOCAL, //dominio
    .sun_path = SOCKADDR  //percorso del file socket che viene creato da bind() successivamente
  };

  // mi preoccupo di rimuovere il file del socket in caso esista già.
  // se è impegnato da un altro server non si potrà rimuovere, ma bind()
  // successivamente mi darà errore
  unlink(SOCKADDR);
  // lego l'indirizzo al socket di ascolto
  if(bind(sock, (struct sockaddr *)&addr, sizeof addr) == -1) {
    perror("bind()");
    return 2;
  }

  // Abilito effettivamente l'ascolto, con un massimo di 5 client in attesa
  listen(sock, 5);

  fprintf(stderr, "In ascolto.\n");

  // continuo all'infinito ad aspettare client
  while (1)
  {
    struct sockaddr_un client_addr;
    socklen_t client_len = sizeof(client_addr);
    int fd = accept(sock, (struct sockaddr *)&client_addr, &client_len);
    if(fd == -1) {
      perror("accept()");
      return 3;
    }

    /*
     * ogni volta che il server accetta una nuova connessione,
     * quest'ultima viene gestita da un nuovo processo figlio
     */
    pid_t pid = fork();
    if(pid == -1) {
      perror("fork()");
      return 4;
    }

    // il figlio gestisce la connessione, il padre torna subito in ascolto
    if(!pid) { //siamo il figlio
      fprintf(stderr, "Aperta connessione (PID %d).\n",getpid());

      char greet[] = "Benvenuto all'UpperServer 1.0!\n";
      int greetlen = strlen(greet) + 1;
      send(fd, &greetlen, sizeof(greetlen), 0); // Invio lunghezza del messaggio
      send(fd, greet, greetlen, 0); // Invio il messaggio

      upperlines(fd, fd); //da qui inizia la conversazione con il client

      close(fd); // Alla fine chiudiamo la connessione
    }
  }
}

#define BLOCKSIZE 40

void upperlines(int in, int out)
{
  char inputline[BLOCKSIZE]; //buffer locale
  int  len = 0; //lunghezza dei messaggi

  while ((len = recv(in, inputline, BLOCKSIZE, 0)) != -1) { //mette quello che arriva in inputline e si aspetta BLOCKSIZE char
    for (int i = 0; i < len; i++)
      inputline[i] = toupper(inputline[i]); //converte
    send(out, inputline, len, 0); //inoltra al client
  }
}

void handle_sigchld(int x) {
  int saved_errno = errno;
  while (waitpid(-1, 0, WNOHANG) > 0) {}
  errno = saved_errno;
}
