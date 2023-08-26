# Compilador3

O objetivo do trabalho é projetar e implementar um analisador sintático de Python para traduzir para C. 
O analisador sintático dá suporte a: dados inteiros e reais, comando de definição de variáveis, expressões com operadores aritméticos, if/else, while, chamadas de funções.

O trabalho foi dividido em duas etapas:
Projeto do analisador sintático: Esta etapa envolveu a definição da gramática da linguagem de programação e do algoritmo de análise sintática.
Implementação do analisador sintático: Esta etapa envolveu a codificação do analisador sintático em linguagem C.

Estes são os comandos para compilar o código:
lex pparac.l            
bison -d pparac.y     
gcc -o parser pparac.tab.c lex.yy.c -lfl
./parser pparac.printc

Por ser um analisador simples, ele possui algumas limitações como: Não possui suporte a alguns simbolos como ">", "<", "%", etc. Não tem suporte para linhas em branco. E não da suporte para estruturas mais complexas como arrays, dicionarios, classes, etc.
Um exemplo de código aceito está no arquivo "pparac.printc".
