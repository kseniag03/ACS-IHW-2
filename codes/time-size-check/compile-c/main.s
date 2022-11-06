	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	SIZEMAX
	.section	.rodata
	.align 4
	.type	SIZEMAX, @object
	.size	SIZEMAX, 4
SIZEMAX:
	.long	100000
	.globl	VALUEMAX
	.align 4
	.type	VALUEMAX, @object
	.size	VALUEMAX, 4
VALUEMAX:
	.long	128
.LC0:
	.string	"arg = %s\n"
.LC1:
	.string	"input.txt"
.LC2:
	.string	"No arguments"
.LC3:
	.string	"Input: %s\n"
.LC4:
	.string	"Elapsed: %ld ns\n"
.LC5:
	.string	"Output: %s\n"
.LC6:
	.string	"output.txt"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	lea	r11, -98304[rsp]
.LPSRL0:
	sub	rsp, 4096
	or	DWORD PTR [rsp], 0
	cmp	rsp, r11
	jne	.LPSRL0
	sub	rsp, 1792
	mov	DWORD PTR -100084[rbp], edi
	mov	QWORD PTR -100096[rbp], rsi
	mov	eax, 100000
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	DWORD PTR -100084[rbp], 1
	jle	.L2
	mov	rax, QWORD PTR -100096[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -20[rbp], eax
	cmp	DWORD PTR -20[rbp], 1
	jne	.L3
	mov	rdx, QWORD PTR stdin[rip]
	mov	ecx, 100000
	mov	rax, QWORD PTR -8[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	fgets@PLT
	jmp	.L4
.L3:
	cmp	DWORD PTR -20[rbp], 2
	jne	.L5
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	file_input@PLT
	test	eax, eax
	je	.L4
	mov	eax, 1
	jmp	.L7
.L5:
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	random_generation@PLT
	jmp	.L4
.L2:
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L7
.L4:
	mov	rax, QWORD PTR -8[rbp]
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR -32[rbp], rax
	mov	QWORD PTR -100080[rbp], 0
	mov	QWORD PTR -100072[rbp], 0
	lea	rax, -100064[rbp]
	mov	edx, 99984
	mov	esi, 0
	mov	rdi, rax
	call	memset@PLT
	lea	rdx, -100080[rbp]
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	form_new_str@PLT
	lea	rax, -80[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdx, QWORD PTR -56[rbp]
	mov	rdi, QWORD PTR -80[rbp]
	mov	rsi, QWORD PTR -72[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	timespec_difference@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -100080[rbp]
	mov	rsi, rax
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -100080[rbp]
	lea	rdx, .LC6[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	file_output@PLT
	mov	eax, 0
.L7:
	leave
	ret
	.size	main, .-main
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
