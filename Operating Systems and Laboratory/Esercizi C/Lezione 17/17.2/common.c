/*
 * common.c
 *
 * Funzioni di utilità usate sia da upperserver.c che da upperclient.c
 */

#include <stdio.h>
#include <stdlib.h>

#include "common.h"

/*
 * Funzione di utilità per controllare il valore di ritorno di una funzione
 * POSIX e uscire in caso di errore
 */
void check(int result, int exitval, const char *msg) {
  if(result == -1) {
    perror(msg);
    exit(exitval);
  }
}
