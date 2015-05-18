	.global main
	.text
main:
	mov %rsp,%rbp
	sub $104,%rsp

	xor %rax,%rax
	mov %rax,-16(%rbp)

	mov $5, %rax
	push %rax

	pop %rax
	mov %rax,-16(%rbp)

	mov $2, %rax
	push %rax

	pop %rbx
	mov -16(%rbp), %rax
	add %rbx, %rax
	push %rax

	pop %rax
	mov %rax,-16(%rbp)

	push %rax
	push %rbx
	push %rcx
	mov $show, %rdi
	mov -16(%rbp), %rax
	mov %rax,%rsi
	xor %rax,%rax
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	mov $4, %rax
	push %rax

	pop %rax
	mov %rax,-16(%rbp)

	push %rax
	push %rbx
	push %rcx
	mov $show, %rdi
	mov -16(%rbp), %rax
	mov %rax,%rsi
	xor %rax,%rax
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	xor %rax,%rax
	mov %rax,-8(%rbp)

	mov $77, %rax
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

	add $104, %rsp
	ret
show:
	.asciz "%d\n"
showx:
	.asciz "%x\n"

