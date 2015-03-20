%{
#define YYSTYPE long long int
#include "asm.tab.h"
#include <stdlib.h>
#include <string.h>
%}

white [ \t]+
digit [0-9]
integer {digit}+

%%

{white} { }

[0-9a-fA-F]+h {

  int dec=0,i=0,val=0;
  for(i=0;i<strlen(yytext)-1;i++){
    if(yytext[i]<='9')
      val=yytext[i]-'0';
    else if(yytext[i]<='Z')
      val=yytext[i]-'A'+10;
    else
      val=yytext[i]-'a'+10;
    dec=dec*16+val;
  }
  yylval=dec;
  return CONST;
}

{integer} {
  sscanf(yytext,"%d",&yylval);
  return CONST;
}

$[a-zA-Z] {
  yylval=yytext[2]-'0';
  return VAR;
}


"+" return PLUS;
"-" return MINUS;
"*" return TIMES;
"/" return DIVIDE;
"%" return MOD;

"(" return LEFT;
")" return RIGHT;

"if" return IF;
"=" return ASSIGN;
"==" return EQ;
"endif" return ENDIF;
"loop" return LOOP;
"end" return END;

"show" return SHOW;
"showx" return SHOWX;
":" return SEMICOLON;


"\n" return ENDLN;
