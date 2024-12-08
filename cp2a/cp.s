	.file	"cp.cc"
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.section	.text._ZNKSt5ctypeIcE8do_widenEc,"axG",@progbits,_ZNKSt5ctypeIcE8do_widenEc,comdat
	.align 2
	.p2align 4
	.weak	_ZNKSt5ctypeIcE8do_widenEc
	.type	_ZNKSt5ctypeIcE8do_widenEc, @function
_ZNKSt5ctypeIcE8do_widenEc:
.LFB2407:
	.cfi_startproc
	endbr64
	movl	%esi, %eax
	ret
	.cfi_endproc
.LFE2407:
	.size	_ZNKSt5ctypeIcE8do_widenEc, .-_ZNKSt5ctypeIcE8do_widenEc
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"Elapsed time: "
.LC3:
	.string	" seconds"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4
	.globl	_Z9correlateiiPKfPf
	.type	_Z9correlateiiPKfPf, @function
_Z9correlateiiPKfPf:
.LFB2753:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movslq	%edi, %rax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rax, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movl	%esi, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$216, %rsp
	.cfi_def_cfa_offset 272
	testl	%esi, %esi
	movq	%rcx, 200(%rsp)
	leal	3(%rsi), %ecx
	cmovns	%esi, %ecx
	movl	%eax, 136(%rsp)
	movq	%rax, 192(%rsp)
	sarl	$2, %ecx
	shrq	$60, %rax
	jne	.L4
	leaq	0(,%r14,8), %rbx
	movq	%rdx, %rbp
	movl	%ecx, %r15d
	movq	%rbx, %rdi
	call	_Znam@PLT
	movq	%rax, 120(%rsp)
	testl	%r14d, %r14d
	je	.L5
	pxor	%xmm2, %xmm2
	movq	%rax, %rdi
	leaq	(%rbx,%rax), %r9
	xorl	%r8d, %r8d
	cvtsi2sdl	%r13d, %xmm2
	movslq	%r13d, %r10
.L6:
	pxor	%xmm0, %xmm0
	testl	%r13d, %r13d
	jle	.L10
	movslq	%r8d, %rdx
	pxor	%xmm0, %xmm0
	leaq	0(%rbp,%rdx,4), %rax
	addq	%r10, %rdx
	leaq	0(%rbp,%rdx,4), %rdx
	.p2align 4,,10
	.p2align 3
.L7:
	pxor	%xmm1, %xmm1
	addq	$4, %rax
	cvtss2sd	-4(%rax), %xmm1
	addsd	%xmm1, %xmm0
	cmpq	%rax, %rdx
	jne	.L7
.L10:
	divsd	%xmm2, %xmm0
	addq	$8, %rdi
	addl	%r13d, %r8d
	movsd	%xmm0, -8(%rdi)
	cmpq	%r9, %rdi
	jne	.L6
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	leal	0(,%r15,4), %r8d
	movl	$0, 188(%rsp)
	movslq	%r8d, %rax
	movl	$0, 184(%rsp)
	movq	%rax, 168(%rsp)
	movl	%r13d, %eax
	subl	%r8d, %eax
	movl	%r8d, 140(%rsp)
	movq	%rax, 160(%rsp)
	movq	$0, 176(%rsp)
	movq	$0x000000000, 8(%rsp)
.L24:
	movq	120(%rsp), %rax
	movq	176(%rsp), %r14
	movq	200(%rsp), %rsi
	movsd	(%rax,%r14,8), %xmm12
	movslq	188(%rsp), %rax
	movq	%rax, 144(%rsp)
	movq	%rax, %rbx
	leaq	0(%rbp,%rax,4), %rax
	movq	%rax, 152(%rsp)
	movslq	184(%rsp), %rax
	leaq	(%rsi,%rax,4), %rax
	movq	%rax, 128(%rsp)
	.p2align 4,,10
	.p2align 3
