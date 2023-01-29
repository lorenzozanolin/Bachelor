#include<stdio.h>
#include <string.h>
#define MAX_LINE_SIZE 1000

struct coppia{
    int i;
    int j;
};
int scanArray(int*);
struct coppia trovaIndici(int *,int,int);
struct coppia trovaIndiciRec(int *,int,int,int);
int main(){
    int arr[200];
    int k;
    
    int size = scanArray(arr);
    scanf("%d",&k);

    struct coppia c = trovaIndici(arr,k,size);
    printf("%d %d\n",c.i,c.j);
    return 0;
}

struct coppia trovaIndici(int * a,int k,int size){
    return trovaIndiciRec(a,k,0,size -1);
}

struct coppia trovaIndiciRec(int * a,int k,int i,int j){
    int somma = a[i] + a[j];

    if(i == j){
        struct coppia c;
        c.i = -1;
        c.j = -1;
        return c;
    }

    if(somma == k){
        struct coppia c;
        c.i = i;
        c.j = j;
        return c;
    }
    else if(somma< k)
        return trovaIndiciRec(a,k,i+1,j);
    else
        return trovaIndiciRec(a,k,i,j-1); 
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