%{
#include "assignment6.tab.h"
%}

%%

"while"      { return WHILE; }
"("          { return LPAREN; }
")"          { return RPAREN; }
"{"          { return LBRACE; }
"}"          { return RBRACE; }
[0-9]+       { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
"="          { return ASSIGN; }
"=="         { return EQ; }
"<"          { return LT; }
">"          { return GT; }
"+"          { return PLUS; }
"-"          { return MINUS; }
"*"          { return MUL; }
"/"          { return DIV; }
";"          { return SEMICOLON; }
[ \t\n]+     { /* Ignore whitespace */ }
.            { return yytext[0]; }

%%

int yywrap() { return 1; }

