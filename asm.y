%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE int

extern char* yytext;
int flag = 0;

%}


%token CONST
%token PLUS MINUS TIMES DIVIDE MOD
%token LEFT RIGHT
%token ENDLN
%token ASSIGN EQ IF ENDIF LOOP END SHOW SHOWX SEMICOLON
%token VAR

%left AND OR NOT
%left PLUS MINUS
%left TIMES DIVIDE
%left NEG


%start Input


%%

Input:
     | Input Line
;

Line:
  ENDLN
  | Ifstm
  | Loopstm
  | Stms
  | Display
  | error { yyerror(); flag = 0; }
;


Oprn:
  VAR
  | CONST
;

Condition:
  Oprn EQ Oprn
;

Ifstm:
  IF Condition ENDLN Stms END ENDLN { printf("IF\n");}
;

Stm:
  VAR EQ Exp ENDLN { printf("STM\n"); }
  | Exp ENDLN { printf("STM\n"); }
;

Stms:
  Stm { printf("STMS STM\n"); }
  | Stm Stms { printf("STMS STM STMS\n"); }
;

Exp:
  CONST
  | VAR
  | Exp PLUS Exp
  | Exp MINUS Exp
  | Exp TIMES Exp
  | Exp DIVIDE Exp
  | Exp MOD Exp
  | LEFT Exp RIGHT
;

Loopstm:
  LOOP CONST SEMICOLON CONST ENDLN END ENDLN { printf("LOOP\n");}
;

Display:
  SHOW VAR { printf("SHOW\n");}
  | SHOWX VAR { printf("SHOWX\n");}
;
%%

int yyerror() {
  if (flag == 0){
   printf("ERROR! \n");
   flag = 1;
  }
}

int main() {
  yyparse();
}
