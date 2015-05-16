#include <iostream>
//#include <sstream>
#include <string>

using namespace std;

string xassign(string op1,int offset){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rax"<<endl;	
		asmCode <<"\tmovl %eax,-"<<offset<<"(%rsp)"<<endl;
	}else
		asmCode <<"\tmovl -"<<op1<<"(%rsp),-"<<offset<<"(%rsp)"<<endl;
	return asmCode.str();
}

string xconstant(int val){
	stringstream asmCode;
	asmCode << "\tmovl $"<<val<<", %eax"<<endl;
	asmCode << "\tpush %rax"<<endl;
	return asmCode.str();
}

string xadd(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rbx"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"\taddl %ebx, %eax"<<endl;
	asmCode <<"\tpush %rax"<<endl;
	return asmCode.str();
}

string xsub(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rbx"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"\tsubl %ebx, %eax"<<endl;
	asmCode <<"\tpush %rax"<<endl;
	return asmCode.str();
}

string xmul(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rbx"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"\tmull %ebx, %eax"<<endl;
	asmCode <<"\tpush %rax"<<endl;
	return asmCode.str();
}
string xdiv(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rbx"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"\tdivl %ebx, %eax"<<endl;
	asmCode <<"\tpush %rax"<<endl;
	return asmCode.str();
}

string xmod(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rbx"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op1<<"(%rsp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op2<<"(%rsp), %eax"<<endl;
	}

	asmCode <<"\tdivl %ebx, %eax"<<endl;
	// rdx is reminder of div
	asmCode <<"\tpush %rdx"<<endl;
	return asmCode.str();
}
string xcondition(string op1,string op2,int lCount){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rbx"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op1<<"(%rsp),%ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op2<<"(%rsp),%eax"<<endl;
	}
	asmCode <<"\tcmp %eax,%ebx"<<endl;
	asmCode <<"\tjnz L"<<lCount<<":"<<endl;
	return asmCode.str();	
}

string xif(int *lCount){
	//gen label
	stringstream asmCode;
	asmCode <<"L"<<*lCount<<":"<<endl;
	*lCount=*lCount+1;
	return asmCode.str();
}
string xloopStart(string op,int lCount){

	stringstream asmCode;
	if(op==""){
		asmCode <<"\tpop %ecx"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op<<"(%rsp), %ecx"<<endl;
	}
	asmCode <<"\txor %rax,%rax"<<endl;
	asmCode <<"\tcmp %rax,%ecx"<<endl;
	asmCode <<"\tje EL"<<lCount<<endl;
	asmCode <<"L"<<lCount<<":"<<endl;
	return asmCode.str();
}

string xloop(int *lCount){
	stringstream asmCode;

	asmCode <<"\tdec %ecx"<<endl;
	asmCode <<"\tjnz L"<<*lCount<<endl;
	asmCode <<"EL"<<*lCount<<":"<<endl;
	
	*lCount=*lCount+1;
	return asmCode.str();
}

string xprint(string op){
	stringstream asmCode;

	asmCode <<"\tmov $show, %edi"<<endl;
	if(op==""){
		asmCode <<"\tpop %eax"<<endl;
	}else{
		asmCode <<"\tmovl -"<<op<<"(%rsp), %eax"<<endl;
	}
	asmCode <<"\tmovl %eax,%esi"<<endl;

	asmCode <<"\tpush %rax"<<endl;
	asmCode <<"\tpush %rbx"<<endl;
	asmCode <<"\tpush %rcx"<<endl;

	asmCode <<"\tcall printf"<<endl;

	asmCode <<"\tpop %rcx"<<endl;
	asmCode <<"\tpop %rbx"<<endl;
	asmCode <<"pop %rax"<<endl;
	return asmCode.str();
}
