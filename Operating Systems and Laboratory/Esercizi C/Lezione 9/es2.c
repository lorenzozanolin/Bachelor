/*
Scrivere le seguenti funzioni che manipolino un array passato come argomento (nei modi visti):
- Una funzione reverse() per invertire l’ordine degli elementi in un array.
- Una funzione sort() per ordinare un array di numeri interi (riutilizzare quanto scritto per l’esercizio 3 della Lezione 8).
- Scrivere una funzione qsort() che implementi un algoritmo di ordinamento in maniera ricorsiva
*/


#include <stdio.h>
#define dim 5
void reverse(int*,int);
void sort(int*,int);
void visualizza(int*,int);
int main()
{
	int arr[dim]={};
	printf("Inserimento vettore: \n");
	
	for(int i=0;i<dim;i++)
	{
		printf("Inserisci il numero:");
		scanf("%i",&arr[i]);
	}
	//reverse(arr,dim);
	sort(arr,dim);
	visualizza(arr,dim);
}

void visualizza(int* a,int size)
{
	for(int i=0;i<size;i++)
	{
		printf("%i",a[i]);
	}
}

void reverse(int* a,int size)
{
	int temp=0;
	
	for(int i=0;i<(size/2);i++)
	{
		temp=a[i];
		a[i] = a[size-1-i];
		a[size-1-i] = temp; //posizione specchiata
	}
}

void sort(int*a,int size)
{
	int temp=0;
	
	for(int i=0;i<size-1;i++)
	{
		for(int j=i+1;j<size;j++)
		{
			if(a[i]>a[j])
			{
				temp=a[i];
				a[i] = a[j];
				a[j] = temp; 
			}
		}	
	}
}
