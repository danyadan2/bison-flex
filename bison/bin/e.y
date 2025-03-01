%{
#include <stdio.h>
#include <stdlib.h>

#define YYSTYPE double

double sym[26]; 
int init[26] = {0}; 

int yyerror(const char *s);
int yylex(void);
%}

%token ICONST LETTER
%left '+'
%right '='

%%

p : /* empty */
  | p a
  ;

a : LETTER '=' e ';' { 
    sym[(int)$1] = $3; 
    init[(int)$1] = 1; 
    printf("%c = %f\n", (char)((int)$1 + 'a'), sym[(int)$1]); 
}
  ;

e : f '+' e  { $$ = $1 + $3; }
  | f        { $$ = $1; }
  ;

f : LETTER   { 
    if (!init[(int)$1]) {
        printf("Error: '%c' is not initialized\n", (char)((int)$1 + 'a'));
        exit(1); 
    }
    $$ = sym[(int)$1]; 
}
  | ICONST   { $$ = $1; }
  ;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "warning: %s\n", s);
    return 0;
}
