#include "Tree.h"
#include <string.h>
#include <math.h>
#include <stdio.h>


char tree[4095]="";
char node[4095]="";
int depth=0; //prodondita dell'albero
int num=0;  // numero di foglie

void createBranch(){
    strncat(tree,"\n",strlen("\n")); //stampa colonne verticali
    for(int i=1; i<num;i++){
        strncat(tree,"     |",strlen("     |"));
    }
    if(depth>1)
    {
        strncat(tree,"     /",strlen("     /"));
        for(int i=1; i<depth;i++){
            strncat(tree,"      ",strlen("      "));
        }  
    }
    else{
        strncat(tree,"     |",strlen("     |"));
    }
    strncat(tree,"\n",strlen("\n")); //stampa slash
    for(int i=1; i<num-1;i++){
        strncat(tree,"|     ",strlen("|     "));
    }
    strncat(tree," \\   / ",strlen(" \\   / "));
    if(depth>1)
    {
      for(int i=1; i<depth;i++){
        strncat(tree,"      ",strlen("      "));
      }  
    }
}

void createVertical(){
    strncat(tree,"\n",strlen("\n"));
    for(int i=1; i<num-1;i++){
        strncat(tree,"|     ",strlen("|     "));
    }
    num--;
}

void concatenateNode(char* node,int len)
{
    strncat(tree,node,len);
    if(depth>1)
    {
      for(int i=1; i<depth;i++){
        strncat(tree,"      ",strlen("      "));
      }  
    }
}

char * append(char * string1, char * string2)
{
    char * result = NULL;
    asprintf(&result, "%s%s", string1, string2);
    return result;
}

void printPTree() //stampa l albero invertendo la stringa
{
    reverseStr(tree);
    printf(tree);
    strcpy(tree,""); //azzero la stringa
    depth=0; //azzero la profondita
    num=0;
}

void reverseStr(char* str) //funzione per invertire la stringa
{
  int n = strlen(str);

  for (int i = 0; i < n / 2; i++)
  {
    char ch = str[i];
    str[i] = str[n - i - 1];
    str[n - i - 1] = ch;
  }
}

void createLeaf(int val) //procedura per creare le foglie dell albero
{
    int len=sprintf(node,"     %d", val) ; //salvo il valore numerico dentro alla stringa node
    concatenateNode(node,len); //concateno alla stringa albero il nodo
    num++; //incremento il counter di foglie (serve per fare output carino)
}

void createNode(char* intern,int len)
{
    depth++; //incremento il contatore della profondita
    createBranch(); //disegno i rami obliqui
    createVertical(); //disegno i rami verticali
    concatenateNode(intern,len); //concateno nella stringa il nodo
}