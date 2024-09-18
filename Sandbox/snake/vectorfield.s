	.file	"vectorfield.c"
	.text
	.globl	vector_field
	.type	vector_field, @function
vector_field:
.LFB4879:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movss	%xmm0, -4(%rbp)
	movss	%xmm1, -8(%rbp)
	movss	%xmm2, -12(%rbp)
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	pxor	%xmm3, %xmm3
	cvtss2sd	-12(%rbp), %xmm3
	movq	%xmm3, %rax
	movq	%rax, %xmm0
	call	cos@PLT
	pxor	%xmm1, %xmm1
	cvtss2sd	-8(%rbp), %xmm1
	mulsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movq	-24(%rbp), %rax
	movss	%xmm0, (%rax)
	pxor	%xmm4, %xmm4
	cvtss2sd	-12(%rbp), %xmm4
	movq	%xmm4, %rax
	movq	%rax, %xmm0
	call	sin@PLT
	pxor	%xmm1, %xmm1
	cvtss2sd	-4(%rbp), %xmm1
	mulsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movq	-32(%rbp), %rax
	movss	%xmm0, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4879:
	.size	vector_field, .-vector_field
	.globl	draw_arrow
	.type	draw_arrow, @function
draw_arrow:
.LFB4880:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -40(%rbp)
	movss	%xmm0, -44(%rbp)
	movss	%xmm1, -48(%rbp)
	movss	%xmm2, -52(%rbp)
	movss	%xmm3, -56(%rbp)
	movss	-52(%rbp), %xmm0
	movaps	%xmm0, %xmm1
	mulss	%xmm0, %xmm1
	movss	-56(%rbp), %xmm0
	mulss	%xmm0, %xmm0
	addss	%xmm1, %xmm0
	pxor	%xmm2, %xmm2
	cvtss2sd	%xmm0, %xmm2
	movq	%xmm2, %rax
	movq	%rax, %xmm0
	call	sqrt@PLT
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -32(%rbp)
	pxor	%xmm0, %xmm0
	ucomiss	-32(%rbp), %xmm0
	jp	.L3
	pxor	%xmm0, %xmm0
	ucomiss	-32(%rbp), %xmm0
	je	.L6
