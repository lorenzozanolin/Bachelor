# Equivalenza tra tipi

> **Equivalenza**: due espressioni di tipo ```T``` e ```S``` sono equivalenti se denotano “lo stesso tipo".

> **Compatibilità**: ```T``` è compatibile con ```S``` quando valori di ```T``` possono essere usati in contesti dove ci si attende valori ``S``` ma non necessariamente il viceversa.


## Per nome stretta

Due tipi sono equivalenti per nome solo se hanno lo stesso nome (cioè un tipo è equivalente solo a se stesso).

```
type T1 = 1..10;
type T2 = 1..10;
type T3 = int;
type T4 = int;
```

introducono 4 tipi distinti e senza equivalenza tra essi.

## Per nome lasca

Due tipi sono equivalenti se hanno los tesso nome o se sono alias per lo stesso tipo.
Nel caso precedente abbiamo ```T1 = T2``` e ```T3 = T4```.

## Equivalenza strutturale

È la minima relazione di equivalenza tale che soddisfi le seguenti 3 proprietà:

1. Un nome di tipo è equivalente a se stesso.
2. Se un tipo  ```T```è introdotto con una definzione di tipo ```type T = espressione```, ```T``` è equivalente a ```espressione```.
3. Se due tipi sono costruiti applicando lo stesso costruttore di tipo a tipi equivalenti, allora essi sono equivalenti.

In altre parole se si applica la regola di riscrittura e si ottiene lo stesso tipo base allora i tipi sono quivalenti.

```
typedef struct{int i; float f} coppia;
typedef struct{int j; coppia c} A;
typedef struct{int j; struct{int i; float f} c} B;
```

### Ambiguità

sono tutti e 3 equivalenti.
Considerando invece le seguenti dichiarazione:

```
type S = struct{
	int a;
	int b;
}
type T = struct{
	int n;
	int m;
}
type U = struct{
	int m;
	int n;
}
```

non è chiaro se siano equivalenti.

Infine le seguenti dichiarazioni:

```
type R1 = struct{
	int a;
	R2 p;
}
type R2 = struct{
	int a;
	R1 p;
}
```

possiamo pensare che ```R1``` e ```R2``` siano equivalenti ma il controllore non riesce a risolvere la mutua ricorsione.

## Equivalenza in C

- Equivalenza strutturale per array e tipi definiti con ```typedef```.
- Equivalenza per nome per ```struct``` e ```union```

---

## Esempio di esercizio

```
typedef int intero;
typedef intero[32] vettore;
typedef struct{vettore v; intero x} coppia
typedef coppia pair

vettore a;
int[32] b;
intero[32] c;
coppia d;
pair e;
struct{int[32] v; int x} f;
struct{int x; vettore v} g;
```

- Equivalenza per nome stretta: nessuno
- Equivalenza per nome lasca: ```{a,c}```, ``` {d,e}```
- Equivalenza in C: ```{a,b,c}```, ```{d,e}```
- Equivalenza strutturale: ```{d,e,f,g}```
