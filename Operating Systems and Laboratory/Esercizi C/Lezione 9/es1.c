/*
Scrivere un programma che legga dallo standard input dei
numeri e ne stampi la somma totale
*/

#include <stdio.h>

int main(){
    printf("Inserisci i numeri:\n");
    int x = 0;
    int sommaTot = 0;

    while(scanf("%d \n",&x) != EOF){ //eof = ctrl+c
        sommaTot += x;
    }

    printf("La somma totale e' %d \n",sommaTot);
    return 0;
}

