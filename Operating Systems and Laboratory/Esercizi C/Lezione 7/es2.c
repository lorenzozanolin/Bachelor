/*
Scrivere un programma C che conti il numero di spazi, tab e newline (whitespace characters) 
presenti nei caratteri immessi sullo standard input
*/
#include <stdio.h>
#include <string.h>

int main(){
    int c; //carattere letto
    int tab = 0, spazi = 0, newline = 0;

    do{
        c = getchar();
        switch(c){
            case ' ': spazi++;break;
            case '\n': newline++;break;
            case '\t':tab++;break;
        }
    }while(c != EOF); //EOF in Windows e' ctrl+z e poi invio

    printf("Spazi: %d\nTabulazioni: %d\nNewline: %d\n", spazi, tab, newline);

    return 0;
}