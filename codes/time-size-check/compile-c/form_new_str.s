	.file	"form_new_str.c"
	.intel_syntax noprefix
	.text
	.globl	form_new_str
	.type	form_new_str, @function
form_new_str:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 304
	mov	QWORD PTR -296[rbp], rdi
	mov	QWORD PTR -304[rbp], rsi
	mov	WORD PTR -2[rbp], 0
	mov	WORD PTR -4[rbp], 0
	mov	QWORD PTR -272[rbp], 0
	mov	QWORD PTR -264[rbp], 0
	mov	QWORD PTR -256[rbp], 0
	mov	QWORD PTR -248[rbp], 0
	mov	QWORD PTR -240[rbp], 0
	mov	QWORD PTR -232[rbp], 0
	mov	QWORD PTR -224[rbp], 0
	mov	QWORD PTR -216[rbp], 0
	mov	QWORD PTR -208[rbp], 0
	mov	QWORD PTR -200[rbp], 0
	mov	QWORD PTR -192[rbp], 0
	mov	QWORD PTR -184[rbp], 0
	mov	QWORD PTR -176[rbp], 0
	mov	QWORD PTR -168[rbp], 0
	mov	QWORD PTR -160[rbp], 0
	mov	QWORD PTR -152[rbp], 0
	mov	QWORD PTR -144[rbp], 0
	mov	QWORD PTR -136[rbp], 0
	mov	QWORD PTR -128[rbp], 0
	mov	QWORD PTR -120[rbp], 0
	mov	QWORD PTR -112[rbp], 0
	mov	QWORD PTR -104[rbp], 0
	mov	QWORD PTR -96[rbp], 0
	mov	QWORD PTR -88[rbp], 0
	mov	QWORD PTR -80[rbp], 0
	mov	QWORD PTR -72[rbp], 0
	mov	QWORD PTR -64[rbp], 0
	mov	QWORD PTR -56[rbp], 0
	mov	QWORD PTR -48[rbp], 0
	mov	QWORD PTR -40[rbp], 0
	mov	QWORD PTR -32[rbp], 0
	mov	QWORD PTR -24[rbp], 0
	jmp	.L2
.L11:
	mov	rax, QWORD PTR -296[rbp]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 45
	jne	.L3
	mov	rax, QWORD PTR -296[rbp]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 47
	jle	.L3
	mov	rax, QWORD PTR -296[rbp]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	al, 57
	jg	.L3
	mov	WORD PTR -4[rbp], 1
.L3:
	mov	rax, QWORD PTR -296[rbp]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 47
	jle	.L4
	mov	rax, QWORD PTR -296[rbp]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 57
	jg	.L4
	mov	WORD PTR -2[rbp], 1
	mov	rax, QWORD PTR -296[rbp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -274[rbp], al
	mov	BYTE PTR -273[rbp], 0
	lea	rdx, -274[rbp]
	lea	rax, -272[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcat@PLT
	jmp	.L5
.L4:
	cmp	WORD PTR -2[rbp], 0
	je	.L5
	mov	WORD PTR -2[rbp], 0
	jmp	.L6
.L8:
	lea	rax, -272[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	rdx, rax
	lea	rax, -272[rbp]
	add	rax, 1
	lea	rcx, -272[rbp]
	mov	rsi, rax
	mov	rdi, rcx
	call	memmove@PLT
.L6:
	movzx	eax, BYTE PTR -272[rbp]
	cmp	al, 48
	jne	.L7
	lea	rax, -272[rbp]
	mov	rdi, rax
	call	strlen@PLT
	cmp	rax, 1
	ja	.L8
.L7:
	cmp	WORD PTR -4[rbp], 0
	je	.L9
	movzx	eax, BYTE PTR -272[rbp]
	cmp	al, 48
	jne	.L10
	lea	rax, -272[rbp]
	mov	rdi, rax
	call	strlen@PLT
	cmp	rax, 1
	je	.L9
.L10:
	lea	rax, -272[rbp]
	mov	rdi, rax
	call	strlen@PLT
	lea	rdx, 1[rax]
	lea	rax, -272[rbp]
	add	rax, 1
	lea	rcx, -272[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	memmove@PLT
	mov	BYTE PTR -272[rbp], 45
	lea	rax, -272[rbp]
	mov	rdi, rax
	call	strlen@PLT
	lea	rdx, 1[rax]
	lea	rax, -272[rbp]
	add	rax, 1
	lea	rcx, -272[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	memmove@PLT
	mov	BYTE PTR -272[rbp], 40
	lea	rax, -272[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	rdx, rax
	lea	rax, -272[rbp]
	add	rax, rdx
	mov	WORD PTR [rax], 41
.L9:
	lea	rdx, -272[rbp]
	mov	rax, QWORD PTR -304[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcat@PLT
	mov	rax, QWORD PTR -304[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	rdx, rax
	mov	rax, QWORD PTR -304[rbp]
	add	rax, rdx
	mov	WORD PTR [rax], 43
	mov	BYTE PTR -272[rbp], 0
	mov	WORD PTR -4[rbp], 0
.L5:
	add	QWORD PTR -296[rbp], 1
.L2:
	mov	rax, QWORD PTR -296[rbp]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L11
	cmp	WORD PTR -2[rbp], 0
	je	.L12
	lea	rdx, -272[rbp]
	mov	rax, QWORD PTR -304[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcat@PLT
	mov	rax, QWORD PTR -304[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	rdx, rax
	mov	rax, QWORD PTR -304[rbp]
	add	rax, rdx
	mov	WORD PTR [rax], 43
	mov	BYTE PTR -272[rbp], 0
.L12:
	mov	rax, QWORD PTR -304[rbp]
	mov	rdi, rax
	call	strlen@PLT
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -304[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	nop
	leave
	ret
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