.L3:
	movss	.LC1(%rip), %xmm0
	movss	%xmm0, -28(%rbp)
	pxor	%xmm0, %xmm0
	cvtss2sd	-52(%rbp), %xmm0
	pxor	%xmm3, %xmm3
	cvtss2sd	-56(%rbp), %xmm3
	movq	%xmm3, %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	atan2@PLT
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -24(%rbp)
	movss	-52(%rbp), %xmm0
	divss	-32(%rbp), %xmm0
	movss	-28(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	movss	%xmm0, -52(%rbp)
	movss	-56(%rbp), %xmm0
	divss	-32(%rbp), %xmm0
	movss	-28(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	movss	%xmm0, -56(%rbp)
	movss	-48(%rbp), %xmm0
	addss	-56(%rbp), %xmm0
	cvttss2sil	%xmm0, %edi
	movss	-44(%rbp), %xmm0
	addss	-52(%rbp), %xmm0
	cvttss2sil	%xmm0, %ecx
	movss	-48(%rbp), %xmm0
	cvttss2sil	%xmm0, %edx
	movss	-44(%rbp), %xmm0
	cvttss2sil	%xmm0, %esi
	movq	-40(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	SDL_RenderDrawLine@PLT
	movss	.LC2(%rip), %xmm0
	movss	%xmm0, -20(%rbp)
	movss	-44(%rbp), %xmm0
	addss	-52(%rbp), %xmm0
	pxor	%xmm4, %xmm4
	cvtss2sd	%xmm0, %xmm4
	movsd	%xmm4, -64(%rbp)
	pxor	%xmm5, %xmm5
	cvtss2sd	-28(%rbp), %xmm5
	movsd	%xmm5, -72(%rbp)
	movss	-24(%rbp), %xmm0
	subss	-20(%rbp), %xmm0
	pxor	%xmm6, %xmm6
	cvtss2sd	%xmm0, %xmm6
	movq	%xmm6, %rax
	movq	%rax, %xmm0
	call	cos@PLT
	mulsd	-72(%rbp), %xmm0
	movsd	-64(%rbp), %xmm1
	subsd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	cvtsd2ss	%xmm1, %xmm0
	movss	%xmm0, -16(%rbp)
	movss	-48(%rbp), %xmm0
	addss	-56(%rbp), %xmm0
	pxor	%xmm5, %xmm5
	cvtss2sd	%xmm0, %xmm5
	movsd	%xmm5, -64(%rbp)
	pxor	%xmm4, %xmm4
	cvtss2sd	-28(%rbp), %xmm4
	movsd	%xmm4, -72(%rbp)
	movss	-24(%rbp), %xmm0
	subss	-20(%rbp), %xmm0
	pxor	%xmm7, %xmm7
	cvtss2sd	%xmm0, %xmm7
	movq	%xmm7, %rax
	movq	%rax, %xmm0
	call	sin@PLT
	mulsd	-72(%rbp), %xmm0
	movsd	-64(%rbp), %xmm1
	subsd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	cvtsd2ss	%xmm1, %xmm0
	movss	%xmm0, -12(%rbp)
	movss	-12(%rbp), %xmm0
	cvttss2sil	%xmm0, %edi
	movss	-16(%rbp), %xmm0
	cvttss2sil	%xmm0, %ecx
	movss	-48(%rbp), %xmm0
	addss	-56(%rbp), %xmm0
	cvttss2sil	%xmm0, %edx
	movss	-44(%rbp), %xmm0
	addss	-52(%rbp), %xmm0
	cvttss2sil	%xmm0, %esi
	movq	-40(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	SDL_RenderDrawLine@PLT
	movss	-44(%rbp), %xmm0
	addss	-52(%rbp), %xmm0
	pxor	%xmm6, %xmm6
	cvtss2sd	%xmm0, %xmm6
	movsd	%xmm6, -64(%rbp)
	pxor	%xmm2, %xmm2
	cvtss2sd	-28(%rbp), %xmm2
	movsd	%xmm2, -72(%rbp)
	movss	-24(%rbp), %xmm0
	addss	-20(%rbp), %xmm0
	pxor	%xmm3, %xmm3
	cvtss2sd	%xmm0, %xmm3
	movq	%xmm3, %rax
	movq	%rax, %xmm0
	call	cos@PLT
	mulsd	-72(%rbp), %xmm0
	movsd	-64(%rbp), %xmm1
	subsd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	cvtsd2ss	%xmm1, %xmm0
	movss	%xmm0, -8(%rbp)
	movss	-48(%rbp), %xmm0
	addss	-56(%rbp), %xmm0
	pxor	%xmm7, %xmm7
	cvtss2sd	%xmm0, %xmm7
	movsd	%xmm7, -64(%rbp)
	pxor	%xmm6, %xmm6
	cvtss2sd	-28(%rbp), %xmm6
	movsd	%xmm6, -72(%rbp)
	movss	-24(%rbp), %xmm0
	addss	-20(%rbp), %xmm0
	pxor	%xmm3, %xmm3
	cvtss2sd	%xmm0, %xmm3
	movq	%xmm3, %rax
	movq	%rax, %xmm0
	call	sin@PLT
	mulsd	-72(%rbp), %xmm0
	movsd	-64(%rbp), %xmm1
	subsd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	cvtsd2ss	%xmm1, %xmm0
	movss	%xmm0, -4(%rbp)
	movss	-4(%rbp), %xmm0
	cvttss2sil	%xmm0, %edi
	movss	-8(%rbp), %xmm0
	cvttss2sil	%xmm0, %ecx
	movss	-48(%rbp), %xmm0
	addss	-56(%rbp), %xmm0
	cvttss2sil	%xmm0, %edx
	movss	-44(%rbp), %xmm0
	addss	-52(%rbp), %xmm0
	cvttss2sil	%xmm0, %esi
	movq	-40(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	SDL_RenderDrawLine@PLT
	jmp	.L2
.L6:
	nop
.L2:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4880:
	.size	draw_arrow, .-draw_arrow
	.section	.rodata
.LC3:
	.string	"Vektorfeld-Plotter"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4881:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movl	%edi, -116(%rbp)
	movq	%rsi, -128(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$32, %edi
	call	SDL_Init@PLT
	movl	$0, %r9d
	movl	$600, %r8d
	movl	$800, %ecx
	movl	$805240832, %edx
	movl	$805240832, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	SDL_CreateWindow@PLT
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movl	$0, %edx
	movl	$-1, %esi
	movq	%rax, %rdi
	call	SDL_CreateRenderer@PLT
	movq	%rax, -72(%rbp)
	movb	$1, -109(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -100(%rbp)
	jmp	.L8
.L11:
	movl	-64(%rbp), %eax
	cmpl	$256, %eax
	jne	.L9
	movb	$0, -109(%rbp)
.L9:
	leaq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	SDL_PollEvent@PLT
	testl	%eax, %eax
	jne	.L11
	movq	-72(%rbp), %rax
	movl	$255, %r8d
	movl	$255, %ecx
	movl	$255, %edx
	movl	$255, %esi
	movq	%rax, %rdi
	call	SDL_SetRenderDrawColor@PLT
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	SDL_RenderClear@PLT
	movq	-72(%rbp), %rax
	movl	$255, %r8d
	movl	$0, %ecx
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	SDL_SetRenderDrawColor@PLT
	movl	$0, -96(%rbp)
	jmp	.L12
.L15:
	movl	$0, -92(%rbp)
	jmp	.L13
.L14:
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-96(%rbp), %xmm0
	movss	%xmm0, -88(%rbp)
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-92(%rbp), %xmm0
	movss	%xmm0, -84(%rbp)
	movss	-84(%rbp), %xmm0
	movss	.LC4(%rip), %xmm1
	movaps	%xmm0, %xmm3
	subss	%xmm1, %xmm3
	movss	-88(%rbp), %xmm0
	movss	.LC5(%rip), %xmm1
	subss	%xmm1, %xmm0
	movd	%xmm0, %eax
	leaq	-104(%rbp), %rcx
	leaq	-108(%rbp), %rdx
	movss	-100(%rbp), %xmm0
	movq	%rcx, %rsi
	movq	%rdx, %rdi
	movaps	%xmm0, %xmm2
	movaps	%xmm3, %xmm1
	movd	%eax, %xmm0
	call	vector_field
	movss	-104(%rbp), %xmm2
	movss	-108(%rbp), %xmm1
	movss	-84(%rbp), %xmm0
	movl	-88(%rbp), %edx
	movq	-72(%rbp), %rax
	movaps	%xmm2, %xmm3
	movaps	%xmm1, %xmm2
	movaps	%xmm0, %xmm1
	movd	%edx, %xmm0
	movq	%rax, %rdi
	call	draw_arrow
	addl	$20, -92(%rbp)
.L13:
	cmpl	$600, -92(%rbp)
	jle	.L14
	addl	$20, -96(%rbp)
.L12:
	cmpl	$800, -96(%rbp)
	jle	.L15
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	SDL_RenderPresent@PLT
	movss	-100(%rbp), %xmm1
	movss	.LC6(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -100(%rbp)
	movl	$16, %edi
	call	SDL_Delay@PLT
.L8:
	cmpb	$0, -109(%rbp)
	jne	.L9
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	SDL_DestroyRenderer@PLT
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	SDL_DestroyWindow@PLT
	call	SDL_Quit@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L18
	call	__stack_chk_fail@PLT
.L18:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4881:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC1:
	.long	1092616192
	.align 4
.LC2:
	.long	1057360530
	.align 4
.LC4:
	.long	1133903872
	.align 4
.LC5:
	.long	1137180672
	.align 4
.LC6:
	.long	1008981770
	.ident	"GCC: (Ubuntu 13.2.0-23ubuntu4) 13.2.0"
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
