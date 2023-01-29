#include<stdio.h>
int main(){
    printf("Inserire i due numeri\n");

    int n1,n2;
    int somma = 0;
    scanf("%d",&n1);
    scanf("%d",&n2);
    somma = n1+n2;
    printf("La somma: %d\n",somma);
    return 0;
}