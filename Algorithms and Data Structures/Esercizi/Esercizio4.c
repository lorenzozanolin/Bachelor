#include<stdio.h>
#include<string.h>

int main(){

    char s[200];
    scanf("%[^\n]s", s);

    for(int i=strlen(s); i>0;i--){
        for(int j=0;j<i;j++){
            printf("%c",s[j]);
        }
        printf("\n");
    }

    return 0;
}