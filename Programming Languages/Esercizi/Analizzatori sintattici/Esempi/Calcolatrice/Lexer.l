%{
  /* Definition section*/
  #include "y.tab.h"
  extern yylval;
%}

%%
[0-9]+ {
      yylval = atoi(yytext);
      return NUMBER;
      }

[a-zA-Z]+ { printf("Questo non è un numero"); }
[ \t]+     ; /*For skipping whitespaces*/

\n     { return yytext[0]; }
.     { return yytext[0]; }

%%