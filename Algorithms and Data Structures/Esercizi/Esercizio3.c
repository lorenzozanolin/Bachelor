#include <stdio.h>

int main(){
  printf("Inserire un messaggio\n");
  char s[1000];
  scanf("%[^\n]s",s);  //con scanf("%s\n", ); si salva tutta la stringa e poi la prima parte la salva nella variabile, il resto rimangono nel buffer
                      //^\n tutti i caratteri tranne a capo --> %s : una stringa fino al PRIMO SEPARATORE (\n, '',...)
                      // %[abc]s : una stringa fatta solamente di a,b,c es abcaba

  for(int i=0; s[i] != '\0'; i++){
      printf("%s\n",&(s[i]));
  }
  return 0;
}
