/*
Scrivere una funzione:
 - void capitalize(char *str);
che sostituisca, nella stringa puntata da str, ogni occorrenza di una
lettera latina minuscola all’inizio di una parola con la corrispondente
maiuscola.
*/


#include <stdio.h>
#include <string.h>  //<-- You need this to use string and strlen() function.
#include <ctype.h>  //<-- You need this to use toupper() function.
#define MAXLINE 100

int myReadline(char *, unsigned);
void myCapitalize(char *);

int main(){

    int c= 0;
    char line[MAXLINE] = { };

    printf("Inserire una stringa : \n");
    c = myReadline(line,MAXLINE); //leggo la stringa
    myCapitalize(line); //la trasformo
    printf("Risultato: %s",line);

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

void myCapitalize(char * str){
    
    int dim = sizeof(str) * sizeof(char); //dimensione della stringa
    
    for(int i=0; i<dim; i++){
        str[i] = toupper(str[i]); //conversione a lettera maiuscola
    }

}