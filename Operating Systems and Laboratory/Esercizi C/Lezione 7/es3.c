/*
Scrivere un programma C che stampi un istogramma orizzontale (utilizzando il carattere ’-’) raffigurante le
lunghezze delle parole (delimitate da whitespace characters) immesse sullo standard input (parola per parola)
*/

#include <stdio.h>

int main() {
  int i = 0, n = 0;

  for(int c = getchar(); c != EOF; c = getchar())
  {
    if(c != ' ' && c != '\t' && c != '\n') { //se c e' diverso da tutto quello che non e' testo
      n++; //incremento il numero di caratteri
    } else {

      for(i = 0; i < n; i++)
        printf("-");

      if(n > 0)
        printf("\n");

      n = 0;
    }
  }

  return 0;
}

