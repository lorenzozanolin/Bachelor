ESAME 8.19.2014

1.
a. fallisce perche' in user mode deve avere il permesso di Execute
b. chmod u+x tmp

2.
IFS=’\n’ #imposta il separatore di linea per il comando read
while read -r linea # -r considera eventuali backslash come normali caratteri
do
 l=$(echo $linea | wc -c)
 i=1 #da 1 a l compreso
 while test $i -lt $l
 do
  echo -n '*'
  i=$[$i +1]
 done
 echo
done
exit 0

3.
a. echo ababab | sed '1,$y/ab/yz' --> yzyzyz
b. echo ababab | sed '1,$s/ab/_' --> _abab
c. echo ababab | sed '1,$s/ab/_/g' --> ___

4.
latoMax=$1
latoMin=$2
i=1

#stampo prima linea
for i in $(seq 1 $latoMax)
do
 echo -n '*'
done
echo
#stampo le linee intermedie
for i in $(seq 1 $[$latoMin -2])
do
 echo -n '*' #stampo il primo simbolo (lato sx)
 for i in $(seq 1 $latoMin)
 do
  echo -n ' '
 done
 echo '*' #stampo il secondo simbolo (lato dx)
done

#stampo prima linea
for i in $(seq 1 $latoMax)
do
 echo -n '*'
done
echo
exit 0

5.
a. vero
b. falso, viene usata per creare nuovi processi; i quali sono staccati ed indipendenti dal padre
c. falso, questa famiglia di system call sovrascrive il processo chiamante, sostituendone il
          codice con quello del programma esterno.
d. vero
e. vero
f. vero
g. vero

6.
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <unistd.h>

int stop = 0;

void handler() {
    stop = 1;
}

int main() {
    int number_of_cycles=0;
    signal(SIGINT, handler);
    while (!stop) {
        pid_t pid = fork();
        switch(pid) {
            case -1:
                fprintf(stderr, "fork() fallita\n");
                return 1;
            case 0:
                execlp("ps", "ps", "-el", NULL);
                fprintf(stderr, "exec() fallita\n");
                return 2;
            default:
                waitpid(pid, NULL, 0);
        }
        number_of_cycles++;
        sleep(5);
    }
    printf("\nNumero di cicli:%d\n", number_of_cycles);
    return 0;
}
