%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}

%token WHILE LPAREN RPAREN LBRACE RBRACE ID NUMBER EQ LT GT PLUS MINUS MUL DIV SEMICOLON ASSIGN

%%

program:
    while_stmt { printf("Valid while statement!\n"); }
    ;

while_stmt:
    WHILE LPAREN condition RPAREN LBRACE stmt_list RBRACE
    | error { printf("Syntax error in while statement!\n"); yyerrok; yyclearin; }
    ;

condition:
    expr EQ expr
    | expr LT expr
    | expr GT expr
    | error { printf("Invalid condition in while()!\n"); yyerrok; yyclearin; }
    ;

stmt_list:
    stmt stmt_list
    | stmt
    | /* Allow empty {} */
    ;

stmt:
    ID ASSIGN expr SEMICOLON
    | error { printf("Syntax error in statement!\n"); yyerrok; yyclearin; }
    ;

expr:
    expr PLUS expr
    | expr MINUS expr
    | expr MUL expr
    | expr DIV expr
    | ID
    | NUMBER
    | LPAREN expr RPAREN  // Allow (expr)
    ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Enter a while statement:\n");
    yyparse();
    return 0;
}
