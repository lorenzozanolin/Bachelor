ESAME 18 LUGLIO 2019

1.
cat ~/.bash_history | sort | uniq | wc -l

2.
result=$(cat /etc/passwd | cut -d: -f3)
c=0
for i in $result
do
  c=$[$c+$i]
done
echo $c
exit 0

3.

#include <stdlib.h>
#include <stdio.h>

struct List{
    int num;
    struct List* succ;
};

void insert(struct List*,int);
void visualizza(struct List *);

int main(){

    FILE *file = fopen("C:/Users/User/Desktop/file.txt","r");

    if(file == NULL){
        printf("Errore\n");
    }

    struct List* list = NULL; //la dichiaro null qui cosi al primo avvio crea il primo nodo
    int n;
    while(fscanf(file,"%d",&n) != -1){
        insert(list,n);
    }
    fclose(file);
    visualizza(list);

    return 0;
}

void insert(struct List *list,int n){
    if(list == NULL){
        list->num = n;
        list->succ = NULL;
    }
    else{
        while(list->succ != NULL){
            list = list->succ;
        }
        struct List* new =(struct List*) malloc(sizeof(struct List));
        new ->num = n;
        new ->succ =  NULL;
        list->succ = new;
    }
}

void visualizza(struct List *n){
  while(n->succ != NULL){
    printf("%d",n->num);
    struct List *p = n->succ;
    n = n->succ;
  }
  printf("%d",n->num);
}

4.

#include <stdio.h>
#include <stdlib.h>

int main(){

    int n1,n2;
    while(scanf("%d - %d",&n1,&n2) != EOF){
        printf("%d\n",n1-n2);
    }
    return 0;
}

5.

#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<sys/wait.h>

int main(int argc, char **argv){

    int pid = fork();

    if(pid == 0){ //figlio

       if(argc == 0)
        {
            execlp("ps","ps",NULL);
            perror("Errore nell'exec");
            return 1;
        }
        else{
            execlp("ps","ps",argv[1],NULL);
            perror("Errore nell'exec");
            return 1;
        }

    }
    else{ //padre che aspetta il figlio
        wait(NULL);
        printf("ps eseguita correttamente\n");
        return 0;
    }
}
