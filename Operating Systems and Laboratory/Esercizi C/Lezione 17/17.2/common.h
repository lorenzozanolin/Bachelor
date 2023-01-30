/*
 * common.h
 *
 * Funzioni di utilità usate sia da upperserver.c che da upperclient.c
 */

/*
 * Percorso del socket per la comunicazione
 */
#define SOCKADDR "/tmp/upperserver.socket"

/*
 * Funzione di utilità per controllare il valore di ritorno di una funzione
 * POSIX e uscire in caso di errore
 */
void check(int result, int exitval, const char *msg);
