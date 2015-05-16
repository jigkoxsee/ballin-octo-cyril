%{
#include <cstdio>
#include <iostream>
#include <string>
//#include <sstream>
#include <stack>
#include <cstdlib>
#include "nodeblock.cpp"
#include "asmgen.cpp"
using namespace std;

void stack_print();
//TAC initial implementation.
int lCount =0;
stack<int> temp;
int swap_temp;
NodeBlock nodeblock; //create nodeblock << need to fixed !!

//Binary Tree initial implmentation
struct node{
   int data;
   struct node *right, *left;
};

queue<string> asmQ;
typedef struct node node;
node *subtree;

//stack for tree
stack<NodeBlock*> stack_node;

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

string asmShow(){
	return "mov $show,%edi \nmov %eax,%esi \npush %rax\ncall printf\npop %rax\nret\n";
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
  {
  	Variable *node_var = new Variable($1);
 	//cout << " var = " << $1 << endl;
 	stack_node.push(node_var);
	//cout << "var assign @ = " << node_var->getValue() << endl;
  	//stack_print();
  }

  | CONST
  {
  	Constant *node_const = new Constant(); //create constant object 
   node_const->setValue($1);  //add value to constant node
   //test aassign
   //cout << "const assign : " << node_const->getValue() << endl;
   stack_node.push(node_const);
   //stack_print();
	cout<<xconstant(node_const->getValue())<<endl;
  }
;

Condition:
    Oprn EQ Oprn 
  { 
  	NodeBlock *node1 = stack_node.top();
  	stack_node.pop();
  	NodeBlock *node2 = stack_node.top();
  	stack_node.pop();

  	Equal *node_equal = new Equal(node2,node1); //condition object 
  	stack_node.push(node_equal);
  	//node_equal->print();
  	//stack_print();
	cout<<xcondition(node1->getAsm(),node2->getAsm(),lCount) <<endl;
  }
;


Ifstm:
  IF Condition ENDLN Stms ENDIF ENDLN  // change Stms to Stm for first version support only one statement
  {
  	//NodeBlock *node_stm = stack_node.top();
  	//stack_node.pop();
	//NodeBlock *node_equal = stack_node.top();  //statements do after pass condition
	//stack_node.pop(); // TODO memory leak?

  	//IfStatement *node_if = new IfStatement(node_equal);
	//stack_node.push(node_if);
	cout<<xif(&lCount)<<endl;
  }

;

Stm:
  VAR ASSIGN Exp ENDLN{
	NodeBlock *node_exp = stack_node.top();
  	Variable *node_var = new Variable($1);
 	//cout << " var = " << $1 << endl;
 	stack_node.push(node_exp);
	//cout << "var assign @ = " << node_var->getValue() << endl;

	cout<<xassign(node_exp->getAsm(),node_var->getValue())<<endl;
  	
  	//stack_print();
  }
;

Stms:
  Stm {  }
  | Stm  Stms { }

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
   //cout << "const assign : " << node_const->getValue() << endl;

   //insert(&constant_node, $1);
   stack_node.push(node_const);
	cout<<xconstant(node_const->getValue())<<endl;
   //stack_print();
   } 
  | VAR {
  	// add var to tree it's looklike constant but keep on address form fp(frame pointer)
 	Variable *node_var = new Variable($1);
 	//cout << " var = " << $1 << endl;
 	stack_node.push(node_var);
	//cout << "var assign @ = " << node_var->getValue() << endl;
	//stack_print();

  }
  | Exp PLUS Exp {
      //TAC Syntax
      /*swap_temp = temp.top();
      temp.pop(); 
      cout<<"T"<< count << " = " << "T" << temp.top();
      temp.pop();   
      cout << " + T" << swap_temp << endl; 
	  */

      //TREE Syntax
      NodeBlock *node_left;
      NodeBlock *node_right; 
      node_right = stack_node.top();
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      AddSyntax *addsyn = new AddSyntax(node_left,node_right);
      stack_node.push(addsyn);

      // FOR TESTING VALUE 
      
 	cout<<xadd(node_right->getAsm(),node_left->getAsm(),"")<<endl; 
	  

    }
  | Exp MINUS Exp {

      //TAC Syntax
      /*swap_temp = temp.top();
      temp.pop(); 
      cout<<"T"<< count << " = " << "T" << temp.top();
      temp.pop();   
      cout << " - T" << swap_temp << endl; 
      temp.push(count);count++;
		*/

      //TREE Syntax
      NodeBlock *node_left;
      NodeBlock *node_right; 
      node_right = stack_node.top();
	  stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      MinusSyntax* minsyn = new MinusSyntax(node_left,node_right);
      stack_node.push(minsyn);
      //minsyn->print();
      // FOR TESTING VALUE 
      /*
      NodeBlock* node_test = stack_node.top();
      cout << "test print from stack" << endl;  
      node_test->print();
	  */
 	cout<<xsub(node_right->getAsm(),node_left->getAsm(),"")<<endl;      
    }
  | Exp TIMES Exp {
      //TAC Syntax
     /* swap_temp = temp.top();
      temp.pop();
      cout << "T" << count << " = " << "T" << temp.top();
      temp.pop();
      cout << " * T" << swap_temp << endl;
      temp.push(count);count++;
	 */
      //TREE Syntax
      NodeBlock *node_left;
      NodeBlock *node_right;
      node_right = stack_node.top();
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      TimesSyntax* timessyn = new TimesSyntax(node_left,node_right);
      stack_node.push(timessyn);

      //NodeBlock* node_test = stack_node.top();
      //node_test->print();
 	cout<<xmul(node_right->getAsm(),node_left->getAsm(),"")<<endl; 
    }         
  | Exp DIVIDE Exp {
      //TAC Syntax
      /*swap_temp = temp.top();
      temp.pop();
      cout << "T" << count << " = " << "T" << temp.top();
      temp.pop();
      cout << " / T" << swap_temp << endl;
      temp.push(count);count++;
	 */
      //TREE Syntax
      NodeBlock *node_left;
      NodeBlock *node_right;
      node_right = stack_node.top();
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      DivideSyntax* dividesyn = new DivideSyntax(node_left,node_right);
      stack_node.push(dividesyn);

      //NodeBlock* node_test = stack_node.top();
      //node_test->print();

 	cout<<xdiv(node_right->getAsm(),node_left->getAsm(),"")<<endl;
} 
  | Exp MOD Exp {
      //TAC Syntax
  	  /*
      swap_temp = temp.top();
      temp.pop(); 
      cout << "T" << count << " = " << "T" << temp.top();
      temp.pop();
      cout << " % T" << swap_temp << endl;
      temp.push(count);count++;
	  */

      //TREE Syntax
      NodeBlock *node_left;
      NodeBlock *node_right;
      node_right = stack_node.top();
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      ModSyntax* modsyn = new ModSyntax(node_left,node_right);
      stack_node.push(modsyn);

      //NodeBlock* node_test = stack_node.top();
      //node_test->print();
 	cout<<xmod(node_right->getAsm(),node_left->getAsm(),"")<<endl;

    }
  | LEFT Exp RIGHT { }
  | MINUS Exp %prec NEG {
      //TAC Syntax
      //cout << "T" << temp.top() << " =  -" << "T" << temp.top() << endl;

      //TREE Syntax
      NodeBlock *node;
      node = stack_node.top();
      //cout << "OLD: " << node->getValue() << endl;
      stack_node.pop();
      int temp_neg = 0-(node->getValue());
      node->setValue(temp_neg);
      //cout << "NEW: " << node->getValue() << endl;
      stack_node.push(node);
    }
;
LNO:
  VAR 
  {
  	Variable *node_var = new Variable($1);
 	stack_node.push(node_var);
	cout<<xloopStart(node_var->getAsm(),lCount)<<endl;
  }

  | CONST
  {
  	Constant *node_const = new Constant();
	node_const->setValue($1);  //add value to constant node
	stack_node.push(node_const);
	cout<<xloopStart(node_const->getAsm(),lCount)<<endl;
  }
;
Loopstm:
  LOOP LNO ENDLN Stms END ENDLN {

    //stack_node.top()->print();
    //NodeBlock *node_stm = stack_node.top();
    //stack_node.pop();
    //stack_node.top()->print();
    //NodeBlock *node_const = stack_node.top();
    //stack_node.pop();
    Variable *node_var = new Variable(-1);
    //node_var->print();

    LoopStatement *node_loop = new LoopStatement(node_var);

    //node_loop->print();
    //stack_print();
    //stack_node.push(node_loop);
    //stack_print();
	cout<<xloop(&lCount)<<endl;
  }
;

Display:
  SHOW VAR {  
    printf("SHOW\n");
    //  Variable *node_var = new Variable($2);
    Show *node_show = new Show ($2*4);
    node_show->print();
  }
  | SHOWX VAR {
    printf("SHOWX\n");
    ShowX *node_show = new ShowX ($2*4);
    node_show->print();
  }
;
%%

void yyerror(const char *s) {
  cout << "EEK, parse error!  Message: " << s << endl;
  // might as well halt now:
  exit(-1);
}


void stack_print()
{
	stack<NodeBlock*> stack_tmp;

	cout << "====== STACK PRINT =======" << endl;

	while(!stack_node.empty())
	{
		stack_node.top()->print();
		NodeBlock* tmp = stack_node.top();
		stack_tmp.push(tmp);
		stack_node.pop();
	}

	while(!stack_tmp.empty()){
		NodeBlock *tmp2 = stack_tmp.top();
		stack_node.push(tmp2);
		stack_tmp.pop();
	}

	cout << "==========================" << endl;

}


int main() {
  while(yyparse());
// TODO (ziko) : Travers through queue and write it to file

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
