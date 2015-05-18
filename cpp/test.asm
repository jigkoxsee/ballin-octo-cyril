.text                                                                       
main:                                                    
sub $104,%rsp                                                               
mov %rsp,%rbp                                                               
movl $1, %eax                                                               
push %rax                                                                   
movl $2, %eax                                                               
push %rax                                                                   
pop %rbx                                                                    
pop %rax                                                                    
addl %ebx, %eax                                                             
push %rax                                                                   
pop %rax                                                                    
mov %eax,-92(%rbp)                                                          
show:                                                                               
.asciz "%d"                                                                 
showx:                                                                              
.asciz "%x"           
