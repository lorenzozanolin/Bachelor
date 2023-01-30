/*
Scrivere una funzione
 - int readline(char *line, unsigned len);
che riempia la stringa puntata da line con caratteri letti dallo standard
input, fino a che non viene letto EOF, il carattere di new line ’\n’, o
finché non vengono letti len caratteri. Ci si assicuri che la stringa venga
terminata correttamente. La funzione deve restituire il numero di
caratteri letti, oppure -1 se nessun carattere è stato letto perchè è stata
trovata subito la costante EOF.
*/

#include <stdio.h>

int myReadline(char *, unsigned);
#define MAXLINE 100

int main(){

    int c= 0;
    char line[MAXLINE] = { };

    while((c = myReadline(line, MAXLINE)) != -1) {
        printf("Frase letta: %s Caratteri letti: \"%d\"\n",line,c);
    }

    return 0;
}

int myReadline(char *line, unsigned len){

    char c = getchar(); //leggo il primo carattere
    unsigned counter = 0; //counter di caratteri letti
    
    if(c == EOF)
        return -1; 

    while(c != EOF && c!= '\n' && counter < len -1){ //finche non si realizza una di queste tre condizioni
        line[counter] = c; //salvo il carattere nella stringa
        counter++;
        c = getchar();  //leggo il carattere successivo
    }

    line[counter] = 0; //in ultima posizione ci deve finire sempre uno 0

    return counter;
    
}