%{
#include <stdio.h>
#include <stdlib.h>
#include "assignment5.tab.h"
%}

%%

[0-9]+              {
                        yylval = atoi(yytext);
                        return NUMBER;
                   }

[\t]                ;   // ignore tabs
\n                  return 0;  // exit on newline

"("                 return '(';
")"                 return ')';
"+"                 return '+';
"-"                 return '-';
"*"                 return '*';
"/"                 return '/';
"%"                 return '%';

.                   { /* ignore any other garbage */ }

%%

int yywrap() {
    return 1;
}
