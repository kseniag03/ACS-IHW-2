	.file	"form_new_str.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	")"
	.text
	.p2align 4
	.globl	form_new_str
	.type	form_new_str, @function
form_new_str:
.LFB35:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pxor	%xmm0, %xmm0
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$296, %rsp
	.cfi_def_cfa_offset 352
	movq	%fs:40, %rax
	movq	%rax, 280(%rsp)
	xorl	%eax, %eax
	movzbl	(%rdi), %eax
	movaps	%xmm0, 16(%rsp)
	movaps	%xmm0, 32(%rsp)
	movaps	%xmm0, 48(%rsp)
	movaps	%xmm0, 64(%rsp)
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm0, 96(%rsp)
	movaps	%xmm0, 112(%rsp)
	movaps	%xmm0, 128(%rsp)
	movaps	%xmm0, 144(%rsp)
	movaps	%xmm0, 160(%rsp)
	movaps	%xmm0, 176(%rsp)
	movaps	%xmm0, 192(%rsp)
	movaps	%xmm0, 208(%rsp)
	movaps	%xmm0, 224(%rsp)
	movaps	%xmm0, 240(%rsp)
	movaps	%xmm0, 256(%rsp)
	testb	%al, %al
	je	.L3
	movq	%rdi, %rbx
	xorl	%r13d, %r13d
	leaq	.LC0(%rip), %r14
	xorl	%edx, %edx
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L4:
	leal	-48(%rax), %ecx
	cmpb	$9, %cl
	ja	.L5
	leaq	16(%rsp), %r15
	movl	$256, %edx
	leaq	14(%rsp), %rsi
	movb	%al, 14(%rsp)
	movq	%r15, %rdi
	movb	$0, 15(%rsp)
	call	__strcat_chk@PLT
	movl	$1, %edx
.L6:
	movzbl	1(%rbx), %eax
	addq	$1, %rbx
	testb	%al, %al
	je	.L40
.L2:
	cmpb	$45, %al
	jne	.L4
	movzbl	1(%rbx), %eax
	subl	$48, %eax
	cmpb	$9, %al
	ja	.L5
	movl	$1, %r13d
	testw	%dx, %dx
	je	.L6
	cmpb	$48, 16(%rsp)
	movl	%edx, %r13d
	leaq	16(%rsp), %r15
	je	.L7
	.p2align 4,,10
	.p2align 3
.L8:
	movq	%r15, %rdi
	call	strlen@PLT
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L5:
	testw	%dx, %dx
	je	.L6
	cmpb	$48, 16(%rsp)
	leaq	16(%rsp), %r15
	jne	.L9
.L7:
	leaq	16(%rsp), %r15
	leaq	17(%rsp), %rbp
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L11:
	movl	$256, %ecx
	movq	%rbp, %rsi
	movq	%r15, %rdi
	call	__memmove_chk@PLT
	cmpb	$48, 16(%rsp)
	jne	.L9
.L10:
	movq	%r15, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	cmpq	$1, %rax
	ja	.L11
	testw	%r13w, %r13w
	je	.L14
	xorl	%eax, %eax
	cmpq	$1, %rdx
	je	.L14
.L13:
	leaq	17(%rsp), %rbp
	leaq	1(%rax), %rdx
	movl	$255, %ecx
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	__memmove_chk@PLT
	movq	%r15, %rdi
	movb	$45, 16(%rsp)
	call	strlen@PLT
	movq	%r15, %rsi
	movq	%rbp, %rdi
	movl	$255, %ecx
	leaq	1(%rax), %rdx
	call	__memmove_chk@PLT
	movl	$256, %edx
	movq	%r14, %rsi
	movq	%r15, %rdi
	movb	$40, 16(%rsp)
	call	__strcat_chk@PLT
.L14:
	movq	%r12, %rdi
	addq	$1, %rbx
	xorl	%r13d, %r13d
	call	strlen@PLT
	movq	%r15, %rsi
	leaq	(%r12,%rax), %rdi
	call	stpcpy@PLT
	movl	$43, %ecx
	movb	$0, 16(%rsp)
	xorl	%edx, %edx
	movw	%cx, (%rax)
	movzbl	(%rbx), %eax
	testb	%al, %al
	jne	.L2
	.p2align 4,,10
	.p2align 3
.L40:
	testw	%dx, %dx
	jne	.L41
.L3:
	movq	%r12, %rdi
	call	strlen@PLT
	movb	$0, -1(%r12,%rax)
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L42
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	.cfi_restore_state
	testw	%r13w, %r13w
	je	.L14
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L41:
	movq	%r12, %rdi
	call	strlen@PLT
	leaq	16(%rsp), %rsi
	leaq	(%r12,%rax), %rdi
	call	stpcpy@PLT
	movl	$43, %edx
	movw	%dx, (%rax)
	jmp	.L3
.L42:
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
