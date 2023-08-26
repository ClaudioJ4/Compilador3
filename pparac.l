%{
#include <string.h>
#include "pparac.tab.h"

int yyerror(char* erro){
    printf("Erro na linha %d: %s\nEm %s\n", yylineno, erro, yytext);
    return 0;
}
%}

%option noyywrap
DIGITO              [0-9]
INTEIRO             {DIGITO}+
REAL                {DIGITO}+"."{DIGITO}+
VARIAVEL            [a-zA-Z_][a-zA-Z0-9_]*
CHAMA_FUNCAO        {VARIAVEL}"\("([[:space:]]*({INTEIRO}|{REAL}|{VARIAVEL})[[:space:]]*(,)[[:space:]]*({INTEIRO}|{REAL}|{VARIAVEL}))*[[:space:]]*"\)"
BRANCO              [ \t]
ESPACO              {BRANCO}+


%%

"if" { yylval.str = strdup(yytext); return IF; }
"else" { yylval.str = strdup(yytext); return ELSE; }
"while" { yylval.str = strdup(yytext); return WHILE; }
"==" { yylval.str = strdup(yytext); return IGUAIS; }
"!=" { yylval.str = strdup(yytext); return NIGUAL; }
"*" { yylval.str = strdup(yytext); return MULTIPLICA; }
"+" { yylval.str = strdup(yytext); return ADICIONA; }
"-" { yylval.str = strdup(yytext); return SUBTRAI; }
"=" { yylval.str = strdup(yytext); return IGUALA; }
"(" { yylval.str = strdup(yytext); return ABREPAR; }
")" { yylval.str = strdup(yytext); return FECHAPAR; }
":" { yylval.str = strdup(yytext); return DOISPONTO; }
{VARIAVEL} { yylval.str = strdup(yytext); return VAR; }
{INTEIRO} { yylval.str = strdup(yytext); return INT; }
{REAL} { yylval.str = strdup(yytext); return REAL; }
{CHAMA_FUNCAO} { yylval.str = strdup(yytext); return FUNC; }
<<EOF>> { return FIM_ENTRADA; }
{ESPACO}	{ /* Ignorar espaços em branco */ }
.       	{ yyerror("Token desconhecido."); }
"\n"        { yylineno++; return FIM_DE_LINHA; }

%%
