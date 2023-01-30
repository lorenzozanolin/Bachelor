/*
Modificare l’esempio parallel_max.c in modo da permettere all’utente di specificare il numero di thread in cui si vuole suddividere il lavoro
Ovviamente il programma per funzionare, dato che legge a blocchi di 20000 caratteri, ha bisogno di file di grandi dimensioni, es. il suo eseguibile
*/

#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include <pthread.h>

/*
Il programma legge il contenuto di un file in modo binario, lo interpreta come un array di numeri interi, e stampa il numero più alto tra quelli letti.
􏰀 Il calcolo del numero più alto avviene in parallelo su due thread the operano su due diverse metà dell’array.
*/

struct data_t {
  int *data; //array con i dati letti
  size_t len; //la sua lunghezza (size_t -> intero molto grande)
};

struct data_t read_nums(FILE *file); //legge i numeri dal file
int max_in_data(int *data, size_t len); //trova il max nel vettore contenente i numeri
void *compute_max(void *ptr); 

int main(int argc, char **argv)
{
  if(argc < 2) {
    fprintf(stderr, "Specificare il nome di un file\n");
    return 1;
  }

  FILE *file = fopen(argv[1], "rb"); //apre il file in lettura BINARIA
  if(!file) {
    perror("fopen()");
    return 2;
  }

  struct data_t data = read_nums(file);  //legge i numeri
  printf("Letti %zu numeri interi.\n", data.len);

  //chiedo quanti thread vuole avviare
  int nThread = 0;
  printf("Quanti thread vuoi creare?\n");
  scanf("%d",&nThread);

  struct data_t * vettDati = malloc(sizeof(struct data_t)*nThread); //vettore che conterra' tutti i pezzetti di vettori da assegnare ai thread
  int dim = data.len/nThread; //dimensione di ogni singolo sottoarray che verra' assegnato ad un singolo thread, anche se alcuni thread avranno alcuni blocchi in comune non importa perche' siamo in lettura(non seriale)
  for(int i=0 ; i<nThread; i++){ //calcolo le dimensioni di ogni sottovettore
      vettDati[i].len = dim; 
      vettDati[i].data = data.data + (i*dim); //puntatore iniziale di ogni sottovettore
  }

  //i thread quando li facio partire li salvo in un vettore di thread
  pthread_t * vettThread = malloc(sizeof(pthread_t) * nThread);
  for(int i=0;i<nThread;i++){
      pthread_t thread;
      vettThread[i] = thread;
      pthread_create(&vettThread[i], NULL, compute_max, &vettDati[i]); //creo i thread passandogli i puntatori alle strutture
  }

  int vettRisultati[nThread]; //vettore contente i risultati dei thread gia' convertiti ad interi
  for(int i=0;i<nThread;i++){
      void *result = NULL;
      pthread_join(vettThread[i],&result); //attendo il risultato del thread
      vettRisultati[i] = *((int*)result); //casto il risultato da puntatore di void a int    
  }

  int max = INT_MIN;  
  for(int i=0;i<nThread;i++){
      if(vettRisultati[i]>max)
        max = vettRisultati[i];
  }  

  printf("Il massimo numero trovato è %d\n", max);
  return 0;
}

void *compute_max(void *ptr) {
  struct data_t data = *(struct data_t *)ptr; //il parametro passato come puntatore a void va riconvertito ad un puntatore alla struttura

  int *result = malloc(sizeof(int)); //alloco un puntatore ad interi
  *result = max_in_data(data.data, data.len); //eseguo la funzione per trovare il max nella parte del vettore che gli e' stata assegnata

  return result; //ritorno il risultato
}

int max_in_data(int *data, size_t len) { //cerca il max nel sotto-vettore
  int max = INT_MIN;
  for(int i = 0; i < len; ++i) {
    if(data[i] > max)
      max = data[i];
  }
  return max;
}

#define NITEMS 2000
struct data_t read_nums(FILE *file) //legge i numeri dal file
{
  size_t size = NITEMS;
  struct data_t data = {
    .len = 0,
    .data = malloc(sizeof(int) * size)
  };

  int r = 0;
  while((r = fread(data.data + data.len, sizeof(int), NITEMS, file)) == NITEMS)
  {
    data.len += r;
    size += NITEMS;
    data.data = realloc(data.data, sizeof(int) * size);
  }

  return data;
}