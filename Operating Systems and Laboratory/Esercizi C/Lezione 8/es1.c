/*
Ripetere l’esercizio 2 o 3 della Lezione 7, definendo però una
funzione is_whitespace() per controllare se un carattere è
di spazio bianco oppure no.
*/

#include <stdio.h>
#include <string.h>

int is_whitespace(char);

int main(){
    int c; //carattere letto
    int spazi = 0;

    do{
        c = getchar();
        if(is_whitespace(c))
            spazi++;
    }while(c != EOF); //EOF in Windows e' ctrl+z e poi invio

    printf("Spazi: %d\n", spazi);

    return 0;
}

int is_whitespace(char c){
    if(c == ' ')
        return 1; //true
    else
        return 0; //false
}