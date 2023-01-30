ESAME 09.02.2016

1.
giorno=$(date | cut -d' ' -f2)
mese=$(date | cut -d' ' -f3)
anno=$(date | cut -d' ' -f4)
ore=$(date | cut -d' ' -f5 | cut -d. -f1)
minuti=$(date | cut -d' ' -f5 | cut -d. -f2)
secondi=$(date | cut -d' ' -f5 | cut -d. -f3)

echo "$giorno/$mese/$anno - $ore_$minuti_$secondi"

2.
a. ls -l | grep '^d...r.x' --> L’output di questa pipeline consiste nella visualizzazione in long format delle subdirectory
                                della directory corrente che sono leggibili ed attraversabili dagli utenti del gruppo. Infatti
                                il pattern usato con il comando grep seleziona le linee prodotte da ls -l che iniziano con
                                una d (directory) e che hanno i permessi r e x del gruppo attivi.

b. n=`wc registro.txt | sed 's/ /:/g' | cut -d':' -f4` --> l'output sara' 27

3.
void append(struct int_queue *head, int n){
  if(head == NULL)
    head->val=n;
  else{
    struct int_queue p=head;
    while(p->next != NULL){
      p=p->next;
    }
    struct int_queue new = malloc(sizeof(struct int_queue));
    new->val=n;
    new->next=NULL;
    p->next=new;
  }

}

4.
Non funziona correttamente perche' la sincronizzazione tra thread non e' gestita correttamente, infatti manca l'uso di un semaforo mutex
pthread_mutex_t mutex=MUTEX_INITIALIZER;
pthread_mutex_lock(&mutex);
for...
pthread_mutex_unlock(&mutex); e rimuovo lo sleep(random()%2+1);
