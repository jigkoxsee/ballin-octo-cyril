	.global main
	.text
main:
	push %rbp
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

	mov $show, %rdi
	mov -8(%rbp), %rax
	mov %rax,%rsi
	push %rax
	push %rbx
	push %rcx
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	movl $4, %eax
	push %rax

	pop %rax
	mov %eax,-8(%rbp)

	mov $show, %edi
	mov -8(%rbp), %eax
	movl %eax,%esi
	push %rax
	push %rbx
	push %rcx
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	add $104, %rsp
	ret
show:
	.asciz "%d\n"
showx:
	.asciz "%x\n"

