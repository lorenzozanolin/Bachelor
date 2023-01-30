#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

#define MSGSIZE 32

int main() {

    int pipes[2] = { };
    if(pipe(pipes) == -1) {
        perror("pipe call");
        return 1;
    }

    char msg[MSGSIZE];
    pid_t pid = fork();

    switch(pid) {
        case -1:
            perror("fork call");
            return 2;
        case 0:
            close(pipes[0]);
            dup2(pipes[1], 1);
            printf("Hello World!");
            break;
        default:
            close(pipes[1]);
            dup2(pipes[0], 0);
            read(0, msg, MSGSIZE);
            printf("Dati letti via stdin: %s\n", msg);
            wait(NULL);
        }

    return 0;

}
