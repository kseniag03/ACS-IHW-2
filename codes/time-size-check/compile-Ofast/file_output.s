	.file	"file_output.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"w"
	.text
	.p2align 4
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
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	leaq	.LC0(%rip), %rsi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	fopen@PLT
	testq	%rax, %rax
	je	.L1
	movsbl	(%rbx), %edi
	movq	%rax, %rbp
	testb	%dil, %dil
	je	.L3
	.p2align 4,,10
	.p2align 3
.L4:
	movq	%rbp, %rsi
	addq	$1, %rbx
	call	fputc@PLT
	movsbl	(%rbx), %edi
	testb	%dil, %dil
	jne	.L4
.L3:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	fclose@PLT
.L1:
	.cfi_restore_state
	popq	%rax
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
