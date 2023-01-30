/*
Scrivere un programma che ordini un array di numeri interi,
utilizzando un algoritmo di ordinamento visto a lezione di
Algoritmi e Strutture Dati (es. bubble sort o insertion sort) --> senza puntatori, quindi dentro allo stesso blocco di dove dichiaro l'array
*/

#include <stdio.h>

int main(){

    int aux=0;

    int array[] = {4,5,2,1,6}; //array da ordinare
    
    int dim= sizeof(array)/sizeof(int); //dimensione del vettore
    
    for(int i=0; i<dim;i++){
        for(int j=i+1;j<dim;j++){
            if(array[i]>array[j]){
                aux = array[i];
                array[i] = array[j];
                array[j] = aux;
            }
        }
    }

    for(int i=0; i<dim;i++){
        printf("%d \n",array[i]);
    }

    return 0;
}