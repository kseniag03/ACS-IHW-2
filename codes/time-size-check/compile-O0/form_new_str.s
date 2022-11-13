	.file	"form_new_str.c"
	.text
	.globl	form_new_str
	.type	form_new_str, @function
form_new_str:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$304, %rsp
	movq	%rdi, -296(%rbp)
	movq	%rsi, -304(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movw	$0, -278(%rbp)
	movw	$0, -276(%rbp)
	movq	$0, -272(%rbp)
	movq	$0, -264(%rbp)
	movq	$0, -256(%rbp)
	movq	$0, -248(%rbp)
	movq	$0, -240(%rbp)
	movq	$0, -232(%rbp)
	movq	$0, -224(%rbp)
	movq	$0, -216(%rbp)
	movq	$0, -208(%rbp)
	movq	$0, -200(%rbp)
	movq	$0, -192(%rbp)
	movq	$0, -184(%rbp)
	movq	$0, -176(%rbp)
	movq	$0, -168(%rbp)
	movq	$0, -160(%rbp)
	movq	$0, -152(%rbp)
	movq	$0, -144(%rbp)
	movq	$0, -136(%rbp)
	movq	$0, -128(%rbp)
	movq	$0, -120(%rbp)
	movq	$0, -112(%rbp)
	movq	$0, -104(%rbp)
	movq	$0, -96(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	jmp	.L2
.L11:
	movq	-296(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$45, %al
	jne	.L3
	movq	-296(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$47, %al
	jle	.L3
	movq	-296(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$57, %al
	jg	.L3
	movw	$1, -276(%rbp)
.L3:
	movq	-296(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$47, %al
	jle	.L4
	movq	-296(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$57, %al
	jg	.L4
	movw	$1, -278(%rbp)
	movq	-296(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -274(%rbp)
	movb	$0, -273(%rbp)
	leaq	-274(%rbp), %rdx
	leaq	-272(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	jmp	.L5
.L4:
	cmpw	$0, -278(%rbp)
	je	.L5
	movw	$0, -278(%rbp)
	jmp	.L6
.L8:
	leaq	-272(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-272(%rbp), %rax
	addq	$1, %rax
	leaq	-272(%rbp), %rcx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	memmove@PLT
.L6:
	movzbl	-272(%rbp), %eax
	cmpb	$48, %al
	jne	.L7
	leaq	-272(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	cmpq	$1, %rax
	ja	.L8
.L7:
	cmpw	$0, -276(%rbp)
	je	.L9
	movzbl	-272(%rbp), %eax
	cmpb	$48, %al
	jne	.L10
	leaq	-272(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	cmpq	$1, %rax
	je	.L9
.L10:
	leaq	-272(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	leaq	1(%rax), %rdx
	leaq	-272(%rbp), %rax
	addq	$1, %rax
	leaq	-272(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memmove@PLT
	movb	$45, -272(%rbp)
	leaq	-272(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	leaq	1(%rax), %rdx
	leaq	-272(%rbp), %rax
	addq	$1, %rax
	leaq	-272(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memmove@PLT
	movb	$40, -272(%rbp)
	leaq	-272(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-272(%rbp), %rax
	addq	%rdx, %rax
	movw	$41, (%rax)
.L9:
	leaq	-272(%rbp), %rdx
	movq	-304(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	movq	-304(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-304(%rbp), %rax
	addq	%rdx, %rax
	movw	$43, (%rax)
	movb	$0, -272(%rbp)
	movw	$0, -276(%rbp)
.L5:
	addq	$1, -296(%rbp)
.L2:
	movq	-296(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L11
	cmpw	$0, -278(%rbp)
	je	.L12
	leaq	-272(%rbp), %rdx
	movq	-304(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	movq	-304(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-304(%rbp), %rax
	addq	%rdx, %rax
	movw	$43, (%rax)
	movb	$0, -272(%rbp)
.L12:
	movq	-304(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	leaq	-1(%rax), %rdx
	movq	-304(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
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
