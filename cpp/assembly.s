	.global main
	.text
main:
	mov %rsp,%rbp
	sub $208,%rsp

	xor %rax,%rax
	mov %rax,-8(%rbp)

	mov $9, %rax
	push %rax

	pop %rax
	xor %rbx,%rbx
	sub $rax,%rbx
	push %rbx

	mov $33, %rax
	push %rax

	pop %rbx
	pop %rax
	sub %rbx, %rax
	push %rax

	pop %rax
	mov %rax,-8(%rbp)

	push %rax
	push %rbx
	push %rcx
	mov $show, %rdi
	mov -8(%rbp), %rax
	mov %rax,%rsi
	xor %rax,%rax
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	add $208, %rsp
	ret
show:
	.asciz "%d\n"
showx:
	.asciz "0x%x\n"

