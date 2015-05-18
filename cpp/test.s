	.global main
	.text
main:
	sub $104,%rsp
	mov %rsp,%rbp

	movl $4, %eax
	push %rax

	movl $2, %eax
	push %rax

	pop %rbx
	pop %rax
	xor %rdx,%rdx
	idivl %ebx
	push %rdx

	pop %rax
	mov %eax,-4(%rbp)

	add $104, %rsp
	ret
show:
	.asciz "%d"
showx:
	.asciz "%x"