.L23:
	movq	120(%rsp), %rax
	movsd	%xmm12, 16(%rsp)
	movsd	(%rax,%r14,8), %xmm3
	movsd	%xmm3, (%rsp)
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	cmpl	$3, %r13d
	movsd	(%rsp), %xmm3
	movsd	16(%rsp), %xmm12
	movq	%rax, %r12
	jle	.L28
	movslq	%ebx, %rax
	pxor	%xmm2, %xmm2
	xorl	%ecx, %ecx
	leaq	0(%rbp,%rax,4), %rdx
	movapd	%xmm2, %xmm4
	movapd	%xmm2, %xmm6
	movq	152(%rsp), %rax
	movapd	%xmm2, %xmm8
	movapd	%xmm2, %xmm11
	movapd	%xmm2, %xmm13
	movsd	%xmm2, (%rsp)
	movapd	%xmm2, %xmm1
	movapd	%xmm2, %xmm9
	movapd	%xmm2, %xmm5
	movapd	%xmm2, %xmm7
	movapd	%xmm2, %xmm10
	.p2align 4,,10
	.p2align 3
.L13:
	pxor	%xmm0, %xmm0
	pxor	%xmm14, %xmm14
	addl	$1, %ecx
	addq	$16, %rdx
	cvtss2sd	-16(%rdx), %xmm0
	subsd	%xmm3, %xmm0
	cvtss2sd	(%rax), %xmm14
	subsd	%xmm12, %xmm14
	addq	$16, %rax
	movapd	%xmm0, %xmm15
	mulsd	%xmm0, %xmm15
	mulsd	%xmm14, %xmm0
	addsd	%xmm15, %xmm10
	movapd	%xmm14, %xmm15
	mulsd	%xmm14, %xmm15
	addsd	%xmm0, %xmm8
	pxor	%xmm0, %xmm0
	cvtss2sd	-12(%rdx), %xmm0
	subsd	%xmm3, %xmm0
	pxor	%xmm14, %xmm14
	cvtss2sd	-12(%rax), %xmm14
	subsd	%xmm12, %xmm14
	addsd	%xmm15, %xmm9
	movapd	%xmm0, %xmm15
	mulsd	%xmm0, %xmm15
	mulsd	%xmm14, %xmm0
	addsd	%xmm15, %xmm7
	movapd	%xmm14, %xmm15
	mulsd	%xmm14, %xmm15
	addsd	%xmm0, %xmm6
	pxor	%xmm0, %xmm0
	cvtss2sd	-8(%rdx), %xmm0
	subsd	%xmm3, %xmm0
	pxor	%xmm14, %xmm14
	cvtss2sd	-8(%rax), %xmm14
	subsd	%xmm12, %xmm14
	addsd	%xmm15, %xmm1
	movapd	%xmm0, %xmm15
	mulsd	%xmm0, %xmm15
	mulsd	%xmm14, %xmm0
	addsd	%xmm15, %xmm5
	movapd	%xmm14, %xmm15
	mulsd	%xmm14, %xmm15
	addsd	%xmm0, %xmm4
	pxor	%xmm0, %xmm0
	cvtss2sd	-4(%rdx), %xmm0
	subsd	%xmm3, %xmm0
	pxor	%xmm14, %xmm14
	cvtss2sd	-4(%rax), %xmm14
	subsd	%xmm12, %xmm14
	addsd	%xmm15, %xmm13
	movapd	%xmm0, %xmm15
	mulsd	%xmm0, %xmm15
	addsd	(%rsp), %xmm15
	mulsd	%xmm14, %xmm0
	movsd	%xmm15, (%rsp)
	movapd	%xmm14, %xmm15
	mulsd	%xmm14, %xmm15
	addsd	%xmm0, %xmm2
	addsd	%xmm15, %xmm11
	cmpl	%ecx, %r15d
	jg	.L13
