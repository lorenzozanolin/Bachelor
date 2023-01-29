#include <iostream>
#include <string>
#include <math.h>
#include <sstream>

#define MAXLEN 100
using namespace std;

typedef struct{
    int *vett;
    int heapsize;
} Heap;

int left (int i) { return 2*i + 1; }

int right (int i) { return 2*i + 2; }

int parent (int i) { return ceil((float) i/2) - 1; }

void swap (Heap* H, int i, int j) {
    int temp = H->vett[i];
    H->vett[i] = H->vett[j];
    H->vett[j] = temp;
}

void heapify (Heap *heap, int i){
	int l = left(i);
	int r = right(i);
	int m = -1;
	if ( l < heap->heapsize && heap->vett[l] < heap->vett[i] )
		m = l;
	else
		m = i;
	if ( r < heap->heapsize && heap->vett[r] < heap->vett[m] )
		m = r;
	if ( m != i ){
		swap(heap, i, m);
		heapify(heap, m);
	}	
}

void buildHeap (Heap* heap) {
    for ( int i = heap->heapsize-1; i >= 0; i--)
        heapify(heap, i);
}

int extract (Heap* heap) {
    if ( heap->heapsize >= 1 ) {
        swap(heap, 0, heap->heapsize - 1);
        heap->heapsize--;
        heapify(heap, 0);
        return heap->vett[heap->heapsize];
    } else
        return -1;
}

int getLength (Heap* heap) {
    return heap->heapsize;
}

int getMin (Heap* heap) {
    return heap->vett[0];
}

void insert (Heap* heap, int k) {
    if ( heap->heapsize < MAXLEN) {
        heap->vett[heap->heapsize] = k;
        heap->heapsize++;
        int i = heap->heapsize - 1;
        while ( heap->vett[i] < heap->vett[parent(i)] ) {
            swap(heap, i, parent(i));
            i = parent(i);
        }
    }
}

void change (Heap* heap, int i, int x) {
    if ( i < heap->heapsize ) {
        heap->vett[i] = x;
        while ( heap->vett[i] < heap->vett[parent(i)] ) {
            swap(heap, i, parent(i));
            i = parent(i);
        }
        heapify(heap, i);
    }
}

void printHeap (Heap* heap) {
    for (int i = 0; i < heap->heapsize; i++)
        cout << heap->vett[i] << " ";
    cout << "\n";
}

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

int main() {

    Heap H;
    H.vett = (int* ) malloc( MAXLEN * sizeof(int) );
    H.heapsize = 0;

    string command;
    int x;
    int y;
    int array[100];

    while (true) {
        cin >> command;
        if ( command == "build" ) {
            getline(cin, command);
            x = extractIntegerWords(command, H.vett);
            H.heapsize = x;
            buildHeap(&H);
            printHeap(&H);
            continue;
        } else if ( command == "length" ) {
            cout << getLength(&H) << "\n";
            printHeap(&H);
            continue;
        } else if ( command == "getmin" ) {
            cout << getMin(&H) << "\n";
            printHeap(&H);
            continue;
        } else if ( command == "extract" ) {
            extract(&H);
            printHeap(&H);
            continue;
        } else if ( command == "insert" ) {
            cin >> x;
            insert(&H, x);
            printHeap(&H);
            continue;
        } else if ( command == "change" ) {
            cin >> x;
            cin >> y;
            change(&H, x, y);
            printHeap(&H);
            continue;
        } else {
            return 0;
        }    
    }
}