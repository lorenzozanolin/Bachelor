/*
 *   Bazzana Lorenzo, mat. 147569
 *   D'Ambrosi Denis, mat. 147681
 *   Zanolin Lorenzo, mat. 148199
 *
 *    Questo file contiene le procedure per effettuare la registrazione dei tempi medi e ammortizzati.
 *   L'eseguibile può essere creato eseguendo il comando make; devono essere presenti i seguenti file:
 *   - trees.h 
 *   - AVL_trees.cpp
 *   - RB_trees.cpp
 *   - BST_trees.cpp
 *   - getTimes.cpp
 *   - Trees_Operations.cpp
 *   
 *
*/


#include "trees.h"

#define BST 0
#define AVL 1
#define RB 2

#define RANDOM 0
#define LINEAR 1
#define BALANCED 2

#ifndef INSERTTIMES
#define INSERTTIMES

typedef struct InsertTimes InsertTimes;

struct InsertTimes{ //struttura utilizzata per le misurazioni

    long time;
    double std_deviation;

};
#endif


const int A = 1000;
const double B = exp((log(1000000) - log(A))/99); //1.064785978

#define EPS_MAX 0.01  //errore relativo massimo ammissibile

using namespace std;

//----------------------------------------------------------------CALCOLO DEI TEMPI

/*Utility per la differenza tra struct timespec
Sottrae le due timespec tenendo conto del riporto nella differenza tra i campi tv_nsec per evitare errori
*/

int timespec_subtract(struct timespec *result, struct timespec *x, struct timespec *y){

    //tutte le operazioni vengono effettuate tra copie delle struct timespec per evitare incongruenze
    struct timespec x_copy = *x;
    struct timespec y_copy = *y;

    //se y ha un campo tv_nsec maggiore di quello di x bisogna effettuare il riporto
    if (x_copy.tv_nsec < y_copy.tv_nsec) {
        int nsec = (y_copy.tv_nsec - x_copy.tv_nsec) / 1000000000 + 1;
        y_copy.tv_nsec -= 1000000000 * nsec;
        y_copy.tv_sec += nsec;
    }
    if (x_copy.tv_nsec - y_copy.tv_nsec > 1000000000) {
        int nsec = (x_copy.tv_nsec - y_copy.tv_nsec) / 1000000000;
        y_copy.tv_nsec += 1000000000 * nsec;
        y_copy.tv_sec -= nsec;
    }

    if(result != NULL){
    result->tv_sec = x_copy.tv_sec - y_copy.tv_sec;
    result->tv_nsec = x_copy.tv_nsec - y_copy.tv_nsec;
    }

    //resituisce 1 se la differenza e' negativa
    return x_copy.tv_sec < y_copy.tv_sec;

}

double getStdDeviation(long *times, int len){// times: array di tempi registrati; len: lunghezza dell'array;    return: deviazione standard

    double sum = 0;//preparo una viariabile che contenga la somma totale dei tempi

    for(int i=len-1; i>0; i--){
	times[i] -= times[i-1];//times[i] contiene il momento di stop del clock, bisogna sottrargli times[i-1] per ottenere il tempo impiegato da una singola iterazione del ciclo
        sum += times[i];//incremento la somma
    }
	sum += times[0];

    double median = sum/len;//tempo medio

    sum = 0;//riutilizzo sum

    for(int i=0; i<len; i++){
        sum += pow(times[i]-median, 2);//sommo i quadrati degli scarti dei tempi dalla media
    }

    return sqrt(sum/len);//restituisce la deviazione standard dei campioni dei tempi

}

