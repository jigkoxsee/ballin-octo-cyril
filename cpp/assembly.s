	.global main
	.text
main:
	mov %rsp,%rbp
	sub $104,%rsp

	movl $5, %eax
	push %rax

	pop %rax
	mov %eax,-8(%rbp)

	movl $2, %eax
	push %rax

	pop %rbx
	mov -8(%rbp), %eax
	addl %ebx, %eax
	push %rax

	pop %rax
	mov %eax,-8(%rbp)

	push %rax
	push %rbx
	push %rcx
	mov $show, %edi
	mov -8(%rbp), %eax
	movl %eax,%esi
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	add $104, %rsp
	ret
show:
	.asciz "%d"
showx:
	.asciz "%x"

