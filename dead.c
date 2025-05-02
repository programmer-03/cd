#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_LINES 100
#define MAX_LEN 100


typedef struct {
    char var[20];     
    char expr[MAX_LEN]; 
    int used;           
    char original[MAX_LEN];
} Statement;

Statement lines[MAX_LINES];
int line_count = 0;


void trim(char *str) {
    char *end;
    while (isspace(*str)) str++;
    end = str + strlen(str) - 1;
    while (end > str && isspace(*end)) *end-- = '\0';
}


void find_used_vars(char *expr, char used_vars[][20], int *count) {
    char *token = strtok(expr, " +-*/%;=()\n");
    while (token != NULL) {
        
        if (!isdigit(token[0])) {
            strcpy(used_vars[(*count)++], token);
        }
        token = strtok(NULL, " +-*/%;=()\n");
    }
}

int main() {
    char input[MAX_LEN];

    printf("Enter C-like assignment statements (one per line).\n");
    printf("Press ENTER on an empty line to finish input.\n\n");

    
    while (1) {
        printf(">> ");
        fgets(input, sizeof(input), stdin);
        if (strcmp(input, "\n") == 0) break;

        strcpy(lines[line_count].original, input);

        
        char *eq = strchr(input, '=');
        if (!eq) continue;
        *eq = '\0';
        trim(input); 
        trim(eq + 1);

        strcpy(lines[line_count].var, input);
        strcpy(lines[line_count].expr, eq + 1);
        lines[line_count].used = 0;

        line_count++;
    }

    
    char used_vars[100][20];
    int used_count = 0;

    for (int i = line_count - 1; i >= 0; i--) {
        
        for (int j = 0; j < used_count; j++) {
            if (strcmp(lines[i].var, used_vars[j]) == 0) {
                lines[i].used = 1;
                break;
            }
        }

    
        if (lines[i].used) {
            char expr_copy[MAX_LEN];
            strcpy(expr_copy, lines[i].expr);
            find_used_vars(expr_copy, used_vars, &used_count);
        }
    }

    
    printf("\nOptimized Code (Dead Code Removed):\n");
    for (int i = 0; i < line_count; i++) {
        if (lines[i].used || i == line_count - 1) {
            printf("%s", lines[i].original);
        }
    }

    return 0;
}

a = 5;
b = a + 2;
c = b + 3;
d = 10;
printf("%d", c);
