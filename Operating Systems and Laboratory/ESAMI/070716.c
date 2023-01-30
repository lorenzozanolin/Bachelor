ESAME 07.07.2016
1.
a. ln /home/pippo/documento.txt link1
b. ln -s /home/pippo/documento.txt link2
c. Sì, c’è differenza fra link1 e link2 creati nei due punti precedenti: nel primo caso infatti
    si tratta di un alias per lo stesso numero di inode, ovvero, sia documento.txt che link1
    puntano allo stesso elemento dello stesso vettore di inode. Invece nel secondo caso link2
    punta ad un numero di inode diverso rispetto a quello puntato da documento.txt; infatti
    link2 altro non è che un file di testo (trattato in modo speciale dal sistema operativo)
    contenente il pathname del file documento.txt.

d. Sì, è possibile creare un link simbolico ad un file risiedente su un dispositivo fisico diverso
    da quello in cui risiede il link in quanto, come detto precedentemente, un link simbolico è
    un file di testo contenente un pathname. Quindi è sufficiente seguire il percorso per arrivare
    al file puntato. Al contrario non è possibile creare un link hard ad un file risiedente su un
    dispositivo fisico diverso da quello in cui risiede il link in quanto ogni dispositivo fisico ha
    un proprio vettore di inode (e non è possibile puntare ad inode di un dispositivo diverso da
    quello di origine).

2.
a. ps -f | grep 'lorenzo' | wc -l
b. len=$(cat /etc/passwd | wc -c)
c. cat /etc/passwd | cut -d: -f1,3 | tr : _ > estratto.txt

3.
if ! test -f $1
then
 echo Inserire un file valido
fi
otput=$(cat $1)
l=0
line=0
for i in $output
do
 lRiga=$(echo $i | wc -c)
 if test $lRiga -gt $l
  then
    l=$lRiga
    line=$(echo $i)
 fi
done
echo $line
exit 0


4.
pthread_mutex_t mutex=PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_lock(&mutex);
while(){

}
pthread_mutex_unlock(&mutex);
server.sin_family = AF_INET;
server.sin_addr.s_addr = inet_addr("127.0.0.1");
server.sin_port = htons(SERVER_PORT);
if(bind(sock,&server,sizeof(struct sockadrr_in)) == -1)
listen(sock,15);

while((len=recv(fd,inputine,LINESIZE−1,0))>0){
inputline[len]=’\0’;
sprintf(buffer,"Thread␣n.␣%d:␣",num);
strcat(buffer,inputline);
logfd=fopen("log.txt","a");/ apro i l f i l e l o g . t x t in append ∗/
fputs(buffer,logfd);/∗ s c r i v o n e l f i l e ∗/
fclose(logfd); /∗ c h i u d o i l f i l e l o g . t x t ∗/
}
