/*
 *   Bazzana Lorenzo, mat. 147569
 *   D'Ambrosi Denis, mat. 147681
 *   Zanolin Lorenzo, mat. 148199
 *
 *   Questo e' il programma per la registrazione dei tempi medi di computazione degli algoritmi PeriodSmart e PeriodNaive
 *
*/

#include <time.h>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <cstdlib>
#include <math.h>
#include <iomanip>

//costanti per la generazione della lunghezza della stringa
const int A = 1000;
const double B = exp((log(500000) - log(A))/99); //1.064785978

using namespace std;
#define EPS_MAX 0.001  //errore relativo massimo ammissibile

typedef struct{ //struct creata per la misurazione dei tempi e il calcolo della deviazione standard

	long time;
	double std_deviation;

} PeriodTimer;

//----------------------------------------------------------------CALCOLO DEL PERIODO
int periodSmart(string s,int size){ //algoritmo compl. Θ(n)

    int r[size];  //vettore dove salvo i bordi "temporanei" delle sottostringhe
    r[0] = -1; //setto il primo bordo a -1 (sarebbe 0 ma sottraggo 1 a tutti i valori, poi alla fine sommo 1 al risultato)
    int z; //lunghezza del bordo precedente

    for(int i=0;i<size-1;i++){
        z = r[i];

        while (z>=0 && (s[z+1] != s[i+1])){ //finche il carattere successivo al bordo e' diverso dall'ultimo carattere aggiunto (in fondo alla stringa)
            z = r[z];
        }
        if(s[z+1] == s[i+1]){ //se il carattere successivo al bordo e' uguale all'ultimo carattere aggiunto incremento la lunghezza del bordo i+1esimo
            r[i+1] = z+1;
        } else { //altrimenti setto il bordo i+1esimo a -1 (sarebbe 0)
            r[i+1] = -1;
        }

    }

    return size - (r[size-1] +1); //lunghezza del minimo periodo frazionario = lunghezza della stringa - lunghezza bordo massimo. Poi sommo 1 per compensare la sottrazione iniziale
}

int periodNaive (string s) {  //algorirmo compl. O(n^2)
    int n = s.length(); //lunghezza della stringa
    int r;
    string s1, s2;
    for (int p = 1; p <= n; p++) {
        r = n - p;
        s1 = s.substr(0, r);
        s2 = s.substr(p, r);
        if ( s1 == s2 )  //O(n-p) confronti per vedere l'uguaglianza
            return p;
    }
    return n;
}

//----------------------------------------------------------------GENERAZIONE DELLLA LUNGHEZZA


string totallyRandomStringGenerator(int n) { //RANDOM STRING
    string S = "";
    for (int i = 0; i < n; i++) {
        S += (rand() % 2 + 'a'); //ogni volta genera un numero casuale tra 0 e 1 (offset) e lo somma ad 'a'  --> ottengo o 'a' o 'b'
    }
    return S;
}

string randomPeriodStringGenerator(int n) { //RANDOM PERIOD
    int q = rand() % n + 1; //q e' la lunghezza del periodo che viene calcolata randomicamente tra 1 e n  (sarebbe [0..n-1] +1

    string P = ""; //stringa dove memorizzo il periodo
    for (int i = 0; i < q; i++) { //genera un periodo di lunghezza q
        P += (rand() % 2 + 'a'); //genera un numero random (tra 0 e 1) che verra' shiftato da 'a'
    }

    string S = ""; //stringa finale
    for (int i = 0; i < n / q; i++) { //accoda n/q volte il periodo per formare la stringa
        S += P;
    }

    for (int i = 0; i < n % q; i++) { //per l'eventuale troncamento
        S += P[i];
    }
    return S;
}

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