InsertTimes getTimes(int Ni, struct timespec *t_min, int treetype, int inittype){

    InsertTimes tn;
    bst_tree bst_tree;
    avl_tree avl_tree;
    rb_tree rb_tree;
    //strutture che contrerranno i tre alberi
    bst_tree.root = NULL;
    avl_tree.root = NULL;
    rb_tree.root = NULL;
    
    bst *bst_nodes;
    avl *avl_nodes;
    rb *rb_nodes;

    switch(treetype){ //treetype stabilisce che tipo di albero viene richiesto di utilizzare, bst 0 avl 1 rbt 2
        //instanzia un vettore di Ni nodi in cui verranno inseriti i nodi
        case AVL: avl_nodes = (avl*) malloc(sizeof(avl) * Ni); 
        break;
        case RB: rb_nodes = (rb*) malloc(sizeof(rb) * Ni);
        break;
        case BST: bst_nodes = (bst*) malloc(sizeof(bst) * Ni);
        default: break;

    }

    // strutture per salvare i tempi di fine inserimento, inizio, differenza tra inizio e fine
    struct timespec end, start, diff;

    long periodComputationTimes[100] = { }; //registra i tempi parziali per l'inserimento in ogni albero (serve per la deviazione standard)

    int k = 0;	//numero di cicli effettuati
	clock_gettime(CLOCK_MONOTONIC, &start);//inizio registrazione tempi

    do{

        //initializzazione nodi sempre in base al tipo di albero (treetype)
        switch(treetype){

            case AVL: initialise(avl_nodes, Ni, inittype);
            break;
            case RB: initialise(rb_nodes, Ni, inittype);
            break;
            case BST: initialise(bst_nodes, Ni, inittype);
            break;
            default: break;

        }

        //-------inserimento Ni nodi 
        switch(treetype){

            case AVL: execute_operations(Ni, avl_nodes, &avl_tree);
            break;
            case RB: execute_operations(Ni, rb_nodes, &rb_tree);
            break;
            case BST: execute_operations(Ni, bst_nodes, &bst_tree);
            break;
            default: break;

        }   

        clock_gettime(CLOCK_MONOTONIC, &end);//fine registrazione tempi
        timespec_subtract(&diff, &end, &start);//tempo totale impiegato dall'inizio alla fine del ciclo k
        periodComputationTimes[k] = diff.tv_sec*1000000000 + diff.tv_nsec;// salva il tempo di stop per la stringa k-esima

        k++; //incrementa il counter dell'iterazione
        
        //svuoto gli alberi
        bst_tree.root = NULL;   
        avl_tree.root = NULL;
        rb_tree.root = NULL;


        if(k > 100){//se sta facendo troppe iterazioni lo interrompo
            break;
        }

    }while(timespec_subtract(NULL, &diff, t_min) == 1 || k < 20);// se la differenza tra il tempo totale e il tempo minimo e' negativa significa che diff < t_min

    tn.time = ((diff.tv_sec * 1000000000)/k + diff.tv_nsec/k)/Ni;//salva il tempo ammortizzato come ((tempo totale)/k)/n
	tn.std_deviation = getStdDeviation(periodComputationTimes, k)/Ni;//salva la deviazione standard
    
    switch(treetype){
        //libero il vettore che conteneva i nodi
        case AVL: free(avl_nodes);
        break;
        case RB: free(rb_nodes);
        break;
        default: free(bst_nodes);

    }
    
	return tn; //ritorna il tempo ammortizzato

}

long getResolution() {                        // resituisce la risoluzione in nanosecondi
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    do {
        clock_gettime(CLOCK_MONOTONIC, &end);
    } while(start.tv_nsec == end.tv_nsec);
    return (end.tv_nsec - start.tv_nsec);
}

int main(){
    //NMin=1000  NMax=1000000
	// 1000 <= n <= 1000000
    
    //strutture utilizzate per la misurazione dei tempi dei tre alberi
    InsertTimes bst_times[100] = { };
    InsertTimes avl_times[100] = { };
    InsertTimes rb_times[100] = { };

	long res = getResolution();//get clock resolution
    struct timespec t_min;
    t_min.tv_sec = 0;
    t_min.tv_nsec = res * (1/EPS_MAX + 1); //minimo tempo registrabile

    int casetype; //rappresenta il tipo di algoritmo di generazione delle chiavi da inserire/ricercare negli alberi

    do{
        cout<<" --------- Scegliere la tipologia di esecuzione: Random (0) o Linear (1) o Balanced (2)? --------- ";
        cin >> casetype;
        cout<<endl;
    }while(casetype != 1 && casetype != 2 && casetype !=0);


    for(int i=0; i<100; i++){

		int Ni = floor(A * pow(B,i)); //floor per arrivare all'ultima lunghezza,
        //-- operazioni...
        if(casetype != LINEAR || i<60){ //con l'algoritmo Linear ci si ferma a 60 iterazioni (per il BST) altrimenti il tempo di esecuzione diventa eccessivamente lungo
            bst_times[i] = getTimes(Ni, &t_min, BST, casetype);
        }
        avl_times[i] = getTimes(Ni, &t_min, AVL, casetype);
        rb_times[i] = getTimes(Ni, &t_min, RB, casetype);

    }
    //stampa dei dati
    cout << '|' << setw(15) << "NUMERO NODI" << '|' << setw(15) << "TEMPI BST" << '|' << setw(15) << "STD_DEV BST" << '|' << setw(15) << "TEMPI AVL" << '|' << setw(15) << "STD_DEV AVL" << '|' << setw(15) << "TEMPI RBT" << '|' << setw(15) << "STD_DEV RBT" << endl;

    for(int i=0; i < 100; i++){ 
        int Ni = floor(A * pow(B,i));
        cout << '|' << setw(15) << Ni << '|' << setw(15) << bst_times[i].time << '|' << setw(15) << bst_times[i].std_deviation << '|' << setw(15) << avl_times[i].time << '|' << setw(15) << avl_times[i].std_deviation << '|'<< setw(15) << rb_times[i].time << '|' << setw(15) << rb_times[i].std_deviation << endl;
    }
    
    return 0;
}
