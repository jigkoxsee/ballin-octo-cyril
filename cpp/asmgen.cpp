#include <iostream>
//#include <sstream>
#include <string>

using namespace std;

string xassign(string op1,int offset){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"pop %rax"<<endl;	
		asmCode <<"movl %eax,-"<<offset<<"(%rsp)"<<endl;
	}else
		asmCode <<"movl -"<<op1<<"(%rsp),-"<<offset<<"(%rsp)"<<endl;
	return asmCode.str();
}

string xconstant(int val){
	stringstream asmCode;
	asmCode << "movl $"<<val<<", %eax"<<endl;
	asmCode << "push %rax"<<endl;
	return asmCode.str();
}

string xadd(string op1,string op2){
	stringstream asmCode;
	asmCode <<"pop %rbx"<<endl;
	asmCode <<"pop %rax"<<endl;

	asmCode <<"addl %ebx, %eax"<<endl;
	asmCode <<"push %rax"<<endl;
	return asmCode.str();
}
