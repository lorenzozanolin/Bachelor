//Es 25
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//lunghezze massime
#define WORD_COUNT 100
#define WORD_LENGTH 50
#define TEXT_LENGTH 10000
#define ROW_LENGTH 1000
#define ROW_COUNT 1000

int readText(char **text){ //legge delle stringhe e ritorna il numero di stringhe
  char line[TEXT_LENGTH];
  scanf("%[^\n]s",line); //legge fino a che non trova il simbolo A CAPO
  //una volta che ha salvato la prima riga (line), ora la deve salvare in un vettore di stringhe
  int size = 0, offset = 0, numFilled, n;
    do {
        text[size] = (char *)malloc(WORD_LENGTH * sizeof(char));
        numFilled = sscanf(line + offset, "%s%n", text[size], &n);
        if (numFilled > 0) {
            size++;
            offset += n;
        }
    } while (numFilled > 0);

    return size;

}

void printText(char **text, int n){
  for(int i=0;i<n;i++){
    printf("%s\n",text[i]);
  }
  printf("\n");
}

double costFunction(double emptySpace){ //input: spazio vuoto, funzione x^3
  if(emptySpace < 0.0)
    return 1.0/0.0; //+inf
  else
    return emptySpace * emptySpace * emptySpace;
}

int rowLength(char **text,int j,int k){ //j e k descrivono l'intervallo di parole, ovvero la lunghezza di text[j] + " " + ..+ text[k+1]
  int len =0;
  for(int i = j; i< k; i++){
    len += strlen(text[i]);
    if(i+1 < k) //se al passo successivo trovo un altra parola, allora devo contare uno spazio
      len++;
  }
  return len;
}

int justify(char **text, int n, int wMax, char **rows){
  double *bestCosts = (double *) malloc((n+1)*sizeof(double)); //double perche i costi potrebbero essere in virgola,
  //la dim e' n+1 perche' ho n+1 sottoproblemi
  int *bestArgs = (int *)malloc((n+1)*sizeof(double)); //argomento che minimizza il costo

  for(int j=n; j>=0; j--){ //ciclo per risolvere il sottoproblema
    //devo trovare una soluzione per il problema J-ESIMO, e lo faccio confrontando tutte le soluzione del problema J'-ESIMO
    //ovvero devo calcolare bestCosts[j] e bestArgs[j]

    if(j == n) //caso base dei sottoproblemi
        bestCosts[j] = 0.0;
    else
        bestCosts[j] = 1.0/0.0; //inizializza al caso pessimo

    for(int k=j+1; k<= n; k++){ //j' che va da j+1 fino a n, TROVA LE POSSIBILI SOLUZIONI PARZIALI
      double cost = costFunction(wMax - rowLength(text,j,k)) + bestCosts[k];

      if(cost <= bestCosts[j]){
        bestCosts[j] = cost;
        bestArgs[j] = k;
      }
    }
  }

  //ricostruisco le righe ottime

  int m=0;
  for(int j=0; j<n; j = bestArgs[j], m++){
    rows[m] = (char *)malloc(ROW_LENGTH * sizeof(char));
    strcpy(rows[m],"");

    for(int k=j; k<bestArgs[j]; k++){
      strcat(rows[m],text[k]);
      if(k+1 < bestArgs[j])
        strcat(rows[m], " ");
    }
  }

  return m;
}


int main(){
  char **testo = (char **)malloc(WORD_COUNT * sizeof(char *)); //vettore di stringhe
  int n = readText(testo); //ritorna il numero di parole che ha letto

  int wMax;
  scanf("%d",&wMax);

  char **rows = (char **) malloc(ROW_COUNT * sizeof(char *));
  int m = justify(testo,n,wMax,rows); //giustifica il testo salvato in text e lo salva in rows

  printText(rows,m);
  return 0;
}
