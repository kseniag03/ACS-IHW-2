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
	.text
	.globl	main
	.type	main, @function
main:
.LFB51:
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
	movl	%edi, %ebp
	movq	%rsi, %r12
	movq	%fs:40, %rax
	movq	%rax, 100040(%rsp)
	xorl	%eax, %eax
	movl	$100000, %edi
	call	malloc@PLT
	cmpl	$1, %ebp
	jle	.L2
	movq	%rax, %rbx
	movq	8(%r12), %rbp
	movq	%rbp, %rdx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$10, %edx
	movl	$0, %esi
	movq	%rbp, %rdi
	call	strtol@PLT
	cmpl	$1, %eax
	je	.L10
	cmpl	$2, %eax
	je	.L11
	movq	%rbx, %rdi
	call	random_generation@PLT
.L4:
	movq	%rbx, %rdx
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rsp, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	$0, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	48(%rsp), %rdi
	movl	$99984, %edx
	movl	$0, %esi
	call	memset@PLT
	leaq	32(%rsp), %rbp
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	form_new_str@PLT
	leaq	16(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	(%rsp), %rdx
	movq	8(%rsp), %rcx
	movq	16(%rsp), %rdi
	movq	24(%rsp), %rsi
	call	timespec_difference@PLT
	movq	%rax, %rdx
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rbp, %rdx
	leaq	.LC5(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC6(%rip), %rsi
	movq	%rbp, %rdi
	call	file_output@PLT
	movl	$0, %eax
.L1:
	movq	100040(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L12
	addq	$100048, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L10:
	.cfi_restore_state
	movq	stdin(%rip), %rdx
	movl	$100000, %esi
	movq	%rbx, %rdi
	call	fgets@PLT
	jmp	.L4
.L11:
	leaq	.LC1(%rip), %rsi
	movq	%rbx, %rdi
	call	file_input@PLT
	testl	%eax, %eax
	je	.L4
	movl	$1, %eax
	jmp	.L1
.L2:
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L1
.L12:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE51:
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
