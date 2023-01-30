ESAME 30.01.2015

1.
si, il comando cp puo' prendere una lista di file come input e come secondo argomento va una directory

2.
Il comando tr abc ABC predispone la shell per accettare dell’input da parte dell’utente (infatti
fa apparire il prompt secondario). Da quel momento fino alla pressione di Ctrl+D (fine file)
tutte le linee inserite dall’utente verranno emesse sullo standard output con le lettere a, b e c
convertite in maiuscolo.

3.
sort -t: -k3,3 -n /etc/passwd | cut -d: -f1

4.
for i in $(seq 1 $#)
do

  n=$1
  if test $n -eq -1
  then
    exit #ha trovato -1 e puo' uscire
  fi

  for j in $(seq 1 $n)
  do
    echo -n "*"
  done
  shift   #shifto di 1 a sx
  echo
done

5.
struct elemento *lista = NULL;
lista=malloc(sizeof(struct elemento));
lista->valore=2;
lista->prossimo=malloc(sizeof(struct elemento));
lista->prossimo->valore=12;
lista->prossimo->prossimo=malloc(sizeof(struct elemento));
lista->prossimo->prossimo->valore=6;
lista->prossimo->prossimo->prossimo=NULL;

6.
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>

int main(){
    pid_t padre; //va dichiarato fuori dalla fork, una volta che eseguo una fork non posso piu' dichiarare una variabile pid_t
    pid_t pid=fork();

    if(pid != 0){
        wait();
    }
    else{
        padre=getppid(); //mi prendo il pid del padre
        kill(padre, 9); //mando una SIGKILL AL PADRE
    }
    return 0;
}

7.
1 - p(semid); //lock
2 - lseek(fd,(linea -1)*LENGTH,SEEK_SET); //SI SPOSTA IN ORIZZONTALE
3 - write(fd,buffer,LENGTH);
4 - v(semid) //unlock
5 - waitpid(proc[n-1],NULL,0);
