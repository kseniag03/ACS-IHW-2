	.file	"random_generation.c"
	.text
	.p2align 4
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
	movq	%rdi, %rbx
	xorl	%edi, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	movl	SIZEMAX(%rip), %ecx
	movl	%ecx, %edx
	shrl	$31, %edx
	addl	%ecx, %edx
	movl	%edx, %esi
	cltd
	sarl	%esi
	idivl	%esi
	movl	%edx, %r12d
	testl	%edx, %edx
	jle	.L16
.L2:
	movl	VALUEMAX(%rip), %ebp
	xorl	%r13d, %r13d
	xorl	%r14d, %r14d
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L17:
	testw	%r13w, %r13w
	jne	.L6
	imull	$-1227133513, %edx, %eax
	movb	$32, (%rbx)
	addl	$306783378, %eax
	cmpl	$613566756, %eax
	jbe	.L7
	addq	$1, %rbx
	movl	$1, %r13d
	.p2align 4,,10
	.p2align 3
.L6:
	movb	%dl, (%rbx)
	addl	$1, %r14d
	addq	$1, %rbx
.L4:
	cmpl	%r12d, %r14d
	jge	.L3
.L8:
	call	rand@PLT
	cltd
	idivl	%ebp
	cmpl	$31, %edx
	jle	.L4
	leal	-48(%rdx), %eax
	cmpl	$9, %eax
	jbe	.L17
	testw	%r13w, %r13w
	je	.L6
	movb	$32, (%rbx)
	xorl	%r13d, %r13d
	addq	$1, %rbx
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L16:
	movl	$1, %r12d
	je	.L2
.L3:
	movb	$0, (%rbx)
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
	.p2align 4,,10
	.p2align 3
.L7:
	.cfi_restore_state
	movb	$45, 1(%rbx)
	movl	$1, %r13d
	addq	$2, %rbx
	jmp	.L6
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
