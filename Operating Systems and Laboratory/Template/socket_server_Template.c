#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <signal.h>
#include <unistd.h>
#include <string.h>

#define SOCKADDR "/tmp/mysocketfile.socket"
#define BLOCKSIZE 40

struct sockaddr_un {
    short sun_family;        // = AF_LOCAL
    char sun_path[108];     //Indirizzo del socket
};

//Esempio inutile di funzione da implementare su un server: questa trasforma le 'a' in '#'
void server_function(int in, int out) {

    char inputline[BLOCKSIZE];
    int len = 0;

    while ((len = recv(in, inputline, BLOCKSIZE, 0)) != -1) {

        for (int i = 0; i < len; i++) {
            if ((inputline[i] == 'a') || (inputline[i] == 'A')) {
                inputline[i] = '#';
            }
        }

        send(out, inputline, len, 0);
    }
}

int main() {

    int sock = socket(AF_LOCAL, SOCK_STREAM, 0);
    if (sock == -1) {
        fprintf(stderr, "Errore nella socket()\n");
        return 1;
    }

    struct sockaddr_un addr = {
    .sun_family = AF_LOCAL,
    .sun_path = SOCKADDR
  };

  unlink(SOCKADDR);

  if (bind(sock, (struct sockaddr *)&addr, sizeof addr) == -1) {
      fprintf(stderr, "Errore nella bind()\n");
      return 2;
  }

  listen(sock, 5);

  fprintf(stderr, "In ascolto\n");

  while(1) {

      struct sockaddr_un client_addr;
      socklen_t client_len = sizeof(client_addr);
      int fd = accept(sock, (struct sockaddr *)&client_addr, &client_len);
      if (fd == -1) {
        fprintf(stderr, "Errore nella accept()\n");
        return 3;
      }

      pid_t pid = fork();
      if (pid == -1) {
        fprintf(stderr, "Errore nella fork()\n");
        return 4;
      }

      if (!pid) {

        fprintf(stderr, "Aperta connessione (PID %d).\n", getpid());
        char successful_connection[] = "Successfully connected with the server\n";
        int successful_connection_len = strlen(successful_connection) + 1;
        send(fd, successful_connection, successful_connection_len, 0);

        server_function(fd, fd);

        close(fd);
        
    }
  }
}