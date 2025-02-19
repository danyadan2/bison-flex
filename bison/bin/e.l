%{
#define YYSTYPE double
#include "e.tab.h"
#include <stdlib.h>
#include <string.h>

double sym[26]; 
%}

%option noyywrap yylineno

DIGIT    [0-9]
ID       [a-z]
NUMBER   {DIGIT}+((\,|\.){DIGIT}*)?

%%

{NUMBER}    {
                yylval = atof(yytext);
                return ICONST;
            }

{ID}        {
                yylval = (double)(yytext[0] - 'a'); 
                return LETTER;
            }

"="         { return '='; }
";"         { return ';'; }
"+"         { return '+'; }

[ \t\r\n]+  { }
.           { printf("Неизвестный символ: %s\n", yytext); }