PeriodTimer getTimes(int Mj, struct timespec *t_min, int ranType, int algoType){

	PeriodTimer tn;

    // strutture per salvare i tempi di fine computazione, inizio, tempi necessari alla generazione delle stringhe e alla differenza tra inizio e fine
    struct timespec end, start, string_start, string_end, string_diff, string_gen, diff;
    string_gen.tv_sec = 0;
    string_gen.tv_nsec = 0;

    long periodComputationTimes[100] = { }; //registra i tempi parziali per la computazione di ogni stringa generata

    int k = 0;	//numero di cicli effettuati
	clock_gettime(CLOCK_MONOTONIC, &start);//inizio registrazione tempi

    do{ //esegue la generazione della stringa e il calcolo del suo periodo frazionario finche', per ogni lunghezza, ottengo tempi ottimi (per avere un buon grafico)

		clock_gettime(CLOCK_MONOTONIC, &string_start);//inizio registrazione tempi per la generazione della stringa
		string generatedString;

        if( ranType == 1 ) //algoritmo di generazione delle stringhe randomPERIOD
            generatedString = randomPeriodStringGenerator(Mj); //genera la stringa di lunghezza Mj

        else if( ranType == 2 ) //algoritmo di generazione delle stringhe randomSTRING
            generatedString = totallyRandomStringGenerator(Mj); //genera la stringa di lunghezza Mj

		clock_gettime(CLOCK_MONOTONIC, &string_end);//fine registrazione tempi stringhe

        //calcolo del periodo
        if( algoType == 1 ) //algoritmo periodNaive
            periodNaive(generatedString);

        else if( algoType == 2) //algoritmo periodSMART
		    periodSmart(generatedString, Mj);

		clock_gettime(CLOCK_MONOTONIC, &end);//fine registrazione tempi

		// tempo totale impiegato solo per generare le stringhe, andra' sottratto dal tempo totale dopo aver trovato un tempo buono
		timespec_subtract(&string_diff, &string_end, &string_start);
        string_gen.tv_sec += string_diff.tv_sec;
        string_gen.tv_nsec += string_diff.tv_nsec;
        //


	timespec_subtract(&diff, &end, &start);//tempo totale impiegato dall'inizio alla fine del ciclo k
	periodComputationTimes[k] = diff.tv_sec*1000000000 + diff.tv_nsec;// salva il tempo di stop per la stringa k-esima

	k++;

        if(k > 100){//se sta facendo troppe iterazioni lo interrompo
            break;
        }


	}while(timespec_subtract(NULL, &diff, t_min) == 1);// se la differenza tra il tempo totale e il tempo minimo e' negativa significa che diff < t_min

	tn.time = (diff.tv_sec - string_gen.tv_sec)*1000000000/k + (diff.tv_nsec - string_gen.tv_nsec)/k;//salva il tempo come (tempo totale - tempo impiegato per le stringhe)/k
	tn.std_deviation = getStdDeviation(periodComputationTimes, k);//salva la deviazione standard

	return tn;

}

long getResolution() {                        // resituisce la risoluzione in nanosecondi
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    do {
        clock_gettime(CLOCK_MONOTONIC, &end);
    } while(start.tv_nsec == end.tv_nsec);
    return (end.tv_nsec - start.tv_nsec);
}

//----------------------------------------------------------------MAIN


int main(){
	//NMin=1000  NMax=500000
	// n=|S|, 1000 <= n <= 500000

	PeriodTimer *times = (PeriodTimer*) malloc(sizeof(PeriodTimer) * 100);
	long res = getResolution();//get clock resolution
	struct timespec t_min;
    t_min.tv_sec = 0;
    t_min.tv_nsec = res * (1/EPS_MAX + 1); //minimo tempo registrabile

	string s; //stringa che verra' generata
	int Mj = 0; //lunghezza della stringa da generare

    int ranType,algoType; //scelta input

    do{
        cout<<" --------- Generare la stringa in modo RandomPeriod (1) o RandomString (2) ? --------- ";
        cin >> ranType;
        cout<<endl;
    }while(ranType != 1 && ranType != 2 );

    do{
        cout<<" --------- Utilizzare PeriodNaive (1) o PeriodSmart (2) ? --------- ";
        cin >> algoType;
        cout<<endl;
    }while(algoType != 1 && algoType != 2 );

    //output
    cout << '|' << setw(10) << "LUNGHEZZA" << '|' << setw(10) << "TEMPI MEDI" << '|' << setw(10) << "TEMPI MEDI" << '|'<<endl;

	for(int j=0; j<=99; j++){ //genero 100 stringhe
		Mj = floor(A * pow(B,j)); //floor per arrivare all'ultima lunghezza = 500000,
		//Mj ora e' la lunghezza della stringa attuale
		times[j] = getTimes(Mj, &t_min,ranType,algoType); //misuro e salvo i tempi di calcolo del periodo sulle stringhe generate, passo anche i tipi di generazione e algoritmi richiesti
        	cout << '|' << setw(10) << Mj << '|' << setw(10) << times[j].time << '|' << setw(10) << times[j].std_deviation << '|'<<endl;
	}

    free(times); //dealloco il vettore dei tempi

	return 0;

}
