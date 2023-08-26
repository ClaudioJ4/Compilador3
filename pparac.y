%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE* yyin;
extern int yylineno;
extern char* yytext;

int current_indent = 0;
int yylex(void);
void yyerror(char* s);

%}

%union {
    char *str;
}

%token<str> IF ELSE WHILE IGUAIS NIGUAL MULTIPLICA ADICIONA SUBTRAI IGUALA ABREPAR FECHAPAR DOISPONTO INT REAL VAR FUNC FIM_ENTRADA FIM_DE_LINHA
%type<str> expression programa function_call_statement statement assignment_statement expression_statement if_statement while_statement

%%

programa: 
        | programa statement FIM_DE_LINHA
        | programa statement FIM_ENTRADA
        ;

statement: if_statement
         | while_statement
         | assignment_statement
         | expression_statement
         | function_call_statement
         ;


if_statement: IF expression DOISPONTO programa
{
    printf("%*sif (%s) {\n", current_indent * 4, "", $2);
    current_indent++;
    printf("%s", $4);
    current_indent--;
    printf("%*s}\n", current_indent * 4, "");
}
| IF expression DOISPONTO programa ELSE DOISPONTO programa
{
    printf("%*sif (%s) {\n", current_indent * 4, "", $2);
    current_indent++;
    printf("%s", $4);
    current_indent--;
    printf("%*s} else {\n", current_indent * 4, "");
    current_indent++;
    printf("%s", $6);
    current_indent--;
    printf("%*s}\n", current_indent * 4, "");
}
| IF expression DOISPONTO programa ELSE DOISPONTO FIM_DE_LINHA
{
    printf("%*sif (%s) {\n", current_indent * 4, "", $2);
    current_indent++;
    printf("%s", $4);
    current_indent--;
    printf("%*s} else {\n", current_indent * 4, "");
    current_indent++;
    printf("/* empty else block */\n");
    current_indent--;
    printf("%*s}\n", current_indent * 4, "");
}
;

while_statement: WHILE expression DOISPONTO programa
            {
                printf("%*swhile (%s) {\n", current_indent * 4, "", $2);
                current_indent++;
                printf("%s", $4);
                current_indent--;
                printf("%*s}\n", current_indent * 4, "");
            }
            ;

assignment_statement: VAR IGUALA expression
            {
                printf("%*s%s = %s;\n", current_indent * 4, "", $1, $3);
            }
            ;

expression_statement: expression
            {
                printf("%*s%s;\n", current_indent * 4, "", $1);
            }
            ;

function_call_statement: FUNC
            {
                printf("%*s%s;\n", current_indent * 4, "", $1);
            }
            ;

expression: expression MULTIPLICA expression
            {
                $$ = malloc(strlen($1) + strlen($3) + 4);
                sprintf($$, "%s * %s", $1, $3);
            }
            | expression ADICIONA expression
            {
                $$ = malloc(strlen($1) + strlen($3) + 4);
                sprintf($$, "%s + %s", $1, $3);
            }
            | expression SUBTRAI expression
            {
                $$ = malloc(strlen($1) + strlen($3) + 4);
                sprintf($$, "%s - %s", $1, $3);
            }
            | expression IGUAIS expression
            {
                $$ = malloc(strlen($1) + strlen($3) + 4);
                sprintf($$, "%s == %s", $1, $3);
            }
            | expression NIGUAL expression
            {
                $$ = malloc(strlen($1) + strlen($3) + 4);
                sprintf($$, "%s != %s", $1, $3);
            }
            | ABREPAR expression FECHAPAR
            {
                $$ = malloc(strlen($2) + 3);
                sprintf($$, "(%s)", $2);
            }
            | VAR
            {
                $$ = strdup($1);
            }
            | INT
            {
                $$ = strdup($1);
            }
            | REAL
            {
                $$ = strdup($1);
            }
            | FUNC
            {
                $$ = strdup($1);
            }
            ;


%%

int main(int argc, char **argv){
    	if(argc!=2)	printf("Modo de uso: ./a.out arquivo.printc\n");
    	else{
            	yyin = fopen(argv[1], "r");
            	if(!yyin){
                    	printf("Arquivo %s não encontrado!\n", argv[1]);
                    	return -1;
            	}
            	if( yyparse() == 0 ) printf("PROGRAMA RECONHECIDO!!!\n");
            	fclose(yyin);
    	}
    	return 0;
}
