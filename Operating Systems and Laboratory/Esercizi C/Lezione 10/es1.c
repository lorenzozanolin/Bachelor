/*
Scrivere le funzioni (ispirate alla libreria standard)
 - char *strchr(char *str, char c);
 - char *strstr(char *str, char *pattern);
che restituiscono il puntatore rispettivamente alla prima occorrenza del carattere c 
e alla prima occorrenza della stringa pattern all’interno della stringa puntata da str. 
Se un’occorrenza non viene trovata, si resituisca un puntatore nullo
*/

#include <stdio.h>
#include <string.h>

char *myStrchr(char *, char);
char *myStrstr(char *, char*);

int main(){

    char mex[]={"Ciao a tutti"};
    char *p = mex;
    char *charFinded = myStrchr(p,'a');

    while(charFinded){
        printf("%s \n",charFinded);
        charFinded = myStrchr(charFinded+1,'a'); //riutilizzo lo stesso puntatore find che si salva ogni volta dove trova le occorrenze nella stringa
    }

    char *p2 = mex;
    char *patternFinded = myStrstr(p2,"ao");
    
    while(patternFinded){
        printf("%s \n",patternFinded);
        patternFinded = myStrstr(p2+1,"ao"); //riutilizzo lo stesso puntatore find che si salva ogni volta dove trova le occorrenze nella stringa
    }

    return 0;
}

char *myStrchr(char *str, char c){ //ritorna IL PUNTATORE alla prima occorrenza del carattere c in str

    for(char *p = str; *p; ++p){
        if(*p == c)
            return p;
    }

    return NULL;
}

char *myStrstr(char *str, char *pattern){

    int patLen = strlen(pattern); //lunghezza del pattern

    char *p = strchr(str, pattern[0]); //ritorna IL PUNTATORE alla prima occorrenza del primo carattere di pattern in str

    while(p) {
        if(strncmp(p, pattern, patLen) == 0) //confronto i caratteri successivi utilizzando la strncmp utilizzando come riferimento la lunghezza del pattern
            return p;
        p = strchr(p + 1, pattern[0]); //altrimenti se non ha trovato un pattern, si sposta sul carattere successivo a cercare
    }

  return NULL;

}