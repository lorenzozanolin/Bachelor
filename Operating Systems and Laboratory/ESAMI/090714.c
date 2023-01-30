ESAME 09.07.2014

1.
ls -lR /home | grep '^d....w....'

2.
Un here document `e un modo per redirigere dell’input multilinea dalla console ad un programma.
Sostanzialmente `e come se l’input venisse fornito al programma sotto forma di contenuto di un
file. Tuttavia il file non esiste fisicamente nel filesystem, ma viene creato “al volo” tramite
redirezione dello standard input.

3.
val=‘date | cut -d’:’ -f2‘ -> assegna a val l'output della pipe
echo $val -> 46

4.
n=$1
i=1

while test $i -le $n
do
  for j in $(seq 1 $i)
  do
   echo -n '*'
  done
echo
i=$[$i+1]
done
exit 0

5.

a. falso, restituisce il pid figlio al padre, mentre al figlio ritorna 0
b. vero
c. vero
d. falso, sono unidirezionali e solo politica FIFO
e. -
f. falso, possono essere usate anche in dominio locale

6.
scanf("%d\n",&n);
printf("Il numero inserito e’: %d\n",n);
char *s2= malloc(size of(char) *strlen(s1) +1) --> //carattere terminatore
strcpy(s2,s1);
printf("s2: %s\n",s2);

7.
filedes = open("nomefile", O_RDONLY); --> apre in lettura ma vuole scrifv
write(filedes, "prova", strlen("prova"));

filedes=open("prova.txt",O_RDONLY);
lseek(filedes, (off_t)-40, SEEK_SET); --> offset negativo


8.
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>

int main(int argc, char *argv[]) {

  struct stat buf;
  long int dim, blk;
  stat(argv[1], &buf);

  dim=buf.st_size;
  blk=buf.st_blksize;

  printf("Dimensione del file : %ld byte\n",dim);
  printf("Dimensione del blocco: %ld byte\n",blk);
  printf("Frammentazione interna: ");
  /* Se la dimensione del file (dim)
  * e’ un multiplo del blocco (dim%blk==0),
  * allora la frammentazione interna e’ 0.
  * Altrimenti e’ pari a blk-(dim%blk), ovvero,
  * il residuo di byte non utilizzati (sprecati)
  * nell’ultimo blocco.
  */
  printf("%ld byte\n",((dim%blk==0) ? 0 : blk-(dim%blk)));
  return 0;
}
