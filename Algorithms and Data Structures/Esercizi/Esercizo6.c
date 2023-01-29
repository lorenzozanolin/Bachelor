#include <stdio.h>
#include <string.h>
#define MAX_LINE_SIZE 1000
int scanArray(int*);
int ricercaDicotomica(int*,int,int,int);

int main(){
    
    int arr[MAX_LINE_SIZE]; 

    int size = scanArray(arr); //quando gli passo arr cosi e' come se gli stessi passando il puntatore al primo elemento, infatti int*p = a e' un puntatore che punta al primo elemento e scanArray(p)
    int key = 0;
    scanf("%d",&key);
    int pos = ricercaDicotomica(arr,key,0,size-1);
    printf("Posizione: %d\n",pos);
    return 0;
    
}

int ricercaDicotomica(int* a,int k,int i,int j){
    if(i>j)
        return -1;
    
    int m = (i+j)/2;
    if(a[m] == k)
        return m;
    else if(k<a[m])
        return ricercaDicotomica(a,k,i,m-1);
    else 
        return ricercaDicotomica(a,k,m+1,j);
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