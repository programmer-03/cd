%{
#include <stdio.h>

int vowel_count = 0;
%}

%%

[aAeEiIoOuU]     { vowel_count++; }       // Match a single vowel and count

[^ \t\n]+        ;  // Match other words or non-vowel tokens, ignore

\n               {
                    printf("Total vowels: %d\n", vowel_count);
                    vowel_count = 0;  // Reset for next line
                }

.                ;  // Ignore other characters

%%

int main() {
    printf("Enter text (press Enter to see vowel count):\n");
    yylex();
    return 0;
}

int yywrap() { return 1; }
