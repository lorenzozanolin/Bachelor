/* 
Scrivere un programma C che conti il numero di parole immesse sullo standard input 
(si considerino come delimitatori di parola i whitespace characters)
*/

#include <stdio.h>
#include <string.h>

int main(){
    int c; //carattere letto
    int nrParole=0;
    int inizioParola=0; //una volta che inizio una parola poi la conto eventualmente per uno spazio (1 se e' deve essere ancora immesso il primo carattere, 0 se e' gia stato immesso e quindi posso contare una parola in piu)

    do{
        c = getchar();
        if(c ==' ' || c == '\t' || c == '\n'){ //controllo per trascindere spazi, a capo e tabulazioni
            if(inizioParola == 1) //prima di trovare uno spazio aveva una lettera o numero? se firstChar = 1 allora vuol dire che prima c'era qualcosa diverso da lettere e numeri
            {
                nrParole++;
                inizioParola = 0; //ora non e' piu all'inizio della parola e non contera' piu 
            }
            else
            {
                inizioParola = 1;
            }

        }
    }while(c != EOF); //EOF in Windows e' ctrl+z e poi invio

    if(inizioParola == 1)
        nrParole++;

    printf("Le parole totali sono: %d\n",nrParole);

    return 0;
}