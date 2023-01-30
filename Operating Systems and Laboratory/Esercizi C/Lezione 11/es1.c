/**
 * Dichiarare una struttura struct complex per rappresentare
    numeri complessi a partire dalla parte reale e immaginaria:
       - Utilizzare il tipo di dato float per le componenti.
       - Scrivere le funzioni cabs() e angle() per il calcolo del modulo e dell’argomento di un numero complesso.
       - Scrivere una funzione from_polar() che restituisca un numero complesso a partire da modulo e argomento.
*/
#include <stdio.h>
#include <math.h>

struct complex
{
    float reale;
    float immaginario;
};

struct complex from_polar(float , float );
float cabss(struct complex);
float angle(struct complex);

float cabss(struct complex c){
   return sqrt((c.reale * c.reale) + (c.immaginario * c.immaginario));
};

float angle(struct complex c){
    return atan(c.immaginario/c.reale);
};


struct complex from_polar(float modulo, float argomento){
    struct complex n = {modulo*cos(argomento),modulo*sin(argomento)};    
    return n;
}

int main(){

    
}

