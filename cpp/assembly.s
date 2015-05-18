	.global main
	.text
main:
	mov %rsp,%rbp
	sub $208,%rsp

	xor %rax,%rax
	mov %rax,-72(%rbp)

	mov $3, %rax
	push %rax

	pop %rax
	mov %rax,-72(%rbp)

	mov $10, %rax
	push %rax

	pop %rcx
	xor %rax,%rax
	cmp %rax,%rcx
	je EL0
L0:

	mov $1, %rax
	push %rax

	pop %rbx
	mov -72(%rbp), %rax
	add %rbx, %rax
	push %rax

	pop %rax
	mov %rax,-72(%rbp)

	push %rax
	push %rbx
	push %rcx
	mov $show, %rdi
	mov -72(%rbp), %rax
	mov %rax,%rsi
	xor %rax,%rax
	call printf
	pop %rcx
	pop %rbx
	pop %rax

	dec %rcx
	jnz L0
EL0:

	add $208, %rsp
	ret
show:
	.asciz "%d\n"
showx:
	.asciz "%x\n"

