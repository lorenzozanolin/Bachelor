ESAME 11.02.2014

1.
echo $SHELL

2.
ln f1 /mnt/usbmedia0/B/f1_link --> fallisce perche' non sono nello stesso supporto di memoria

ln -s f1 /mnt/usbmedia0/B/f1_link --> va a buon, viene creato il link simbolico f1 link (all’interno della directory B nella radice della chiavetta
                                      USB) al file f1 che risiede nel filesystem del disco rigido.

3.
cd ; ls -al | grep '^d'  --> mi sposta nella home, mostra i file nascosti e seleziona tutte le directory

4.
read linea
somma=0
while test $linea != ’stop’
do
  somma=$[$somma + $linea]
  read linea
done
echo $somma

5.
1 - int i; --> dichiara una variabile di tipo intero, alloca 4Byte;
2 - int *ip; --> dichiara un puntatore ad intero;
3 - int a1[10]; --> dichiara un array di 10 interi;
4 - int a2[] = {0,1,2,3,4,5,6,7,8,9}; --> la stessa cosa del 3
5 - int m[10][20]; --> instanzia una matrice di 200 elementi
6 - int *b[10] --> instanzia un vettore di 10 puntatori

6.
int main(){
  int x,y;

  while(scanf("%d %*d %d %*d",&x,&y) !=  EOF){
    printf("%d %d\n",x,y);
  }
  return 0;
}

7.
int *ip;
printf("Il valore puntato da ip e‘: %d\n",*ip); --> l'errore e' che ip non punta a niente e cerco di accederci per stampare il valore

8.
d=malloc(sizeof(struct dati));
strcpy(d->testo,s);
d->lunghezza=strlen(s);

9.
a.
1 - pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
2 - (void *) msg[i];
3 - mutex_lock(&mutex);
4 - (char *)ptr;
5 - mutex_unlock(&mutex);

b.
senza la pthread_join termina il padre e di conseguenza terminano i figli, pero' essi rimango thread zombie
