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

  struct data_t data1 = { .len = data.len / 2, .data = data.data }; //gli assegno la prima meta' del vettore dei numeri trovati
  struct data_t data2 = {           //gli passo la seconda meta' del vettore
    .len = data.len - data1.len,
    .data = data.data + (data.len - data1.len)
  };
  pthread_t thread1, thread2; 

  pthread_create(&thread1, NULL, compute_max, &data1); //creo i due thread passandogli i due puntatori alle strutture
  pthread_create(&thread2, NULL, compute_max, &data2);

  void *result1_ptr, *result2_ptr; //valori di ritorno dei due thread
  pthread_join(thread1, &result1_ptr);
  pthread_join(thread2, &result2_ptr);

  int result1 = *(int*)result1_ptr; //il max trovato dal primo thread --> da void * lo converto a (int *) e poi accedo al valore puntato dal puntatore
  int result2 = *(int*)result2_ptr; //il max trovato dal secondo thread
  int max = result1 > result2 ? result1 : result2; //confronto

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
struct data_t read_nums(FILE *file)
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