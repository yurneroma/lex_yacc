%{
    #include<stdio.h>
    #define YYSTYPE char *
    extern YYSTYPE yylval;
    #include"y.tab.h"
%}



%% 
zone return ZONETOK;
file return FILETOK;
[a-zA-Z][a-zA-Z0-9]* yylval = strdup(yytext); return WORD;
[a-zA-Z0-9\/.-]+ yylval = strdup(yytext); return FILENAME;
\" return QUOTE;
\{ return OBRACE;
\} return EBRACE;
; return SEMI;
[ \t]+ /*ignore whitespace*/;
\n /*ignore end of file */;
%%
