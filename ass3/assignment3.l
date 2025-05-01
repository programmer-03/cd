%{
#include <stdio.h>
#include <string.h>

int line_number = 1;

%}

%%


\n                                                                       { line_number++; }

"+"+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]          { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid Number", yytext); } // Decimal Number
"+"+[0-9]+" "+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]      { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid Number", yytext); } // Decimal Number

[A-Z]+[a-z]+" "+[A-Za-z]+                                                { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid Name", yytext); }

[a-z0-9]+"@"+[a-z]+"."+[a-z]+"."+[a-z]+                                  { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid Email", yytext); }
[a-z0-9]+"@"+[a-z]+"."+[a-z]+                                            { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid Email", yytext); }
[www]+"."+[a-z]+"."+[a-z]+"."+[a-z]+                                     { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid URL", yytext); }
[https://]+[www]+"."+[a-z]+"."+[a-z]+"."+[a-z]+                          { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid URL", yytext); }
[www]+"."+[a-z]+"."+[a-z]+                                               { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid URL", yytext); }
[https://]+[www]+"."+[a-z]+"."+[a-z]+                                    { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid URL", yytext); }
[0-9][0-9]+"-"+[0-9][0-9]+"-"+[0-9][0-9][0-9][0-9]+                      { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid Date", yytext); }
[0-9][0-9]+"/"+[0-9][0-9]+"/"+[0-9][0-9]+                                { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid Date", yytext); }
[0-9]+":"+[0-9][0-9]+":"+[0-9][0-9]                                      { printf("%-10d %-30s %-25s %-25s\n", line_number, yytext, "Valid Time", yytext); }
.+                                                                       { printf("%-10d %-30s %-25s %-15s\n", line_number, yytext, "INVALID", yytext); }



%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

      yyin = file;
    printf("\n-----------------------------------------------------------------------------------------------\n");
    printf("%-10s %-30s %-25s %-15s\n", "Line No", "Lexeme", "Token", "Token Value");
    printf("-----------------------------------------------------------------------------------------------\n");

    yylex();
    printf("-----------------------------------------------------------------------------------------------\n\n");
    fclose(file);
    return 0;
}
