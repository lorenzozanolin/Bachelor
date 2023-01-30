#include <stdio.h>
#include <unistd.h>
#include <signal.h>

void handler_function() {

    printf("SIGINT received\n");

}

int main() {

    signal(SIGINT, handler_function);
    
    while(1) {
        printf("Program running...\n");
        sleep(1);
    }

    return 0;
}