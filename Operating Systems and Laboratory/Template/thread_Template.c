#include <pthread.h>
#include <stdio.h>

void *thread_function(void *ptr);

int main() {

    pthread_t thread_1, thread_2;
    int x_1 = 5;
    int x_2 = 7;

    pthread_create(&thread_1, NULL, thread_function, (void *) &x_1);
    pthread_create(&thread_2, NULL, thread_function, (void *) &x_2);

    void *retval;

    pthread_join(thread_1, (void *) &retval);
    pthread_join(thread_2, NULL);


    printf("Il thread #1 ha calcolato: %d\n", (int) retval);

    return 0;

}

void *thread_function(void *ptr) {

    int number = * (int *) ptr;
    number++;
    return (void *) number;

}