#include<string> 
#include<iostream>
using namespace std;


class NodeBlock
{
   protected   : 
      char type; //tell about type of nodeBlock
   public:
      NodeBlock *left; 
      NodeBlock *right;
      //int value;
      NodeBlock() {}
      ~NodeBlock() {}
      virtual void setValue() {};
      virtual int  getValue() {};
      virtual void print() { cout << "NodeBlock" << endl; };
      void cgen(); // generate code assembly
};


class Variable : public NodeBlock 
{
   //In X86 have frame pointer name ebp
   private:
      char var_name;
      int address;
   public:
      Variable(int var_name) {
         address = var_name * 4; //each frame has 4 bytes
      }
      ~Variable() {}
      int getValue() {
         return address;
      }

};

class Constant : public NodeBlock  
{
   private: 
      int value;
   public:
      Constant() {};
      virtual void setValue(int value){
         this->value = value;
      }

      virtual int getValue(){
         return value;
      }
};

class IfStatement
{
   NodeBlock  *condition;
   NodeBlock  *then;
};

class AddSyntax : public NodeBlock 
{
   public:
      AddSyntax(NodeBlock *left,NodeBlock *right){
         this->left = left;
         this->right = right;
         this->type = 'a'; 
      }
      ~AddSyntax(){}
     virtual void print(){
      cout << " left = " << this->left->getValue();
      cout << " right = " << this->right->getValue() << endl;
     }
};

class MinusSyntax : public NodeBlock 
{
   public:
      MinusSyntax(NodeBlock *left,NodeBlock *right){
         this->left = left;
         this->right = right;
         this->type = 'm';
      }
      ~MinusSyntax(){}
     virtual void print(){
      cout << " left = " << this->left->getValue();
      cout << " right = " << this->right->getValue() << endl;
     }
};