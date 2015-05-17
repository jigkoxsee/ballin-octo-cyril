	.global main
	.text
main:
	sub $104,%rsp
	mov %rsp,%rbp

	movl $3, %eax
	push %rax

	pop %rax
	mov %eax,-4(%rbp)

	movl $4, %eax
	push %rax

	pop %rax
	mov %eax,-8(%rbp)

show:
	.asciz "%d"
showx:
	.asciz "%x"

