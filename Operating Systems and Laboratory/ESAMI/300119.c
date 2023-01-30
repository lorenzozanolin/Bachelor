LEZIONE 30.01.2019

1.
cat test.txt | sort | uniq -c

2.
read input
while test $input != fine
do
  count=$(echo $input |wc -c)
  echo $count byte
  for i in {1..$count}
    do
    echo -n "*"
    i=$[$i+1]]
    done
  read input
done
exit 0

3.

int main(){

  struct node_t * lista = malloc(sizeof(struct node_t));
  lista->data = 11;
  lista->next = malloc(sizeof(struct node_t));
  lista->next->data = 6;
  lista->next->next = malloc(sizeof(struct node_t));
  lista->next->next->data = 30;
  print(lista);
  return 0;
}

void print(struct node_t * head){
  if(head != NULL){
    printf("%d\n",head->data);
    head = head->next;
  }
}

4.
-----*
----* *
---*    *
--*       *
-***********

5.
a. Si c'e' il pericolo perche' non ci sono dei mutex a "proteggere" la zona critica
b. i mutex vanno piazzati prima e dopo il while (
ptrhead_mutex_lock(&mutex);
  while(){
  /* code */
  }
pthread_mutex_unlock(&mutex);
