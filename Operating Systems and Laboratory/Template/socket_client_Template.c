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

int main() {

    int sock = socket(AF_LOCAL, SOCK_STREAM, 0);
    if (sock == -1) {
        fprintf(stderr, "Errore nella socket()\n");
        return 1;
    }

    struct sockaddr_un server_addr = {
    .sun_family = AF_LOCAL,
    .sun_path = SOCKADDR
    };

    connect(sock, (struct sockaddr *)&server_addr, sizeof server_addr);

    char inputline[BLOCKSIZE];
    int len = 0;

    while ((len = recv(sock, inputline, BLOCKSIZE, 0)) != -1) {

        printf("%s\n", inputline);
        scanf("%s", inputline);
        inputline[BLOCKSIZE-1] = 0;
        len = strlen(inputline);
        send(sock, inputline, len, 0);
    }

    close(sock);

    return 0;

}