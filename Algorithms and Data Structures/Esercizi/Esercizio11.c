#include <stdio.h>
#include <string.h>

int periodoFrazionario(char *,int);

int main(){

    char s[200];
    printf("Inserire la stringa\n");
    scanf("%[^\n]s",s);

    int period = periodoFrazionario(s,strlen(s));
    printf("%d \n",period);
    return 0;
}

int periodoFrazionario(char * s,int size){

    int r[size];
    r[0] = -1;
    int z;

    for(int i=0;i<size-1;i++){
        z = r[i];

        while (z>=0 && (s[z+1] != s[i+1])){
            z = r[z];
        }
        if(s[z+1] == s[i+1]){
            r[i+1] = z+1;
        } else {
            r[i+1] = -1;
        }
        
    
    }

    return size - (r[size-1] +1);
}