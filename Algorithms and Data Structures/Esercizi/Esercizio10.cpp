//MAJORITY CANDIDATE
#include <iostream>
#include <string>
#include <sstream>

#define MAXLEN 256
using namespace std;


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

void MooreCandidate(int* arr,int len){

    if(len <=0){
        cout <<"No majority"<<endl;return;
    }

    int majoritycand = arr[0];
    int c = 1; //counter

    for(int i=1;i<len;i++){
        if(c == 0){
            majoritycand = arr[i]; //i e' la posizione dell'ultimo carattere confrontato, che ha fatto arrivare a zero il counter
            c = 1;
        }
        else if(arr[i] == majoritycand)
            c++;
        else
            c--;
    }
    //ora a e' il possibile majoritycand.
    c = 0;

    for(int i=0;i<len;i++){
        if(arr[i] == majoritycand)
            c++;
    }

    if(c > (len/2))
        cout<<majoritycand<<endl;
    else
        cout <<"No majority"<<endl;
}

int main() {

    int arr[MAXLEN]; //array dove salvare i valori
    string input;
    getline(cin, input);

    //salvo i valori nel vettore
    int len = extractIntegerWords(input, arr); //salva i numeri letti nell'array
    MooreCandidate(arr,len);
    return 0;

}
