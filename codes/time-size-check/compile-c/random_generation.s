	.file	"random_generation.c"
	.intel_syntax noprefix
	.text
	.globl	random_generation
	.type	random_generation, @function
random_generation:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	mov	edx, DWORD PTR SIZEMAX[rip]
	mov	ecx, edx
	shr	ecx, 31
	add	edx, ecx
	sar	edx
	mov	ecx, edx
	cdq
	idiv	ecx
	mov	DWORD PTR -4[rbp], edx
	cmp	DWORD PTR -4[rbp], 0
	jg	.L2
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	WORD PTR -10[rbp], 0
	mov	DWORD PTR -8[rbp], 0
	jmp	.L3
.L9:
	call	rand@PLT
	mov	ecx, DWORD PTR VALUEMAX[rip]
	cdq
	idiv	ecx
	mov	DWORD PTR -16[rbp], edx
	cmp	DWORD PTR -16[rbp], 31
	jg	.L4
	sub	DWORD PTR -8[rbp], 1
	jmp	.L5
.L4:
	cmp	DWORD PTR -16[rbp], 47
	jle	.L6
	cmp	DWORD PTR -16[rbp], 57
	jg	.L6
	cmp	WORD PTR -10[rbp], 0
	jne	.L7
	mov	rax, QWORD PTR -24[rbp]
	mov	BYTE PTR [rax], 32
	add	QWORD PTR -24[rbp], 1
	mov	edx, DWORD PTR -16[rbp]
	movsx	rax, edx
	imul	rax, rax, -1840700269
	shr	rax, 32
	add	eax, edx
	sar	eax, 2
	mov	ecx, edx
	sar	ecx, 31
	sub	eax, ecx
	mov	ecx, eax
	sal	ecx, 3
	sub	ecx, eax
	mov	eax, edx
	sub	eax, ecx
	test	eax, eax
	jne	.L7
	mov	rax, QWORD PTR -24[rbp]
	mov	BYTE PTR [rax], 45
	add	QWORD PTR -24[rbp], 1
.L7:
	mov	WORD PTR -10[rbp], 1
	jmp	.L8
.L6:
	cmp	WORD PTR -10[rbp], 0
	je	.L8
	mov	WORD PTR -10[rbp], 0
	mov	rax, QWORD PTR -24[rbp]
	mov	BYTE PTR [rax], 32
	add	QWORD PTR -24[rbp], 1
.L8:
	mov	eax, DWORD PTR -16[rbp]
	mov	edx, eax
	mov	rax, QWORD PTR -24[rbp]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR -24[rbp], 1
.L5:
	add	DWORD PTR -8[rbp], 1
.L3:
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -4[rbp]
	jl	.L9
	mov	rax, QWORD PTR -24[rbp]
	mov	BYTE PTR [rax], 0
	nop
	leave
	ret
	.size	random_generation, .-random_generation
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
