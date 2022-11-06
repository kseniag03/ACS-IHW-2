	.file	"file_input.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"Unable to open file '%s'\n"
	.text
	.globl	file_input
	.type	file_input, @function
file_input:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	leaq	.LC0(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%r12, %rdi
	call	fopen@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	jne	.L2
	movq	%r12, %rdx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	$1, %eax
	jmp	.L1
.L2:
	movq	%rbp, %rdi
	incq	%rbx
	call	fgetc@PLT
	movb	%al, -1(%rbx)
	incl	%eax
	jne	.L2
	movb	$0, (%rbx)
	movq	%rbp, %rdi
	call	fclose@PLT
	xorl	%eax, %eax
.L1:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	file_input, .-file_input
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
