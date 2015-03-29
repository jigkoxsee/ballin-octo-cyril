%{
#include <cstdio>
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

%token CONST
%token LEFT RIGHT
%token ENDLN
%token ASSIGN EQ IF ENDIF LOOP END SHOW SHOWX COLON
%token VAR

%left PLUS MINUS TIMES DIVIDE MOD
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
  | Condition
  | error { yyerror("oops\n"); }
;


Oprn:
  VAR
  | CONST
;

Condition:
  Oprn EQ Oprn { printf("CONDITION\n");}
;

Block:
  Stms
  | Ifstm
  | Ifstm Stms
  | Stms Ifstm
  | Stms Ifstm Stms
;

Ifstm:
  IF Condition ENDLN Stms ENDIF ENDLN { printf("IF\n");}
;

Stm:
  VAR ASSIGN Exp { printf("STM\n"); }
;

Stms:
  Stm ENDLN{ printf("STMS STM\n"); }
  | Stm ENDLN Stms { printf("STMS STM STMS\n"); }
;

Exp:
  CONST { printf("EXP c\n"); }
  | VAR { printf("EXP v\n"); }
  | Exp PLUS Exp { printf("EXP+\n"); }
  | Exp MINUS Exp { printf("EXP-\n"); }
  | Exp TIMES Exp { printf("EXP*\n"); }
  | Exp DIVIDE Exp { printf("EXP/\n"); }
  | Exp MOD Exp { printf("EXP%\n"); }
  | MINUS Exp %prec NEG { printf("EXP neg\n"); }
  | LEFT Exp RIGHT { printf("EXP ()\n"); }
;

Loopstm:
  LOOP CONST COLON CONST ENDLN Block END ENDLN { printf("LOOP\n");}
;

Display:
  SHOW VAR { printf("SHOW\n");}
  | SHOWX VAR { printf("SHOWX\n");}
;
%%

void yyerror(const char *s) {
  cout << "EEK, parse error!  Message: " << s << endl;
  // might as well halt now:
  exit(-1);
}

int main() {
  yyparse();
/*
  // open a file handle to a particular file:
  FILE *myfile = fopen("a.snazzle.file", "r");
  // make sure it is valid:
  if (!myfile) {
    cout << "I can't open a.snazzle.file!" << endl;
    return -1;
  }
  // set flex to read from it instead of defaulting to STDIN:
  yyin = myfile;
  
  // parse through the input until there is no more:
  do {
    yyparse();
  } while (!feof(yyin));
*/
}
