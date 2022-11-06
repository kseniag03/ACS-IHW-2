	.file	"file_input.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"Unable to open file '%s'\n"
	.text
	.globl	file_input
	.type	file_input, @function
file_input:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L2
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L3
.L2:
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -12[rbp], eax
	mov	eax, DWORD PTR -12[rbp]
	mov	edx, eax
	mov	rax, QWORD PTR -24[rbp]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR -24[rbp], 1
	cmp	DWORD PTR -12[rbp], -1
	jne	.L2
	mov	rax, QWORD PTR -24[rbp]
	mov	BYTE PTR [rax], 0
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 0
.L3:
	leave
	ret
	.size	file_input, .-file_input
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
