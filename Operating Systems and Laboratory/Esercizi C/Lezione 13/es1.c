/*
Scrivere un programma C, versione semplificata del comando
Unix cat, per l’append di uno o più file su standard output
*/
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

int main(){

    FILE *file = fopen("C:/Users/User/Desktop/file.txt", "r"); //apro il primo file

    if(!file) {
        fprintf(stderr, "Errore nell’apertura del primo file!\n");
        return 2;
    }

    char c;
    do{
        c = fgetc(file); //leggo un singolo carattere
        putchar(c);      //lo stampo a schermo
    }while(c!= EOF);
    fclose(file);
    return 0;
}

//versione alternativa che pero' legge solo la prima riga

/*int main(){

    FILE *file = fopen("C:/Users/User/Desktop/file.txt", "r"); //apro il primo file

    if(!file) {
        fprintf(stderr, "Errore nell’apertura del primo file!\n");
        return 2;
    }

    char * str1;
    fscanf(file, "%s", str1); //LEGGE SOLO UNA RIGA
    //ora str1 contiene il testo contenuto nel file1
    printf(str1);
    return 0;
}*/

//versione del prof.
/*
#include <stdio.h>

int main(int argc, char **argv)
{
  for(int i = 1; i < argc; ++i) {
    FILE *file = fopen(argv[i], "r");

    if(!file) {
      perror("Unable to open the file");
      return 1;
    }

    for(char c = fgetc(file); c != EOF; c = fgetc(file)) {
      putchar(c);
    }

    fclose(file);
  }

  return 0;
}
*/

