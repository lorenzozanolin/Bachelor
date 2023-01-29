#include<string.h>
#include<stdio.h>

int main(){
    char s[200];
    printf("Inserire la stringa\n");
    scanf("%[^\n]s",s);

    for(int i=strlen(s);i!=0;i--){
        printf("%c",s[i]);
    }
    printf("%c",s[0]);
    return 0;
}