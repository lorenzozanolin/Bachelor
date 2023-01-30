ESAME 23.06.2015
1.
In UNIX ogni entry di una directory è un link e rappresenta l’associazione fra un nome di file
ed il corrispondente indice nell’array degli inode del dispositivo. Un link hard (creabile con il
comando ln) ad un dato file è semplicemente un alias per lo stesso numero di inode del file. Al
contrario, un link simbolico (creabile con il comando ln -s) ad un dato file è un file di testo (con
un proprio inode diverso da quello del file a cui punta) trattato in modo speciale dal sistema
operativo. Il file di testo contiene il path assoluto del file “puntato”. Come conseguenza l’accesso
tramite link hard ai file è molto più veloce rispetto all’accesso tramite link simbolici, ma questi
ultimi consentono di far riferimento anche a file che risiedano su dispositivi e partizioni diversi.

2.
a. f=~/.bash_profile -> assegna a f la stringa ~/.bash_profile
b. echo 'basename $f' -> stampa basename $f
c. echo "basename $f" -> stampa basename ~/.bash_profile
d. echo `basename $f` -> stampa bash_profile

3.
cat /etc/passwd | cut -d: -f1,6 | tr : ' ' | sort

4.
if test $# -ne 1
then
 echo Inserire un solo numero
 exit 1
fi

if test $1 -lt 0
then
 echo Inserire un numero positivo
 exit 2
fi
result=$1
i=$[$1 -1]
while test $i -gt 0
 do
   result=$[$result * $i]
   i=$[$i -1]
 done
echo risultato: $result
exit 0

5.
void raddoppia(struct elemento *head){
    struct elemento *p=head;
    while(p->prossimo != NULL){
        p->val = p->val *2;
        p = p->prossimo;
    }
    p->val = p->val *2;
}

6.
1-> pthread_mutex_lock(&mutex);
2-> fseek(fd,n,SEEK_SET);
3-> write(fd,buffer,LENGTH)
4-> pthread_mutex_unlock(&mutex);
5-> pthread_join(thread[n-1],NULL);
