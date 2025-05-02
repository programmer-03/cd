#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX 100

struct Quadruple {
    char op[5];
    char arg1[10];
    char arg2[10];
    char result[10];
};

struct Quadruple code[MAX];
int n;

// Check if a string is a constant (integer)
int is_constant(char *s) {
    for (int i = 0; s[i]; i++)
        if (!isdigit(s[i])) return 0;
    return 1;
}

// Perform constant propagation
void constant_propagation() {
    char vars[MAX][10], values[MAX][10];
    int k = 0;

    for (int i = 0; i < n; i++) {
        // Store constant assignments like: a = 5
        if (strcmp(code[i].op, "=") == 0 && is_constant(code[i].arg1)) {
            strcpy(vars[k], code[i].result);
            strcpy(values[k], code[i].arg1);
            k++;
        }

        // Replace known constants
        for (int j = 0; j < k; j++) {
            if (strcmp(code[i].arg1, vars[j]) == 0)
                strcpy(code[i].arg1, values[j]);
            if (strcmp(code[i].arg2, vars[j]) == 0)
                strcpy(code[i].arg2, values[j]);
        }
    }
}

// Display TAC in table form
void print_code() {
    printf("\n%-10s %-10s %-10s %-10s\n", "Op", "Arg1", "Arg2", "Result");
    printf("--------------------------------------------------\n");
    for (int i = 0; i < n; i++) {
        printf("%-10s %-10s %-10s %-10s\n",
               code[i].op, code[i].arg1, code[i].arg2, code[i].result);
    }
}

int main() {
    printf("Enter number of instructions: ");
    scanf("%d", &n);

    printf("\nEnter instructions in format: OP ARG1 ARG2 RESULT\n");
    printf("Example: + a b c  (meaning c = a + b)\n");

    for (int i = 0; i < n; i++) {
        printf("Instruction %d: ", i + 1);
        scanf("%s %s %s %s", code[i].op, code[i].arg1, code[i].arg2, code[i].result);
    }
    printf("quadruples\n");
    print_code();

    constant_propagation();

    printf("\nOptimized Three Address Code with Constant Propagation:\n");
    print_code();

    return 0;
}
