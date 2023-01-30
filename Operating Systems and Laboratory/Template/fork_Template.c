#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <wait.h>

int main() {

    pid_t pid = fork();

    switch(pid) {
        case -1:
            fprintf(stderr, "Errore nella fork()\n");
            return 1;
        case 0:
            printf("I am the son\n");
            return 0;
        default:
            waitpid(pid, NULL, 0);
            printf("I am the father\n");
    }

    return 0;

}