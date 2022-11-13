	.file	"main.c"
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
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	-98304(%rsp), %r11
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	subq	$1808, %rsp
	movl	%edi, -100100(%rbp)
	movq	%rsi, -100112(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$100000, %eax
	cltq
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -100080(%rbp)
	cmpl	$1, -100100(%rbp)
	jle	.L2
	movq	-100112(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -100072(%rbp)
	movq	-100072(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-100072(%rbp), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -100084(%rbp)
	cmpl	$1, -100084(%rbp)
	jne	.L3
	movq	stdin(%rip), %rdx
	movl	$100000, %ecx
	movq	-100080(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	jmp	.L4
.L3:
	cmpl	$2, -100084(%rbp)
	jne	.L5
	movq	-100080(%rbp), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	file_input@PLT
	testl	%eax, %eax
	je	.L4
	movl	$1, %eax
	jmp	.L7
.L5:
	movq	-100080(%rbp), %rax
	movq	%rax, %rdi
	call	random_generation@PLT
	jmp	.L4
.L2:
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L7
.L4:
	movq	-100080(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-100048(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-100080(%rbp), %rax
	movq	%rax, -100064(%rbp)
	movq	$0, -100016(%rbp)
	movq	$0, -100008(%rbp)
	leaq	-100000(%rbp), %rax
	movl	$99984, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	leaq	-100016(%rbp), %rdx
	movq	-100064(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	form_new_str@PLT
	leaq	-100032(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-100048(%rbp), %rax
	movq	-100040(%rbp), %rdx
	movq	-100032(%rbp), %rdi
	movq	-100024(%rbp), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	call	timespec_difference@PLT
	movq	%rax, -100056(%rbp)
	movq	-100056(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-100016(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-100016(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	file_output@PLT
	movl	$0, %eax
.L7:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
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
