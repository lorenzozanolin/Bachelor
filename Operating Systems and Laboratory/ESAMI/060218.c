ESAME 06.02.2018

1.
date | tr -s ' ' | cut -d' ' -f4

tr -s ' ' serve a comprimere tutti gli spazi adiacenti

2.
if (test -e $1) && (test -f $1)
 then
  dim=`wc -c < $1`
  echo "Dimensione di $1: $dim byte"
  for ((i=0;i<=$dim;i++))
   do
     echo -n \*
   done
 else
  echo "input non valido"
  exit 1
fi
exit 0

3.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv){

    if(argc <= 1){ //non è stata inserita alcuna opzione, il primo elemento e' sempre il nome del file
        printf("Inserire almeno una stringa.\n");
        return 0;
    }
    //copio
    char** arr = malloc(sizeof(char *)*argc);
    for(int i=1; i<argc; i++){
        arr[i] = argv[i];
    }

    //ordino
    char *pa;
    for(int i=0; i<argc; i++){
        for(int j=i+1;j<argc; j++){
            if(strcmp(arr[i],arr[j]) == 1){ //se la stringa i e' maggiore della stringa i+1
                pa = arr[i];
                arr[i] = arr[j];
                arr[j] = pa;
            }
        }
    }

    //stampo
    for(int i=0; i<argc; i++){
        puts(arr[i]);
    }
    printf("\n");
    return 0;
}

4.

- - - - - *
- - - - * * *
- - - * * * * *
- - * * * * * * *
- * * * * * * * * *

5.

 # include < stdio .h >
 # include < stdlib .h >

 int main ()
 {
 int i , num ;
 int *data;

 printf ( " Enter total number of elements (1 to 100): " );
 scanf("%d",&num);

// A l l o c a t e s t h e memory f o r ’num ’ e l e m e n t s .
 data = (int *) calloc(num,sizeof(int));

 if( data == NULL)
 {
 printf ( " Error !!! memory not allocated . " );
 exit (0);
 }

 printf ( " \ n " );

 // S t o r e s t h e number e n t e r e d by t h e u s e r .
 for( i = 0; i < num ; ++ i )
 {
   scanf("%d",data +i);
 }

 // Loop t o s t o r e l a r g e s t number a t a d d r e s s d a t a
 for( i = 0; i < num ; ++ i )
 {
   if(data[0] < data[i])
      data[0] = data[i];
 }

 printf ( " Largest element = %d \n" , * data );

 return 0;
 }

 6.

 int c , * pc ;

 - pc= c; FALSA
 - *pc = &c; FALSA
 - pc = &c; VERA
 - *pc = c; VERA
