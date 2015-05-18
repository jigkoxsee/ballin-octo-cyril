	.global main
	.text
main:
	sub $104,%rsp
	mov %rsp,%rbp

test 

	movl $1, %eax
	push %rax

	movl $2, %eax
	push %rax

	pop %rbx
	pop %rax
	addl %ebx, %eax
	push %rax

	pop %rax
	mov %eax,-4(%rbp)

	add $104, %rsp
	ret
show:
	.asciz "%d"
showx:
	.asciz "%x"

