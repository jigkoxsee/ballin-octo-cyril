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

string xadd(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"pop %rbx"<<endl;
	}else{
		asmCode <<"movl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"pop %rax"<<endl;
	}else{
		asmCode <<"movl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"addl %ebx, %eax"<<endl;
	asmCode <<"push %rax"<<endl;
	return asmCode.str();
}

string xsub(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"pop %rbx"<<endl;
	}else{
		asmCode <<"movl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"pop %rax"<<endl;
	}else{
		asmCode <<"movl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"subl %ebx, %eax"<<endl;
	asmCode <<"push %rax"<<endl;
	return asmCode.str();
}

string xmul(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"pop %rbx"<<endl;
	}else{
		asmCode <<"movl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"pop %rax"<<endl;
	}else{
		asmCode <<"movl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"mull %ebx, %eax"<<endl;
	asmCode <<"push %rax"<<endl;
	return asmCode.str();
}
string xdiv(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"pop %rbx"<<endl;
	}else{
		asmCode <<"movl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"pop %rax"<<endl;
	}else{
		asmCode <<"movl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"divl %ebx, %eax"<<endl;
	asmCode <<"push %rax"<<endl;
	return asmCode.str();
}

string xmod(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"pop %rbx"<<endl;
	}else{
		asmCode <<"movl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"pop %rax"<<endl;
	}else{
		asmCode <<"movl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"divl %ebx, %eax"<<endl;
	// rdx is reminder of div
	asmCode <<"push %rdx"<<endl;
	return asmCode.str();
}

string xneg(string val){
	
	return "NEG\n";
}
