	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
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
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB36:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	leaq	-98304(%rsp), %r11
	.cfi_def_cfa 11, 98336
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	.cfi_def_cfa_register 7
	subq	$1744, %rsp
	.cfi_def_cfa_offset 100080
	movq	%fs:40, %rax
	movq	%rax, 100040(%rsp)
	xorl	%eax, %eax
	movl	%edi, %ebx
	movl	$100000, %edi
	movq	%rsi, %r12
	call	malloc@PLT
	decl	%ebx
	jle	.L2
	movq	8(%r12), %r12
	movl	$1, %edi
	movq	%rax, %rbp
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rsi
	movq	%r12, %rdx
	call	__printf_chk@PLT
	movq	%r12, %rdi
	call	atoi@PLT
	cmpl	$1, %eax
	jne	.L3
	movq	stdin(%rip), %rdx
	movl	$100000, %esi
	movq	%rbp, %rdi
	call	fgets@PLT
	jmp	.L4
.L3:
	cmpl	$2, %eax
	jne	.L5
	leaq	.LC1(%rip), %rsi
	movq	%rbp, %rdi
	call	file_input@PLT
	movl	%eax, %r8d
	movl	$1, %eax
	testl	%r8d, %r8d
	je	.L4
	jmp	.L1
.L5:
	movq	%rbp, %rdi
	call	random_generation@PLT
	jmp	.L4
.L2:
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	jmp	.L10
.L4:
	movq	%rbp, %rdx
	movl	$1, %edi
	leaq	40(%rsp), %r12
	xorl	%eax, %eax
	leaq	.LC3(%rip), %rsi
	call	__printf_chk@PLT
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	xorl	%eax, %eax
	leaq	56(%rsp), %rdi
	xorps	%xmm0, %xmm0
	movl	$24996, %ecx
	movq	%r12, %rsi
	movups	%xmm0, 40(%rsp)
	rep stosl
	movq	%rbp, %rdi
	call	form_new_str@PLT
	leaq	24(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	16(%rsp), %rcx
	movq	8(%rsp), %rdx
	movq	24(%rsp), %rdi
	movq	32(%rsp), %rsi
	call	timespec_difference@PLT
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	$1, %edi
	movq	%r12, %rdx
	xorl	%eax, %eax
	leaq	.LC5(%rip), %rsi
	call	__printf_chk@PLT
	leaq	.LC6(%rip), %rsi
	movq	%r12, %rdi
	call	file_output@PLT
.L10:
	xorl	%eax, %eax
.L1:
	movq	100040(%rsp), %rdx
	subq	%fs:40, %rdx
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	addq	$100048, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE36:
	.size	main, .-main
	.globl	VALUEMAX
	.section	.rodata
	.align 4
	.type	VALUEMAX, @object
	.size	VALUEMAX, 4
VALUEMAX:
	.long	128
	.globl	SIZEMAX
	.align 4
	.type	SIZEMAX, @object
	.size	SIZEMAX, 4
SIZEMAX:
	.long	100000
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
