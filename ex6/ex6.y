%{
    #include <stdio.h>
    #include <string.h>


    #define YYSTYPE char * 
    extern YYSTYPE yylval;
    // int yydebug = 1;  //debug
    extern int yylex(void);
    extern int yyparse(void);

    int yywrap() {
        return 1;
    }

    void yyerror(const char *s ) {
        printf("[Error] %s\n", s); 
    }

    int main(){
        yyparse();
        return 0;
    }
%}


%token SEMI ZONETOK OBRACE EBRACE QUOTE FILENAME WORD FILETOK

/*
    zone "./www" {
	type hint;
	name foo;
	hello "/hello/world";
	file "/etc/bind/db.root";
};
*/

%%
commands:   /*empty*/ 
| commands command SEMI
;

command:
zone_set
;

zone_set:
ZONETOK quotedname zonecontent
{
    printf("Complete zone for '%s' found \n",$2);
};

zonecontent:
OBRACE zonestatements EBRACE
;

zonestatements: /*empty*/
| zonestatements zonestatement SEMI
;

zonestatement:/*empty*/
statements | FILETOK quotedname
{
    printf("A zonefile name '%s' was encountered\n",$2);
}


statements:
| WORD statement
{
	$$ = $2; // seems unnecessary
	printf("statements, key: %s, value: %s\n", $1, $2);
};

statement:
WORD | quotedname
;

quotedname:
QUOTE FILENAME QUOTE
{
	$$ = $2;
};


%%