%{
#include<stdio.h>
#include<ctype.h>
%}

%%
[a-z]    { putchar(toupper(yytext[0])); }
[A-Z]    { putchar(tolower(yytext[0])); }
.        { putchar(yytext[0]); }
%%

int yywrap(void) {}

int main(int argc, char *argv[]) {
    FILE *file;

    if (argc > 1) {
        file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Error opening file: %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        yyin = stdin;
    }

    yylex();

    if (argc > 1) {
        fclose(file);
    }

    return 0;
}
