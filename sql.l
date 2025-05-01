%{
#include <stdio.h>
int line_no = 1;
%}

KEYWORD  CREATE|TABLE|INT|PRIMARY|KEY|VARCHAR|VARCHAR|INSERT|INTO|SELECT|FROM

%%
[ \t]   {}
\n      {line_no++;}
{KEYWORD} {printf("%-20d %-20s %-20s %-20s\n",line_no,yytext,"KEYWORD",yytext);}
[,?=;]  {printf("%-20d %-20s %-20s %-20s\n",line_no,yytext,"Punctuation",yytext);}
\'.*\'  {printf("%-20d %-20s %-20s %-20s\n",line_no,yytext,"String",yytext);}
[a-zA-z]+  {printf("%-20d %-20s %-20s %-20s\n",line_no,yytext,"Variable",yytext);}
[0-9]+   {printf("%-20d %-20s %-20s %-20s\n",line_no,yytext,"Number",yytext);}
"*"      {printf("%-20d %-20s %-20s %-20s\n",line_no,yytext,"Operator",yytext);}
\(       {printf("%-20d %-20s %-20s %-20s\n",line_no,yytext,"LParen",yytext);}
\)       {printf("%-20d %-20s %-20s %-20s\n",line_no,yytext,"RParen",yytext);}
%%

int main() {
    FILE  *file;
    file = fopen("input.sql","r");
    printf("%-20d %-20s %-20s %-20s\n",line_no,"Lexeme","Token","Token Value");
    yyin = file;
    yylex();
    fclose(file);
    return 0;
}

int yywrap() {
    return 0;
}