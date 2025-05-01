%{
#include <stdio.h>
#include <string.h>

int is_noun(char word[]);
int is_verb(char word[]);
int is_adjective(char word[]);
int is_adverb(char word[]);

int line_number = 1;
%}

%%

[ \t\r]+             { /* skip */ }

\n                   { line_number++; }

[.,;!?]              { printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "PUNCTUATION", yytext); }

\"(\\.|[^\"])*\"     { printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "QUOTATION", yytext); }

[0-9]+\.[0-9]+       { printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "DECIMAL", yytext); }

[0-9]+               { printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "INTEGER", yytext); }

[a-zA-Z]+            {
                        if (is_noun(yytext))
                            printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "NOUN", yytext);
                        else if (is_verb(yytext))
                            printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "VERB", yytext);
                        else if (is_adjective(yytext))
                            printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "ADJECTIVE", yytext);
                        else if (is_adverb(yytext))
                            printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "ADVERB", yytext);
                        else
                            printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "WORD", yytext);
                     }

.                    { printf("| %-8d | %-15s | %-15s | %-15s |\n", line_number, yytext, "UNKNOWN", yytext); }

%%

int is_noun(char word[]) {
    char *nouns[] = {"planet", "river", "eagle", "sun", "teacher", "code", "light", NULL};
    for (int i = 0; nouns[i] != NULL; i++) {
        if (strcasecmp(word, nouns[i]) == 0) return 1;
    }
    return 0;
}

int is_verb(char word[]) {
    char *verbs[] = {"runs", "flies", "teaches", "build", "write", "shines", "float", NULL};
    for (int i = 0; verbs[i] != NULL; i++) {
        if (strcasecmp(word, verbs[i]) == 0) return 1;
    }
    return 0;
}

int is_adjective(char word[]) {
    char *adjs[] = {"bright", "quiet", "intelligent", "wild", "tall", "calm", NULL};
    for (int i = 0; adjs[i] != NULL; i++) {
        if (strcasecmp(word, adjs[i]) == 0) return 1;
    }
    return 0;
}

int is_adverb(char word[]) {
    char *advs[] = {"swiftly", "softly", "rarely", "quickly", "boldly", NULL};
    for (int i = 0; advs[i] != NULL; i++) {
        if (strcasecmp(word, advs[i]) == 0) return 1;
    }
    return 0;
}

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    if (!fp) {
        perror("File error");
        return 1;
    }

    yyin = fp;

    printf("---------------------------------------------------------------\n");
    printf("| %-8s | %-15s | %-15s | %-15s |\n", "Line No", "Lexeme", "Token", "Token Value");
    printf("---------------------------------------------------------------\n");

    yylex();

    printf("---------------------------------------------------------------\n");
    fclose(fp);
    return 0;
}
