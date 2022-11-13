	.file	"form_new_str.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	")"
	.text
	.globl	form_new_str
	.type	form_new_str, @function
form_new_str:
.LFB35:
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
	subq	$288, %rsp
	.cfi_def_cfa_offset 336
	movq	%rsi, %r12
	movq	%fs:40, %rax
	movq	%rax, 280(%rsp)
	xorl	%eax, %eax
	movq	$0, 16(%rsp)
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	$0, 40(%rsp)
	movq	$0, 48(%rsp)
	movq	$0, 56(%rsp)
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	movq	$0, 80(%rsp)
	movq	$0, 88(%rsp)
	movq	$0, 96(%rsp)
	movq	$0, 104(%rsp)
	movq	$0, 112(%rsp)
	movq	$0, 120(%rsp)
	movq	$0, 128(%rsp)
	movq	$0, 136(%rsp)
	movq	$0, 144(%rsp)
	movq	$0, 152(%rsp)
	movq	$0, 160(%rsp)
	movq	$0, 168(%rsp)
	movq	$0, 176(%rsp)
	movq	$0, 184(%rsp)
	movq	$0, 192(%rsp)
	movq	$0, 200(%rsp)
	movq	$0, 208(%rsp)
	movq	$0, 216(%rsp)
	movq	$0, 224(%rsp)
	movq	$0, 232(%rsp)
	movq	$0, 240(%rsp)
	movq	$0, 248(%rsp)
	movq	$0, 256(%rsp)
	movq	$0, 264(%rsp)
	movzbl	(%rdi), %eax
	testb	%al, %al
	je	.L2
	movq	%rdi, %rbx
	movl	$0, %r13d
	movl	$0, %edx
	leaq	.LC0(%rip), %r14
	jmp	.L11
.L20:
	movzbl	1(%rbx), %eax
	subl	$48, %eax
	cmpb	$9, %al
	movl	$1, %eax
	cmovbe	%eax, %r13d
.L5:
	testw	%dx, %dx
	jne	.L18
.L6:
	addq	$1, %rbx
	movzbl	(%rbx), %eax
	testb	%al, %al
	je	.L19
.L11:
	cmpb	$45, %al
	je	.L20
	leal	-48(%rax), %ecx
	cmpb	$9, %cl
	ja	.L5
	movb	%al, 14(%rsp)
	movb	$0, 15(%rsp)
	leaq	14(%rsp), %rsi
	leaq	16(%rsp), %rdi
	movl	$256, %edx
	call	__strcat_chk@PLT
	movl	$1, %edx
	jmp	.L6
.L18:
	leaq	16(%rsp), %rbp
	cmpb	$48, 16(%rsp)
	jne	.L8
.L7:
	movq	%rbp, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	cmpq	$1, %rax
	jbe	.L21
	leaq	17(%rsp), %rsi
	movl	$256, %ecx
	movq	%rbp, %rdi
	call	__memmove_chk@PLT
	cmpb	$48, 16(%rsp)
	je	.L7
.L8:
	testw	%r13w, %r13w
	je	.L10
.L12:
	leaq	16(%rsp), %rbp
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	1(%rax), %rdx
	leaq	17(%rsp), %r13
	movl	$255, %ecx
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	__memmove_chk@PLT
	movb	$45, 16(%rsp)
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	1(%rax), %rdx
	movl	$255, %ecx
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	__memmove_chk@PLT
	movb	$40, 16(%rsp)
	movl	$256, %edx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	call	__strcat_chk@PLT
.L10:
	leaq	16(%rsp), %rsi
	movq	%r12, %rdi
	call	strcat@PLT
	movq	%r12, %rdi
	call	strlen@PLT
	movw	$43, (%r12,%rax)
	movb	$0, 16(%rsp)
	movl	$0, %r13d
	movl	$0, %edx
	jmp	.L6
.L21:
	testw	%r13w, %r13w
	je	.L10
	cmpq	$1, %rax
	jne	.L12
	jmp	.L10
.L19:
	testw	%dx, %dx
	jne	.L22
.L2:
	movq	%r12, %rdi
	call	strlen@PLT
	movb	$0, -1(%r12,%rax)
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L23
	addq	$288, %rsp
	.cfi_remember_state
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
.L22:
	.cfi_restore_state
	leaq	16(%rsp), %rsi
	movq	%r12, %rdi
	call	strcat@PLT
	movq	%r12, %rdi
	call	strlen@PLT
	movw	$43, (%r12,%rax)
	jmp	.L2
.L23:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE35:
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
