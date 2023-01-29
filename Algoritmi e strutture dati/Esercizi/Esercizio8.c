#include <stdio.h>
#include <string.h>
#define MAX_LINE_SIZE 1000

struct coppia{
    int i;
    int j;
};
int scanArray(int*);
struct coppia trovaIntervallo(int *,int,int);

int main(){
    int arr[200];
    int k;
    
    int size = scanArray(arr);
    scanf("%d",&k);

    struct coppia c = trovaIntervallo(arr,k,size);
    printf("%d %d\n",c.i,c.j);
    return 0;
}


struct coppia trovaIntervallo(int * a,int k,int size){
       
    int i,j = 0;
    int somma = a[i];
    
    if(size == 0){
        struct coppia c;
        c.i = -1;
        c.j = -1;
        return c;
    }

    while(i<size-1 && j<size-1 && i<=j){
        if(somma < k){
            j++;
            somma += a[j];
        }
        else if(somma > k){
            i++;
            somma -= a[i];
        }
        else{ //ha trovato l'intervallo
            struct coppia intervallo;
            intervallo.i = i;
            intervallo.j = j;
            return intervallo;
        }
    }
    
    struct coppia c;
    c.i = -1;
    c.j = -1;
    return c;
}

int scanArray(int *a) {
    // scan line of text
    printf("Inserire i numeri\n");
    char line[MAX_LINE_SIZE];
    scanf("%[^\n]s", line); //leggo un intera riga

    // convert text into array
    int size = 0, offset = 0, numFilled, n;
    do {
        numFilled = sscanf(line + offset, "%d%n", &(a[size]), &n);
        if (numFilled > 0) {
            size++;
            offset += n;
        }
    } while (numFilled > 0);

    return size;
}