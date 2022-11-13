	.file	"random_generation.c"
	.text
	.globl	random_generation
	.type	random_generation, @function
random_generation:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbp
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	movl	SIZEMAX(%rip), %edx
	movl	%edx, %ecx
	shrl	$31, %ecx
	addl	%edx, %ecx
	sarl	%ecx
	cltd
	idivl	%ecx
	movl	%edx, %r12d
	testl	%edx, %edx
	jle	.L12
.L2:
	movl	$0, %r13d
	movl	$0, %ebx
	movl	$0, %r14d
	jmp	.L9
.L12:
	leal	1(%rdx), %r12d
	testl	%r12d, %r12d
	jg	.L2
.L3:
	movb	$0, 0(%rbp)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L13:
	.cfi_restore_state
	subl	$1, %ebx
	jmp	.L5
.L8:
	movb	$45, 1(%rbp)
	addq	$2, %rbp
	movl	$1, %r13d
	jmp	.L7
.L6:
	testw	%r13w, %r13w
	je	.L7
	movb	$32, 0(%rbp)
	addq	$1, %rbp
	movl	%r14d, %r13d
.L7:
	movb	%dl, 0(%rbp)
	addq	$1, %rbp
.L5:
	addl	$1, %ebx
	cmpl	%r12d, %ebx
	jge	.L3
.L9:
	call	rand@PLT
	cltd
	idivl	VALUEMAX(%rip)
	cmpl	$31, %edx
	jle	.L13
	leal	-48(%rdx), %eax
	cmpl	$9, %eax
	ja	.L6
	testw	%r13w, %r13w
	jne	.L7
	movb	$32, 0(%rbp)
	movslq	%edx, %rax
	imulq	$-1840700269, %rax, %rax
	shrq	$32, %rax
	addl	%edx, %eax
	sarl	$2, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	leal	0(,%rax,8), %ecx
	subl	%eax, %ecx
	cmpl	%ecx, %edx
	je	.L8
	addq	$1, %rbp
	movl	$1, %r13d
	jmp	.L7
	.cfi_endproc
.LFE39:
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