.L12:
	movsd	%xmm12, 104(%rsp)
	movsd	%xmm13, 96(%rsp)
	movsd	%xmm6, 88(%rsp)
	movsd	%xmm8, 80(%rsp)
	movsd	%xmm10, 72(%rsp)
	movsd	%xmm5, 64(%rsp)
	movsd	%xmm11, 56(%rsp)
	movsd	%xmm9, 48(%rsp)
	movsd	%xmm4, 40(%rsp)
	movsd	%xmm7, 32(%rsp)
	movsd	%xmm2, 24(%rsp)
	movsd	%xmm1, 16(%rsp)
	movsd	%xmm3, 112(%rsp)
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movsd	72(%rsp), %xmm10
	movsd	48(%rsp), %xmm9
	pxor	%xmm7, %xmm7
	movsd	80(%rsp), %xmm8
	movsd	16(%rsp), %xmm1
	subq	%r12, %rax
	pxor	%xmm0, %xmm0
	addsd	%xmm7, %xmm10
	addsd	%xmm7, %xmm9
	movsd	88(%rsp), %xmm6
	movsd	64(%rsp), %xmm5
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm7, %xmm8
	movsd	32(%rsp), %xmm7
	movsd	96(%rsp), %xmm13
	movsd	40(%rsp), %xmm4
	divsd	.LC1(%rip), %xmm0
	addsd	8(%rsp), %xmm0
	addsd	%xmm10, %xmm7
	addsd	%xmm9, %xmm1
	movl	140(%rsp), %eax
	movsd	56(%rsp), %xmm11
	addsd	%xmm8, %xmm6
	movsd	24(%rsp), %xmm2
	movsd	104(%rsp), %xmm12
	movsd	%xmm0, 8(%rsp)
	movsd	(%rsp), %xmm0
	cmpl	%eax, %r13d
	addsd	%xmm7, %xmm5
	addsd	%xmm13, %xmm1
	addsd	%xmm6, %xmm4
	addsd	%xmm5, %xmm0
	addsd	%xmm11, %xmm1
	addsd	%xmm4, %xmm2
	jle	.L14
	movq	168(%rsp), %rdi
	movslq	%ebx, %rsi
	movq	160(%rsp), %rcx
	movsd	112(%rsp), %xmm3
	leaq	(%rcx,%rdi), %rdx
	leaq	(%rsi,%rdi), %rax
	addq	%rsi, %rdx
	leaq	0(%rbp,%rax,4), %rax
	leaq	0(%rbp,%rdx,4), %rcx
	movq	144(%rsp), %rdx
	subq	%rsi, %rdx
	.p2align 4,,10
	.p2align 3
.L15:
	pxor	%xmm4, %xmm4
	pxor	%xmm5, %xmm5
	cvtss2sd	(%rax), %xmm4
	subsd	%xmm3, %xmm4
	cvtss2sd	(%rax,%rdx,4), %xmm5
	subsd	%xmm12, %xmm5
	addq	$4, %rax
	movapd	%xmm4, %xmm6
	mulsd	%xmm4, %xmm6
	mulsd	%xmm5, %xmm4
	addsd	%xmm6, %xmm0
	movapd	%xmm5, %xmm6
	mulsd	%xmm5, %xmm6
	addsd	%xmm4, %xmm2
	addsd	%xmm6, %xmm1
	cmpq	%rcx, %rax
	jne	.L15
.L14:
	pxor	%xmm7, %xmm7
	ucomisd	%xmm0, %xmm7
	ja	.L36
	sqrtsd	%xmm0, %xmm0
.L18:
	divsd	%xmm0, %xmm2
	ucomisd	%xmm1, %xmm7
	ja	.L37
	sqrtsd	%xmm1, %xmm1
	movq	128(%rsp), %rax
	addl	%r13d, %ebx
	divsd	%xmm1, %xmm2
	cvtsd2ss	%xmm2, %xmm2
	movss	%xmm2, (%rax,%r14,4)
	addq	$1, %r14
	cmpl	%r14d, 136(%rsp)
	jg	.L23
