	.file	"form_new_str.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	")"
.LC1:
	.string	"+"
	.text
	.globl	form_new_str
	.type	form_new_str, @function
form_new_str:
.LFB25:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$60, %ecx
	xorps	%xmm0, %xmm0
	leaq	.LC1(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	xorl	%r13d, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rsi, %rbx
	subq	$272, %rsp
	.cfi_def_cfa_offset 320
	movq	%fs:40, %rax
	movq	%rax, 264(%rsp)
	xorl	%eax, %eax
	leaq	24(%rsp), %rdi
	movups	%xmm0, 8(%rsp)
	rep stosl
.L2:
	movb	(%r12), %dl
	testb	%dl, %dl
	je	.L29
	cmpb	$45, %dl
	jne	.L3
	movb	1(%r12), %cl
	subl	$48, %ecx
	cmpb	$9, %cl
	movl	$1, %ecx
	cmovbe	%ecx, %r13d
.L3:
	leal	-48(%rdx), %ecx
	cmpb	$9, %cl
	ja	.L4
	movb	%dl, 6(%rsp)
	leaq	6(%rsp), %rsi
	leaq	8(%rsp), %rdi
	movl	$256, %edx
	movb	$0, 7(%rsp)
	call	__strcat_chk@PLT
	movl	$1, %eax
	jmp	.L5
.L4:
	leaq	8(%rsp), %rbp
	testw	%ax, %ax
	je	.L5
.L6:
	cmpb	$48, 8(%rsp)
	jne	.L7
	movq	%rbp, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	cmpq	$1, %rax
	jbe	.L30
	leaq	9(%rsp), %rsi
	movl	$256, %ecx
	movq	%rbp, %rdi
	call	__memmove_chk@PLT
	jmp	.L6
.L30:
	testw	%r13w, %r13w
	je	.L10
	decq	%rdx
.L27:
	je	.L10
	movq	%rbp, %rdi
	leaq	9(%rsp), %r13
	call	strlen@PLT
	movl	$255, %ecx
	movq	%rbp, %rsi
	movq	%r13, %rdi
	leaq	1(%rax), %rdx
	call	__memmove_chk@PLT
	movq	%rbp, %rdi
	movb	$45, 8(%rsp)
	call	strlen@PLT
	movq	%rbp, %rsi
	movq	%r13, %rdi
	movl	$255, %ecx
	leaq	1(%rax), %rdx
	call	__memmove_chk@PLT
	movl	$256, %edx
	movq	%rbp, %rdi
	leaq	.LC0(%rip), %rsi
	movb	$40, 8(%rsp)
	call	__strcat_chk@PLT
.L10:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	xorl	%r13d, %r13d
	call	strcat@PLT
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	strcat@PLT
	movb	$0, 8(%rsp)
	xorl	%eax, %eax
.L5:
	incq	%r12
	jmp	.L2
.L29:
	testw	%ax, %ax
	je	.L12
	leaq	8(%rsp), %rsi
	movq	%rbx, %rdi
	call	strcat@PLT
	leaq	.LC1(%rip), %rsi
	movq	%rbx, %rdi
	call	strcat@PLT
.L12:
	movq	%rbx, %rdi
	call	strlen@PLT
	movb	$0, -1(%rbx,%rax)
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	je	.L15
	call	__stack_chk_fail@PLT
.L7:
	testw	%r13w, %r13w
	jmp	.L27
.L15:
	addq	$272, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
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
	.cfi_endproc
.LFE25:
	.size	form_new_str, .-form_new_str
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
