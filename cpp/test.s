	.global main
	.text
main:
	sub $104,%rsp
	mov %rsp,%rbp

	movl $1, %eax
	push %rax

	pop %rbx
	mov -36(%rbp), %eax
	addl %ebx, %eax
	push %rax

	pop %rax
	mov %eax,-36(%rbp)

	add $104, %rsp
	ret
show:
	.asciz "%d"
showx:
	.asciz "%x"

