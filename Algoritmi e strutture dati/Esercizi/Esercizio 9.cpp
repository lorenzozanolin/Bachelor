#include <iostream>
#include <string>
#include <sstream>

#define MAXLEN 256
using namespace std;

struct coppia{
    int i;
    int j;
};

void printArray(int* array, int len) {
    for (int i = 0; i < len; i++) {
        cout << array[i] << " ";
    }
    cout << "\n";
}

//estrarre il testo dagli input
int extractIntegerWords (string str, int *array) { 
    stringstream ss;     
    ss << str; 
    string temp; 
    int found; 
    int i=0;
    while (!ss.eof()) { 
        ss >> temp; 
        if (stringstream(temp) >> found) 
            array[i] = found; 
        temp = ""; 
        i++;
    }
    return i;
} 

struct coppia diffMinima(int*arr,int len){
    coppia pair; //coppia che contiene gli indici della diff massima
    pair.i = 0;
    pair.j = 0;
    int bestDiff=0;//conterra' la differenza massima
    int i = 0; //posizione del minimo 

    for(int j=0; j<len; j++){
        //cerco il minimo, per ogni j fissato, alla sua sinistra
        //al posto pero' che ogni volta usare il findMin, controllo solo l'ultimo aggiunto ed eventualmente aggiorno il minimo
        if(arr[j]<arr[i])
            i = j;

        if(bestDiff<arr[j]-arr[i]){
            bestDiff=arr[j]-arr[i];
            pair.i=i;
            pair.j=j;
        }
    }
    return pair;
}

int main() {

    int arr[MAXLEN]; //array dove salvare i valori
    string input;
    getline(cin, input);
    
    //salvo i valori nel vettore
    int len = extractIntegerWords(input, arr); //salva i numeri letti nell'array
    coppia pair = diffMinima(arr,len); //coppia che contiene gli indici della diff massima
    
    cout<<pair.i<<" "<<pair.j<<endl;
    return 0;

}