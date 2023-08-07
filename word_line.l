%{
#include<stdio.h>
#include<string.h>

int i = 0;
int nchar, nword, nline;
%}
%%
\n { nline++; nchar++; }
[^ \t\n]+ { nword++, nchar += yyleng; }
. { nchar++; }
%%

int yywrap(void){}

int main(int argc, char* argv[])
{   FILE *fh;
    if (argc == 2 && (fh = fopen(argv[1], "r")))
       { yyin = fh;
        while(yylex()); 
        fclose(fh);
        printf("%d\t%d\t%d\n", nchar, nword, nline+1);
       
       }
    else{
            yylex();
            printf("%d\t%d\t%d\n", nchar, nword, nline);
        }
   
   
    return 0;
    }