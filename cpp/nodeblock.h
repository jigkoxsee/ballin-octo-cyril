#include<string> 
#include<iostream>
using namespace std;


template <typename T>
class NodeBlock
{
   public:
      NodeBlock *left;
      NodeBlock *right;
      //int value;
      NodeBlock() {}
      ~NodeBlock() {}
      //virtual ~NodeBlock() {}
      virtual void setValue() {};
      virtual void getValue() {};
};

template <typename T> 
class Variable : public NodeBlock<T>
{
   private:
      string var_name;
      NodeBlock<T> nodeblock;
};
template <typename T> 
class Assignment
{
   string var_name;
};
template <typename T> 
class IfStatement
{
   NodeBlock<T> *condition;
   NodeBlock<T> *then;
};

template <typename T> 
class AddSyntax : public NodeBlock<T>
{
   public:
      AddSyntax(){}
      ~AddSyntax(){}
      void createnode(){
      }
};

template <typename T> 
class MinusSyntax : public NodeBlock<T>
{
   public:
      MinusSyntax(){}
      ~MinusSyntax(){}
      void createnode(){
      }
};
