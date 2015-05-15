%{
#include <cstdio>
#include <iostream>
#include <string>
#include <stack>
#include <stdio.h>
#include <stdlib.h>
#include "nodeblock.h"
using namespace std;
//TAC initial implementation.
int count =0;
stack<int> temp;
int swap_temp;
NodeBlock nodeblock; //create nodeblock << need to fixed !!

//Binary Tree initial implmentation
struct node{
   int data;
   struct node *right, *left;
};


typedef struct node node;
node *subtree;

//stack for tree
stack<NodeBlock*> stack_node;

//Insert Tree Function
//void insert(node **tree, int val)
//{
//      node *temp = NULL;
//       temp = (node *)malloc(sizeof(node));
//       temp->left = temp->right = NULL;
//       temp->data = val;
//       *tree = temp;
//}
//
//void insert_opnode(node **tree, int op, node *val)
//{
//  // if(!(*tree))
//  // {
//      printf("opp = %d\n", op);
//      insert(tree,op);
//      printf("TREE->data : %d\n", (*tree)->data);
//  // }
//    if(!((*tree)->left))
//    {
//       (*tree)->left = val;
//    }
//    else
//    {
//       (*tree)->right =val;
//    }
//}

void print_inorder(node *tree)
{
    if (tree)
    {
      //print_inorder(tree->left);
      printf("%d\n",tree->data);
      //print_inorder(tree->right);
    }
}

void deltree(node * tree)
{
    if (tree)
    {
      deltree(tree->left);
      deltree(tree->right);
      free(tree);
    }
}


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
   
   CONST {
   //TAC Syntax
   /*cout << "T" << count << " = " << $1 <<endl; 
   temp.push(count); 
   $$ = count; count++;
	*/
   //TREE Syntax --Keep in stack
   Constant *node_const = new Constant(); //create constant object 
   node_const->setValue($1);  //add value to constant node
   //test aassign
   cout << "const assign : " << node_const->getValue() << endl;

   //insert(&constant_node, $1);
   stack_node.push(node_const);
   } 
  | VAR {
  	// add var to tree it's looklike constant but keep on address form fp(frame pointer)
 	Variable *node_var = new Variable($1);
 	cout << " var = " << $1 << endl;
 	stack_node.push(node_var);
	cout << "var assign @ = " << node_var->getValue() << endl;

  }
  | Exp PLUS Exp {
      //TAC Syntax
      /*swap_temp = temp.top();
      temp.pop(); 
      cout<<"T"<< count << " = " << "T" << temp.top();
      temp.pop();   
      cout << " + T" << swap_temp << endl; 
      temp.push(count);count++;
	  */

	  cout << " PLUS " << endl;

      //TREE Syntax
      NodeBlock *node_left;
      NodeBlock *node_right; 
      node_right = stack_node.top();
      cout << node_right->getValue() << endl;
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      AddSyntax* addsyn = new AddSyntax(node_left,node_right);
      stack_node.push(addsyn);

      // FOR TESTING VALUE 
      
      NodeBlock* node_test = stack_node.top();
      cout << "test print from stack" << endl;  
      node_test->print();
	  

    }
  | Exp MINUS Exp {

      //TAC Syntax
      swap_temp = temp.top();
      temp.pop(); 
      cout<<"T"<< count << " = " << "T" << temp.top();
      temp.pop();   
      cout << " - T" << swap_temp << endl; 
      temp.push(count);count++;

      //TREE Syntax
      NodeBlock *node_left;
      NodeBlock *node_right; 
      node_right = stack_node.top();
      cout << node_right->getValue() << endl;
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      MinusSyntax* addsyn = new MinusSyntax(node_left,node_right);
      stack_node.push(addsyn);

      // FOR TESTING VALUE 
      /*
      NodeBlock* node_test = stack_node.top();
      cout << "test print from stack" << endl;  
      node_test->print();
	  */
      
    }
  | Exp TIMES Exp {
      swap_temp = temp.top();
      temp.pop();
      cout << "T" << count << " = " << "T" << temp.top();
      temp.pop();
      cout << " * T" << swap_temp << endl;
      temp.push(count);count++;
    }         
  | Exp DIVIDE Exp {
      swap_temp = temp.top();
      temp.pop();
      cout << "T" << count << " = " << "T" << temp.top();
      temp.pop();
      cout << " / T" << swap_temp << endl;
      temp.push(count);count++;
    } 
  | Exp MOD Exp {
      swap_temp = temp.top();
      temp.pop(); 
      cout << "T" << count << " = " << "T" << temp.top();
      temp.pop();
      cout << " % T" << swap_temp << endl;
      temp.push(count);count++;
    }
  | LEFT Exp RIGHT { }
  | MINUS Exp %prec NEG {
      cout << "T" << temp.top() << " =  -" << "T" << temp.top() << endl;
    }
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
