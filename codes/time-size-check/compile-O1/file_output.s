	.file	"file_output.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"w"
	.text
	.globl	file_output
	.type	file_output, @function
file_output:
.LFB23:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	leaq	.LC0(%rip), %rsi
	call	fopen@PLT
	testq	%rax, %rax
	je	.L1
	movq	%rax, %rbp
	movzbl	(%rbx), %edi
	testb	%dil, %dil
	je	.L3
.L4:
	movsbl	%dil, %edi
	movq	%rbp, %rsi
	call	fputc@PLT
	addq	$1, %rbx
	movzbl	(%rbx), %edi
	testb	%dil, %dil
	jne	.L4
.L3:
	movq	%rbp, %rdi
	call	fclose@PLT
.L1:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	file_output, .-file_output
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
