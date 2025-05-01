%{
    #include <stdio.h>
    #include <stdlib.h>
    
    int line_no = 1; // Line number tracker
    %}
    
    identifier [a-zA-Z][a-zA-Z0-9]*
    
    %%
    
    \n { 
        line_no++; // Increment line number on new line
    }
    
    #.* { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "Preprocessor Directive", yytext); 
    }
    
    int|float|char|double|while|do|if|break|continue|void|switch|return|else|goto { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "Keyword", yytext); 
    }
    
    {identifier}\( { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "Function", yytext); 
    }
    
    \{ { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "Block Begin", yytext); 
    }
    
    \} { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "Block End", yytext); 
    }
    
    {identifier}(\[[0-9]\]) { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "Identifier", yytext); 
    }
    
    \".*\" { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "String", yytext); 
    }
    
    [0-9]+ { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "Number", yytext); 
    }
    
    \<=|\>=|\<|\>|\== { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "Relational Operator", yytext); 
    }
    
    \=|\+|\-|\/|\&|% { 
        printf("%-8d | %-20s | %-20s | %-20s\n", line_no, yytext, "Operator", yytext); 
    }
    
    .|\n ;
    
    %%
    
    int main(int argc, char **argv) {
        FILE *file;
        file = fopen("input.c", "r");
        if (!file) {
            printf("Could not open the file!!!\n");
            exit(0);
        }
    
        // Print the formatted header
        printf("------------------------------------------------------------------------------------------\n");
        printf("%-8s | %-20s | %-20s | %-20s\n", "Line No", "Lexeme", "Token", "Token Value");
        printf("------------------------------------------------------------------------------------------\n");
    
        yyin = file;
        yylex();
        return 0;
    }
    
    int yywrap() {
        return 1;
    }
    