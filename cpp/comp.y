%{
#include <cstdio>
#include <iostream>
#include <string>
#include <stack>
using namespace std;
int count =0;
stack<int> temp;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

void convert_to_asm(int opr1,int opr2);
void yyerror(const char *s);
%}

%token CONST
%token LEFT RIGHT
%token ENDLN
%token ASSIGN EQ IF ENDIF LOOP END SHOW SHOWX COLON
%token VAR

%left PLUS MINUS 
%left TIMES DIVIDE MOD
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


Ifstm:
  IF Condition ENDLN Stms ENDIF ENDLN { printf("IF\n");}
;

Stm:
  VAR ASSIGN Exp {count =0;}
;

Stms:
  Stm ENDLN{  }
  | Stm ENDLN Stms { }
;

Exp:
  CONST {cout << "T" << count << "=" << $1 <<endl; temp.push(count); $$ = count; count++;} 
  | VAR 
  | Exp PLUS Exp {cout<<"T"<< count << " = " << "T" << count-1 << " + T" << count-2 << endl;count++;}
  | Exp MINUS Exp { cout<<"SUB "<<$1<<", "<<$3<<endl; }
  | Exp TIMES Exp {cout << "T" << count << " = " << "T" <<count-1<< " * T" << count-2 <<endl;count++;}         
  | Exp DIVIDE Exp { if($3== 0){yyerror("can't div by 0");} cout<<"DIV"<<$1<<", "<<$3<<endl; }
  | Exp MOD Exp { if($3== 0){yyerror("can't div by 0");}cout<<"MOD"<<$1<<", "<<$3<<endl; }
  | MINUS Exp %prec NEG { printf("EXP neg\n"); }
  | LEFT Exp RIGHT { }
;

Loopstm:
  LOOP CONST COLON CONST ENDLN Stms END ENDLN { printf("LOOP\n");}
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

void convert_to_asm(int opr1, int opr2)
{

}

int main() {
  while(yyparse());
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
return 0;
}
