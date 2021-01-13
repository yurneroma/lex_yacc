%{
    #include <stdio.h>
    #include <string.h>

extern int yylex(void);
extern int yyparse(void);

int yywrap(){
    return 1;
}

void yyerror(const char *s){
    printf("[Error] %s\n", s);
}

int main(){
    yyparse();
    return 0;
}

%}

%token NUMBER TOKHEAT STATE TOKTARGET TOKTEMPERATURE


%%
commands:  /* empty */
| commands command
;

command: heat_switch | target_set; 
heat_switch:
TOKHEAT STATE 
{
    if ($2)
        printf("\t Heat turned on\n");
    else
        printf("\t Heat turned off\n");
}

target_set:
TOKTARGET TOKTEMPERATURE NUMBER
{
    printf("\t Temperature set to %d\n", $3);
}

%%
