/*
Definire una funzione int lg(int n) che trovi il massimo
numero m tale che 10^m ≤ n (ovvero la parte intera di log10 n).
*/

#include <stdio.h>

int lg(int);
int lg2(int);
int power(int, int);

int main()
{
  printf("%d\n", lg(1500));

  return 0;
}

int power(int m, int n) // definizione
{
   int p = 1;
   for (int i = 0; i < n; ++i)
      p = p * m;
   return p; // restituisce il valore di p al chiamante
}

// Versione che riutilizza power()
int lg(int n)
{
  int result = 0;
  for(int m = 0; power(10, m) <= n; ++m) {
     result = m;
  }

  return result;
}
