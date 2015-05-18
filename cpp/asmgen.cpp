#include <iostream>
//#include <sstream>
#include <string>

using namespace std;

string xassign(string op1,int offset){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rax"<<endl;	
		asmCode <<"\tmov %eax,-"<<offset<<"(%rbp)"<<endl;
	}else
		asmCode <<"\tmov -"<<op1<<"(%rbp),-"<<offset<<"(%rbp)"<<endl;
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
		asmCode <<"\tmov -"<<op1<<"(%rbp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmov -"<<op2<<"(%rbp), %eax"<<endl;
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
		asmCode <<"\tmov -"<<op1<<"(%rbp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmov -"<<op2<<"(%rbp), %eax"<<endl;
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
		asmCode <<"\tmov -"<<op1<<"(%rbp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmov -"<<op2<<"(%rbp), %eax"<<endl;
	}

	asmCode <<"\tmull %ebx"<<endl;
	asmCode <<"\tpush %rax"<<endl;
	return asmCode.str();
}
string xdiv(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rbx"<<endl;
	}else{
		asmCode <<"\tmov -"<<op1<<"(%rbp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmov -"<<op2<<"(%rbp), %eax"<<endl;
	}

        asmCode <<"\txor %rdx,%rdx"<<endl;
	asmCode <<"\tidivl %ebx"<<endl;
	asmCode <<"\tpush %rax"<<endl;
	return asmCode.str();
}

string xmod(string op1,string op2,string dst){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rbx"<<endl;
	}else{
		asmCode <<"\tmov -"<<op1<<"(%rbp), %ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmov -"<<op2<<"(%rbp), %eax"<<endl;
	}

        asmCode <<"\txor %rdx,%rdx"<<endl;
	asmCode <<"\tidivl %ebx"<<endl;
	// rdx is reminder of div
	asmCode <<"\tpush %rdx"<<endl;
	return asmCode.str();
}
string xcondition(string op1,string op2,int lCount){
	stringstream asmCode;
	if(op1==""){
		asmCode <<"\tpop %rbx"<<endl;
	}else{
		asmCode <<"\tmov -"<<op1<<"(%rbp),%ebx"<<endl;
	}
	if(op2==""){
		asmCode <<"\tpop %rax"<<endl;
	}else{
		asmCode <<"\tmov -"<<op2<<"(%rbp),%eax"<<endl;
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
		asmCode <<"\tmov -"<<op<<"(%rbp), %ecx"<<endl;
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

string xprint(string op,bool hex){
	stringstream asmCode;
	if(hex){
		asmCode <<"\tmov $showx, %edi"<<endl;
	}else{
		asmCode <<"\tmov $show, %edi"<<endl;
	}

	if(op==""){
		asmCode <<"\tpop %eax"<<endl;
	}else{
		asmCode <<"\tmov -"<<op<<"(%rbp), %eax"<<endl;
	}
	asmCode <<"\tmovl %eax,%esi"<<endl;

	asmCode <<"\tpush %rax"<<endl;
	asmCode <<"\tpush %rbx"<<endl;
	asmCode <<"\tpush %rcx"<<endl;

	asmCode <<"\tcall printf"<<endl;

	asmCode <<"\tpop %rcx"<<endl;
	asmCode <<"\tpop %rbx"<<endl;
	asmCode <<"\tpop %rax"<<endl;
	return asmCode.str();
}

string genHead(){
	stringstream asmC;
	asmC <<"\t.global main"<<endl;
	asmC <<"\t.text"<<endl;

	asmC <<"main:"<<endl;
	asmC <<"\tsub $104,%rsp"<<endl; // Allocate 26*4 slot for $a-$z
	asmC <<"\tmov %rsp,%rbp"<<endl;
	return 	asmC.str();
}

string genTail(){
	stringstream asmC;
	asmC <<"\tadd $104, %rsp"<<endl;
	asmC <<"\tret"<<endl;
	asmC <<"show:"<<endl;
	asmC <<"\t.asciz \"%d\""<<endl;
	asmC <<"showx:"<<endl;
	asmC <<"\t.asciz \"%x\""<<endl;
	return asmC.str();
}

string init_var(int var_name){
			stringstream asmc;
			cout << "TEST" << endl;
			//return asmc.str();
			return "test \n";
}
