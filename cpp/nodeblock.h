#include<string> 
#include<iostream>
using namespace std;


class NodeBlock
{
   private:
      char type;
   public:
      NodeBlock *left;
      NodeBlock *right;
      //int value;
      NodeBlock() {}
      ~NodeBlock() {}
      //virtual ~NodeBlock() {}
      virtual void setValue() {};
      virtual int  getValue() {};
      virtual void print() { cout << "NodeBlock" << endl; };
};

class Variable : public NodeBlock 
{
   private:
      string var_name;
      NodeBlock  nodeblock;
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
      }
      ~AddSyntax(){}
     virtual void print(){
      cout << " left = " << this->left->getValue() << endl;
      cout << " right = " << this->right->getValue() << endl;
     }
};

class MinusSyntax : public NodeBlock 
{
   public:
      MinusSyntax(){}
      ~MinusSyntax(){}
      void createnode(){
         
      }
};

class TimesSyntax : public NodeBlock
{
   public:
      TimesSyntax(NodeBlock *left,NodeBlock *right){
         this->left = left;
         this->right = right;
      }
      ~TimesSyntax(){}
      virtual void print(){
	cout << " left = " << this->left->getValue() << endl;
	cout << " right = " << this->right->getValue() << endl;
      }
};

class DivideSyntax : public NodeBlock
{
    public:
       DivideSyntax(NodeBlock *left,NodeBlock *right){
         this->left = left;
         this->right = right;
       }
       ~DivideSyntax(){}
       virtual void print(){
         cout << " left = " << this->left->getValue() << endl;
         cout << " right = " << this->right->getValue() << endl;
       }
};

class ModSyntax : public NodeBlock
{
     public:
        ModSyntax(NodeBlock *left,NodeBlock *right){
           this->left = left;
           this->right = right;
        }
        ~ModSyntax(){}
        virtual void print(){
           cout << " left = " << this->left->getValue() << endl;
           cout << " right = " << this->right->getValue() << endl;
        }
};
