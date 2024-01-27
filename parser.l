%{
#include "parser.tab.h"
%}
%%
[0-9]+ { yylval.num = atoi(yytext); return NUMBER; }
[\t] ; // Ignore tabs
\n return 0;
. return yytext[0];
%%