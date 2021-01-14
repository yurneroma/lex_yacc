%{
    #include <stdio.h>
    #include <string.h>


    //extern YYSTYPE yylval;
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



%token TOKHEATER TOKHEAT TOKTARGET   TOKTEMPERATURE
%union
{
int number;
char *string;
}
%token <number> STATE
%token <number> NUMBER
%token <string> WORD



%%
commands:  /* empty */
| commands command
;

command: heater_select | heat_switch | target_set;


heater_select:
TOKHEATER WORD
{
    printf("\t Seclected heater '%s'\n",$2);
}
;


heat_switch:
TOKHEAT STATE 
{
    if ($2)
        printf("\t Heat turned on\n");
    else
        printf("\t Heat turned off\n");
}
;



target_set:
TOKTARGET TOKTEMPERATURE NUMBER
{
    printf("\tHeater  temperature set to %d\n", 
             $3);
};

%%