.L22:
	addq	$1, 176(%rsp)
	movl	136(%rsp), %edi
	addl	%r13d, 188(%rsp)
	movq	176(%rsp), %rax
	addl	%edi, 184(%rsp)
	cmpq	%rax, 192(%rsp)
	jne	.L24
.L11:
	leaq	_ZSt4cout(%rip), %rbx
	movl	$14, %edx
	leaq	.LC2(%rip), %rsi
	movq	%rbx, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movsd	8(%rsp), %xmm0
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$8, %edx
	leaq	.LC3(%rip), %rsi
	movq	%rax, %rbx
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	movq	240(%rbx,%rax), %rbp
	testq	%rbp, %rbp
	je	.L39
	cmpb	$0, 56(%rbp)
	je	.L26
	movsbl	67(%rbp), %esi
.L27:
	movq	%rbx, %rdi
	call	_ZNSo3putEc@PLT
	movq	%rax, %rdi
	call	_ZNSo5flushEv@PLT
	movq	120(%rsp), %rdi
	addq	$216, %rsp
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
	jmp	_ZdaPv@PLT
.L28:
	.cfi_restore_state
	pxor	%xmm2, %xmm2
	movapd	%xmm2, %xmm4
	movapd	%xmm2, %xmm6
	movapd	%xmm2, %xmm8
	movsd	%xmm2, (%rsp)
	movapd	%xmm2, %xmm11
	movapd	%xmm2, %xmm13
	movapd	%xmm2, %xmm1
	movapd	%xmm2, %xmm9
	movapd	%xmm2, %xmm5
	movapd	%xmm2, %xmm7
	movapd	%xmm2, %xmm10
	jmp	.L12
.L26:
	movq	%rbp, %rdi
	call	_ZNKSt5ctypeIcE13_M_widen_initEv@PLT
	movq	0(%rbp), %rax
	movl	$10, %esi
	leaq	_ZNKSt5ctypeIcE8do_widenEc(%rip), %rdx
	movq	48(%rax), %rax
	cmpq	%rdx, %rax
	je	.L27
	movq	%rbp, %rdi
	call	*%rax
	movsbl	%al, %esi
	jmp	.L27
.L5:
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	$0x000000000, 8(%rsp)
	jmp	.L11
.L36:
	movsd	%xmm12, 24(%rsp)
	movsd	%xmm2, 16(%rsp)
	movsd	%xmm1, (%rsp)
	call	sqrt@PLT
	movsd	24(%rsp), %xmm12
	movsd	16(%rsp), %xmm2
	pxor	%xmm7, %xmm7
	movsd	(%rsp), %xmm1
	jmp	.L18
.L39:
	call	_ZSt16__throw_bad_castv@PLT
	.p2align 4,,10
	.p2align 3
.L37:
	movapd	%xmm1, %xmm0
	movsd	%xmm12, 16(%rsp)
	addl	%r13d, %ebx
	movsd	%xmm2, (%rsp)
	call	sqrt@PLT
	movsd	(%rsp), %xmm2
	movq	128(%rsp), %rax
	movsd	16(%rsp), %xmm12
	divsd	%xmm0, %xmm2
	cvtsd2ss	%xmm2, %xmm2
	movss	%xmm2, (%rax,%r14,4)
	addq	$1, %r14
	cmpl	%r14d, 136(%rsp)
	jg	.L23
	jmp	.L22
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	_Z9correlateiiPKfPf.cold, @function
_Z9correlateiiPKfPf.cold:
.LFSB2753:
.L4:
	.cfi_def_cfa_offset 272
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__cxa_throw_bad_array_new_length@PLT
	.cfi_endproc
.LFE2753:
	.text
	.size	_Z9correlateiiPKfPf, .-_Z9correlateiiPKfPf
	.section	.text.unlikely
	.size	_Z9correlateiiPKfPf.cold, .-_Z9correlateiiPKfPf.cold
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1104006501
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
