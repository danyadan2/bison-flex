yylex() {
  int c, d;
  while((c=getchar())==' '); /* Skip spaces */
  if( c>='0' && c<='9' ) {   /* Integer constant */
    for( d=c-'0'; (c=getchar()) >='0' && c<='9'; ) d=d*10+c-'0';
    ungetc( c, stdin );
    yylval = d;
    return ICONST;
  }
  return c;                  /* Others */
}
