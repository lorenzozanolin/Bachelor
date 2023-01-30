ESAME 14.06.2018

1.
date | tr -s ' ' | cut -d' ' -f5 | cut -d: -f1
tr -s serve a comprimere gli spazi

2.

IFS =
lista_file = ‘ find $1 ‘ # lista_file conterra ‘ tante righe quante sono
                         # quelle prodotte dal find
l = ‘ echo $lista_file | wc -l ‘ # calcola il numero di elementi ( righe )
                                 # di lista_file
i =1

while test $i - le $l ;
 do
  f = ‘ echo $lista_file | head -n $i | tail -1‘
  echo -n $f ’ --> ’
  if test -f $f
      echo file
  else
      echo directory
  i=$[$i+1]
  fi
  done

3.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv){

    if(argc < 1){ //non è stata inserita alcuna opzione, il primo elemento e' sempre il nome del file
        printf("Inserire un percorso valido.\n");
        return 0;
    }

    char* link = argv[1]; //percorso del file da copiare
    FILE* file = fopen(link,"r");

    if(!file) {
        fprintf(stderr, "Errore nell’apertura del primo file!\n");
        return 2;
    }

    FILE* file2 = fopen("secondo file.txt","w"); //se non esiste lo crea
    if(!file2) {
        fprintf(stderr, "Errore nell’apertura del secondo file!\n");
        return 2;
    }

    for(char c=fgetc(file);c!= EOF;c=fgetc(file))
    {
        if((c>= 'A' && c<= 'Z') || (c>= 'a' && c<= 'z'))
            fputc(c,file2);
    }
    fputc(EOF,file2);

    fclose(file);
    fclose(file2);

}

4.

  * * * * * * * * *
    * * * * * * *
      * * * * *
        * * *
          *

5.

# include <stdio.h>
# include <stdlib.h>

struct course
{
 int marks ;
 char subject [30];
};

int main ()
{
 struct course * ptr ;
 int i , noOfRecords ;
 printf ( " Enter number of records : " );
 scanf ("%d",&noOfRecords);

// A l l o c a t e s t h e memory f o r n oO fR ec o rd s s t r u c t u r e s wi t h p o i n t e r
// p t r p o i n t i n g t o t h e b a s e a d d r e s s .
 ptr =(struct course *) malloc (sizeof(struct course)*noOfRecords);

 for( i = 0; i < noOfRecords ; ++i ){
  printf ( " Enter name of the subject and marks respectively :\n " );
  scanf ("%s %d" , ptr[i].subject , &(ptr[i].marks));
 }

 printf ( " Displaying Information :\n " );

 for( i = 0; i < noOfRecords ; ++i )
   printf ( "%s\t%d\n" , ptr[i].subject , ptr[i].marks);

 return 0;
}

6.

# include <stdio.h>

int main(){
    int *pc;
    int c;
    c=22;
    printf("Indirizzo di c:%u\n", &c);
    printf("Valore di c:%d\n\n", c);
    pc=&c ;
    printf ("Indirizzo memorizzato nel puntatore pc :%u\n " , pc);
    printf ("Valore puntato da pc :%d\n\n " , *pc);
    c=11;
    printf ("Indirizzo memorizzato nel puntatore pc :%u\n " , pc);
    printf ("Valore puntato da pc :%d\n\n " , *pc);
    *pc =2;
    printf ( " Indirizzo di c :%u\n " , &c);
    printf ( " Valore di c :%d\n\n " , c);
    return 0;
}
