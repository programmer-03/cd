%{
#include <stdio.h>
#include <stdlib.h>

int flag = 0;
int yylex();                      // Declare yylex
void yyerror(const char *s);     // Declare yyerror
%}

%token NUMBER
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

%%

ArithmeticExpression:
    E {
        printf("\nResult = %d\n", $$);
        return 0;
    }
;

E:  E '+' E     { $$ = $1 + $3; }
  | E '-' E     { $$ = $1 - $3; }
  | E '*' E     { $$ = $1 * $3; }
  | E '/' E     { 
        if ($3 == 0) {
            yyerror("Division by zero!");
            YYABORT;
        }
        $$ = $1 / $3; 
    }
  | E '%' E     { $$ = $1 % $3; }
  | '(' E ')'   { $$ = $2; }
  | NUMBER      { $$ = $1; }
;

%%

void yyerror(const char *s) {
    printf("\nError: %s\n", s);
    printf("Entered arithmetic expression is Invalid\n\n");
    flag = 1;
}

int main() {
    printf("Enter any arithmetic expression:\n");
    yyparse();

    if (flag == 0)
        printf("Entered arithmetic expression is Valid\n\n");

    return 0;
}
