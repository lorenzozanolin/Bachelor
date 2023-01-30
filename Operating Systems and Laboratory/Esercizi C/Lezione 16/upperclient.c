#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <sys/un.h>
#include <sys/types.h>
#include <sys/socket.h>

//PER FAR FUNZIONARE RICHIAMO IL SERVER IN UNA FINESTRA DELLA SHELL (./upperserver) E POI ESEGUO IL CLIENT

#include "common.h"
#define BLOCKSIZE 40

char *readline(FILE *);

int main()
{
  //apro il socket per la comunicazione
  int sock = socket(AF_LOCAL, SOCK_STREAM, 0);
  if(sock == -1) {
    perror("socket()");
    return 1;
  }

  // imposto l'indirizzo del socket server (a cui poi associerò il socket del mio client)
  struct sockaddr_un addr = {
    .sun_family = AF_LOCAL, //dominio
    .sun_path = SOCKADDR  //percorso del file socket che viene creato da bind() successivamente
  };

  //collego il capo del mio socket al capo del socket del server --> mi connetto
  int stato = connect(sock,(struct sockaddr *)&addr,sizeof(addr));

  if(stato == -1){
    printf("Errore nella connessione al server \n");
    return 2;
  }

  //devo stampare il messaggio di benvenuto preceduto dalla lunghezza del messaggio
  int greetLen = 0; //lunghezza dei messaggi
  int read = recv(sock,&greetLen,sizeof(greetLen),0); //ricevo la lunghezza del messaggio di benvenuto
  
  if(read == -1){
    printf("Errore nella lettura della lunghezza \n");
    return 3;
  }
  //printf("Il messaggio è lungo: %d \n",greetLen);

  char *greetMsg = malloc(sizeof(char)* greetLen); //creo la stringa per il messaggio
  read = recv(sock,greetMsg,greetLen,0); //ricevo la stringa e ritorna il numero di byte letti

  if(read == -1){
    printf("Errore nella lettura del messaggio \n");
    return 4;
  }

  printf("%s",greetMsg); //stampo il messaggio di benvenuto
  free(greetMsg); //libero la variabile che ho usato per scrivere il benvenuto

  //FASE ACQUISIZIONE DATI IN INPUT (da poi tradurre)
  char *messaggio = NULL; //alloco una stringa per scrivere il messaggio, di max 40 caratteri

  while(1){
    messaggio = readline(stdin); //passo come file lo standard input che appunto la funzione prenderà come file di input per poi fare la getc
    if(!messaggio) //se non ha letto alcun input
      break; 
    
    int sent = send(sock, messaggio,strlen(messaggio), 0); //inoltra al server

    if(sent == -1){
      printf("Errore nell' invio del messaggio \n");
      return 5;
    }

    //printf("Il messaggio è stato inviato correttamente\n");

    int received = recv(sock,messaggio,strlen(messaggio),0);
    if(received == -1){
      printf("Errore nella ricezione del messaggio \n");
      return 6;
    }

    printf("%s\n",messaggio);
  }
  close(sock);
  return 0;
}

char *readline(FILE *file){ //leggere la linea da standard input

  int caratteriLetti = 0;
  int size = BLOCKSIZE; //dimensione della linea
  char * line = malloc(sizeof(char)* size);

  if(feof(file)) {
    free(line);
    return NULL;
  }
  
  for(char c = fgetc(file); c != '\n' && c != EOF; c = fgetc(file), ++caratteriLetti){
    if(caratteriLetti == size) {
      size = size * 2 + 1;
      line = realloc(line, size);
    }
    
    line[caratteriLetti] = c; //inserisco il carattere
  }

  // Ci assicuriamo che l'ultimo carattere contenga il terminatore nullo
  if(line)
    line[caratteriLetti] = 0;

  return line;
}
