	.file	"random_generation.c"
	.text
	.globl	random_generation
	.type	random_generation, @function
random_generation:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	xorl	%edi, %edi
	pushq	%rdx
	.cfi_def_cfa_offset 48
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	movl	$2, %ecx
	movl	%eax, %r8d
	movl	SIZEMAX(%rip), %eax
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	%r8d, %eax
	cltd
	idivl	%ecx
	movl	%edx, %r13d
	testl	%edx, %edx
	jg	.L2
	incl	%r13d
.L2:
	xorl	%r12d, %r12d
	xorl	%ebp, %ebp
.L3:
	cmpl	%ebp, %r13d
	jle	.L16
	call	rand@PLT
	cltd
	idivl	VALUEMAX(%rip)
	movl	%edx, %ecx
	cmpl	$31, %edx
	jg	.L4
	decl	%ebp
	jmp	.L5
.L4:
	leal	-48(%rdx), %eax
	cmpl	$9, %eax
	ja	.L6
	testw	%r12w, %r12w
	jne	.L7
	movl	%edx, %eax
	movl	$7, %esi
	movb	$32, (%rbx)
	cltd
	idivl	%esi
	testl	%edx, %edx
	je	.L8
	incq	%rbx
	jmp	.L14
.L8:
	movb	$45, 1(%rbx)
	addq	$2, %rbx
.L14:
	movl	$1, %r12d
	jmp	.L7
.L6:
	testw	%r12w, %r12w
	je	.L7
	movb	$32, (%rbx)
	xorl	%r12d, %r12d
	incq	%rbx
.L7:
	movb	%cl, (%rbx)
	incq	%rbx
.L5:
	incl	%ebp
	jmp	.L3
.L16:
	movb	$0, (%rbx)
	popq	%rax
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
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
