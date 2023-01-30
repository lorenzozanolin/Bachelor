#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>

int main(int argc, char **argv)
{
  char *user = "denis";

  struct passwd *pwd = NULL;
  //uso getpwuid() assieme a strtol se ho il numero. Posso controllare se è un numero con isdigit della libreria ctype.h
  pwd = getpwnam(user);

  if(pwd == NULL) {
    fprintf(stderr, "L'utente %s non esiste", user);
    return 1;
  }

  // Stampo i miei ID
  printf("uid=%d, gid=%d, euid=%d, egid=%d\n",
         getuid(), getgid(), geteuid(), getegid());

  // Stampo gli ID dell'utente che vogliamo impersonare
  uid_t new_uid = pwd->pw_uid;
  gid_t new_gid = pwd->pw_gid;
  printf("L'uid dell'utente %s è %d\n", user, new_uid);
  printf("Il gid dell'utente %s è %d\n", user, new_gid);

  printf("Cambio i miei uid/gid/euid/egid a quelli dell'utente %s\n", user);

  int err = 0;

  err += seteuid(new_uid);
  err += setegid(new_gid);

  if(err < 0) {
    perror("Impossibile cambiare utente");
    return 1;
  }

  // Ristampo i miei ID
  printf("uid=%d, gid=%d, euid=%d, egid=%d\n",
         getuid(), getgid(), geteuid(), getegid());

  // Eseguo effettivamente il comando
  execlp("ls", "ls", "-l", NULL);
  perror("Chiamata exec() fallita");

  return 1;
}

