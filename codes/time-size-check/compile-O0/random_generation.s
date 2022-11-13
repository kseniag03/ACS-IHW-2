	.file	"random_generation.c"
	.text
	.globl	random_generation
	.type	random_generation, @function
random_generation:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	movl	SIZEMAX(%rip), %edx
	movl	%edx, %ecx
	shrl	$31, %ecx
	addl	%ecx, %edx
	sarl	%edx
	movl	%edx, %ecx
	cltd
	idivl	%ecx
	movl	%edx, -12(%rbp)
	cmpl	$0, -12(%rbp)
	jg	.L2
	addl	$1, -12(%rbp)
.L2:
	movw	$0, -14(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L3
.L9:
	call	rand@PLT
	movl	VALUEMAX(%rip), %ecx
	cltd
	idivl	%ecx
	movl	%edx, -4(%rbp)
	cmpl	$31, -4(%rbp)
	jg	.L4
	subl	$1, -8(%rbp)
	jmp	.L5
.L4:
	cmpl	$47, -4(%rbp)
	jle	.L6
	cmpl	$57, -4(%rbp)
	jg	.L6
	cmpw	$0, -14(%rbp)
	jne	.L7
	movq	-24(%rbp), %rax
	movb	$32, (%rax)
	addq	$1, -24(%rbp)
	movl	-4(%rbp), %edx
	movslq	%edx, %rax
	imulq	$-1840700269, %rax, %rax
	shrq	$32, %rax
	addl	%edx, %eax
	sarl	$2, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	movl	%eax, %ecx
	sall	$3, %ecx
	subl	%eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	testl	%eax, %eax
	jne	.L7
	movq	-24(%rbp), %rax
	movb	$45, (%rax)
	addq	$1, -24(%rbp)
.L7:
	movw	$1, -14(%rbp)
	jmp	.L8
.L6:
	cmpw	$0, -14(%rbp)
	je	.L8
	movw	$0, -14(%rbp)
	movq	-24(%rbp), %rax
	movb	$32, (%rax)
	addq	$1, -24(%rbp)
.L8:
	movl	-4(%rbp), %eax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	movb	%dl, (%rax)
	addq	$1, -24(%rbp)
.L5:
	addl	$1, -8(%rbp)
.L3:
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.L9
	movq	-24(%rbp), %rax
	movb	$0, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
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
