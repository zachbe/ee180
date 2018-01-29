	.syntax unified
	.arch armv7-a
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu vfpv3-d16
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.thumb
	.file	"sobel_calc.cpp"
	.text
	.align	2
	.thumb
	.thumb_func
	.type	_ZN9__gnu_cxxL18__exchange_and_addEPVii, %function
_ZN9__gnu_cxxL18__exchange_and_addEPVii:
	.fnstart
.LFB650:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	ldr	r2, [r7]
	ldr	r3, [r7, #4]
	dmb	sy
.L3:
	ldrex	r1, [r3]
	add	r0, r1, r2
	strex	lr, r0, [r3]
	cmp	lr, #0
	bne	.L3
	dmb	sy
	mov	r3, r1
	mov	r0, r3
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.cantunwind
	.fnend
	.size	_ZN9__gnu_cxxL18__exchange_and_addEPVii, .-_ZN9__gnu_cxxL18__exchange_and_addEPVii
	.section	.text._ZN2cv3Mat9initEmptyEv,"axG",%progbits,_ZN2cv3Mat9initEmptyEv,comdat
	.align	2
	.weak	_ZN2cv3Mat9initEmptyEv
	.thumb
	.thumb_func
	.type	_ZN2cv3Mat9initEmptyEv, %function
_ZN2cv3Mat9initEmptyEv:
	.fnstart
.LFB2903:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r2, [r7, #4]
	movs	r3, #0
	movt	r3, 17151
	str	r3, [r2]
	ldr	r3, [r7, #4]
	movs	r2, #0
	str	r2, [r3, #12]
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #12]
	ldr	r3, [r7, #4]
	str	r2, [r3, #8]
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #8]
	ldr	r3, [r7, #4]
	str	r2, [r3, #4]
	ldr	r3, [r7, #4]
	movs	r2, #0
	str	r2, [r3, #32]
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #32]
	ldr	r3, [r7, #4]
	str	r2, [r3, #28]
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #28]
	ldr	r3, [r7, #4]
	str	r2, [r3, #24]
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #24]
	ldr	r3, [r7, #4]
	str	r2, [r3, #16]
	ldr	r3, [r7, #4]
	movs	r2, #0
	str	r2, [r3, #20]
	ldr	r3, [r7, #4]
	movs	r2, #0
	str	r2, [r3, #36]
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.cantunwind
	.fnend
	.size	_ZN2cv3Mat9initEmptyEv, .-_ZN2cv3Mat9initEmptyEv
	.section	.text._ZN2cv3MatC2Ev,"axG",%progbits,_ZN2cv3MatC5Ev,comdat
	.align	2
	.weak	_ZN2cv3MatC2Ev
	.thumb
	.thumb_func
	.type	_ZN2cv3MatC2Ev, %function
_ZN2cv3MatC2Ev:
	.fnstart
.LFB2905:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r3, [r7, #4]
	add	r2, r3, #40
	ldr	r3, [r7, #4]
	adds	r3, r3, #8
	mov	r1, r3
	mov	r0, r2
	bl	_ZN2cv3Mat5MSizeC1EPi
	ldr	r3, [r7, #4]
	adds	r3, r3, #44
	mov	r0, r3
	bl	_ZN2cv3Mat5MStepC1Ev
	ldr	r0, [r7, #4]
	bl	_ZN2cv3Mat9initEmptyEv
	ldr	r3, [r7, #4]
	mov	r0, r3
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.cantunwind
	.fnend
	.size	_ZN2cv3MatC2Ev, .-_ZN2cv3MatC2Ev
	.weak	_ZN2cv3MatC1Ev
	.thumb_set _ZN2cv3MatC1Ev,_ZN2cv3MatC2Ev
	.section	.text._ZN2cv3MatD2Ev,"axG",%progbits,_ZN2cv3MatD5Ev,comdat
	.align	2
	.weak	_ZN2cv3MatD2Ev
	.thumb
	.thumb_func
	.type	_ZN2cv3MatD2Ev, %function
_ZN2cv3MatD2Ev:
	.fnstart
.LFB2941:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	.save {r7, lr}
	.pad #8
	sub	sp, sp, #8
	.setfp r7, sp, #0
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r0, [r7, #4]
	bl	_ZN2cv3Mat7releaseEv
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #44]
	ldr	r3, [r7, #4]
	adds	r3, r3, #48
	cmp	r2, r3
	beq	.L10
	ldr	r3, [r7, #4]
	ldr	r3, [r3, #44]
	mov	r0, r3
	bl	_ZN2cv8fastFreeEPv
.L10:
	ldr	r3, [r7, #4]
	mov	r0, r3
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.fnend
	.size	_ZN2cv3MatD2Ev, .-_ZN2cv3MatD2Ev
	.weak	_ZN2cv3MatD1Ev
	.thumb_set _ZN2cv3MatD1Ev,_ZN2cv3MatD2Ev
	.section	.text._ZNK2cv3Mat5cloneEv,"axG",%progbits,_ZNK2cv3Mat5cloneEv,comdat
	.align	2
	.weak	_ZNK2cv3Mat5cloneEv
	.thumb
	.thumb_func
	.type	_ZNK2cv3Mat5cloneEv, %function
_ZNK2cv3Mat5cloneEv:
	.fnstart
.LFB2951:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	.save {r7, lr}
	.pad #32
	sub	sp, sp, #32
	.setfp r7, sp, #0
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	movw	r3, #:lower16:__stack_chk_guard
	movt	r3, #:upper16:__stack_chk_guard
	ldr	r3, [r3]
	str	r3, [r7, #28]
	ldr	r0, [r7, #4]
	bl	_ZN2cv3MatC1Ev
	add	r3, r7, #8
	ldr	r1, [r7, #4]
	mov	r0, r3
.LEHB0:
	bl	_ZN2cv12_OutputArrayC1ERNS_3MatE
	add	r3, r7, #8
	mov	r1, r3
	ldr	r0, [r7]
	bl	_ZNK2cv3Mat6copyToERKNS_12_OutputArrayE
.LEHE0:
	b	.L17
.L16:
	ldr	r0, [r7, #4]
	bl	_ZN2cv3MatD1Ev
.LEHB1:
	bl	__cxa_end_cleanup
.LEHE1:
.L17:
	ldr	r0, [r7, #4]
	movw	r3, #:lower16:__stack_chk_guard
	movt	r3, #:upper16:__stack_chk_guard
	ldr	r2, [r7, #28]
	ldr	r3, [r3]
	cmp	r2, r3
	beq	.L15
	bl	__stack_chk_fail
.L15:
	adds	r7, r7, #32
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.global	__gxx_personality_v0
	.personality	__gxx_personality_v0
	.handlerdata
.LLSDA2951:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE2951-.LLSDACSB2951
.LLSDACSB2951:
	.uleb128 .LEHB0-.LFB2951
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L16-.LFB2951
	.uleb128 0
	.uleb128 .LEHB1-.LFB2951
	.uleb128 .LEHE1-.LEHB1
	.uleb128 0
	.uleb128 0
.LLSDACSE2951:
	.section	.text._ZNK2cv3Mat5cloneEv,"axG",%progbits,_ZNK2cv3Mat5cloneEv,comdat
	.fnend
	.size	_ZNK2cv3Mat5cloneEv, .-_ZNK2cv3Mat5cloneEv
	.section	.text._ZN2cv3Mat7releaseEv,"axG",%progbits,_ZN2cv3Mat7releaseEv,comdat
	.align	2
	.weak	_ZN2cv3Mat7releaseEv
	.thumb
	.thumb_func
	.type	_ZN2cv3Mat7releaseEv, %function
_ZN2cv3Mat7releaseEv:
	.fnstart
.LFB2956:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	.save {r7, lr}
	.pad #8
	sub	sp, sp, #8
	.setfp r7, sp, #0
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r3, [r7, #4]
	ldr	r3, [r3, #20]
	cmp	r3, #0
	beq	.L19
	ldr	r3, [r7, #4]
	ldr	r3, [r3, #20]
	mov	r1, #-1
	mov	r0, r3
	bl	_ZN9__gnu_cxxL18__exchange_and_addEPVii
	mov	r3, r0
	cmp	r3, #1
	bne	.L19
	movs	r3, #1
	b	.L20
.L19:
	movs	r3, #0
.L20:
	cmp	r3, #0
	beq	.L21
	ldr	r0, [r7, #4]
	bl	_ZN2cv3Mat10deallocateEv
.L21:
	ldr	r3, [r7, #4]
	movs	r2, #0
	str	r2, [r3, #32]
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #32]
	ldr	r3, [r7, #4]
	str	r2, [r3, #28]
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #28]
	ldr	r3, [r7, #4]
	str	r2, [r3, #24]
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #24]
	ldr	r3, [r7, #4]
	str	r2, [r3, #16]
	ldr	r3, [r7, #4]
	ldr	r3, [r3, #40]
	movs	r2, #0
	str	r2, [r3]
	ldr	r3, [r7, #4]
	movs	r2, #0
	str	r2, [r3, #20]
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.fnend
	.size	_ZN2cv3Mat7releaseEv, .-_ZN2cv3Mat7releaseEv
	.section	.text._ZN2cv3Mat5MSizeC2EPi,"axG",%progbits,_ZN2cv3Mat5MSizeC5EPi,comdat
	.align	2
	.weak	_ZN2cv3Mat5MSizeC2EPi
	.thumb
	.thumb_func
	.type	_ZN2cv3Mat5MSizeC2EPi, %function
_ZN2cv3Mat5MSizeC2EPi:
	.fnstart
.LFB3007:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	ldr	r3, [r7, #4]
	ldr	r2, [r7]
	str	r2, [r3]
	ldr	r3, [r7, #4]
	mov	r0, r3
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.cantunwind
	.fnend
	.size	_ZN2cv3Mat5MSizeC2EPi, .-_ZN2cv3Mat5MSizeC2EPi
	.weak	_ZN2cv3Mat5MSizeC1EPi
	.thumb_set _ZN2cv3Mat5MSizeC1EPi,_ZN2cv3Mat5MSizeC2EPi
	.section	.text._ZN2cv3Mat5MStepC2Ev,"axG",%progbits,_ZN2cv3Mat5MStepC5Ev,comdat
	.align	2
	.weak	_ZN2cv3Mat5MStepC2Ev
	.thumb
	.thumb_func
	.type	_ZN2cv3Mat5MStepC2Ev, %function
_ZN2cv3Mat5MStepC2Ev:
	.fnstart
.LFB3016:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r3, [r7, #4]
	adds	r2, r3, #4
	ldr	r3, [r7, #4]
	str	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r2, [r3]
	ldr	r3, [r7, #4]
	ldr	r3, [r3]
	adds	r3, r3, #4
	movs	r1, #0
	str	r1, [r3]
	ldr	r3, [r3]
	str	r3, [r2]
	ldr	r3, [r7, #4]
	mov	r0, r3
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.cantunwind
	.fnend
	.size	_ZN2cv3Mat5MStepC2Ev, .-_ZN2cv3Mat5MStepC2Ev
	.weak	_ZN2cv3Mat5MStepC1Ev
	.thumb_set _ZN2cv3Mat5MStepC1Ev,_ZN2cv3Mat5MStepC2Ev
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,4
	.text
	.align	2
	.global	_Z9grayScaleRN2cv3MatES1_
	.thumb
	.thumb_func
	.type	_Z9grayScaleRN2cv3MatES1_, %function
_Z9grayScaleRN2cv3MatES1_:
	.fnstart
.LFB3492:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #36
	add	r7, sp, #0
	str	r0, [r7, #12]
	str	r1, [r7, #8]
	movs	r3, #0
	str	r3, [r7, #16]
	b	.L29
.L32:
	movs	r3, #0
	str	r3, [r7, #20]
	b	.L30
.L31:
	ldr	r3, [r7, #12]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #16]
	lsls	r3, r3, #7
	lsls	r2, r3, #4
	subs	r0, r2, r3
	ldr	r2, [r7, #20]
	mov	r3, r2
	lsls	r3, r3, #1
	add	r3, r3, r2
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	fmsr	s15, r3	@ int
	fsitod	d7, s15
	fldd	d6, .L33
	fmuld	d6, d7, d6
	ldr	r3, [r7, #12]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #16]
	lsls	r3, r3, #7
	lsls	r2, r3, #4
	subs	r0, r2, r3
	ldr	r2, [r7, #20]
	mov	r3, r2
	lsls	r3, r3, #1
	add	r3, r3, r2
	add	r3, r3, r0
	adds	r3, r3, #1
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	fmsr	s15, r3	@ int
	fsitod	d7, s15
	fldd	d5, .L33+8
	fmuld	d7, d7, d5
	faddd	d6, d6, d7
	ldr	r3, [r7, #12]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #16]
	lsls	r3, r3, #7
	lsls	r2, r3, #4
	subs	r0, r2, r3
	ldr	r2, [r7, #20]
	mov	r3, r2
	lsls	r3, r3, #1
	add	r3, r3, r2
	add	r3, r3, r0
	adds	r3, r3, #2
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	fmsr	s15, r3	@ int
	fsitod	d7, s15
	fldd	d5, .L33+16
	fmuld	d7, d7, d5
	faddd	d7, d6, d7
	fstd	d7, [r7, #24]
	ldr	r3, [r7, #8]
	ldr	r2, [r3, #16]
	ldr	r3, [r7, #16]
	lsls	r3, r3, #7
	lsls	r1, r3, #2
	add	r1, r1, r3
	ldr	r3, [r7, #20]
	add	r3, r3, r1
	add	r3, r3, r2
	fldd	d7, [r7, #24]
	ftouizd	s15, d7
	fsts	s15, [r7, #4]	@ int
	ldrb	r2, [r7, #4]
	uxtb	r2, r2
	strb	r2, [r3]
	ldr	r3, [r7, #20]
	adds	r3, r3, #1
	str	r3, [r7, #20]
.L30:
	ldr	r3, [r7, #12]
	ldr	r2, [r3, #12]
	ldr	r3, [r7, #20]
	cmp	r2, r3
	bgt	.L31
	ldr	r3, [r7, #16]
	adds	r3, r3, #1
	str	r3, [r7, #16]
.L29:
	ldr	r3, [r7, #12]
	ldr	r2, [r3, #8]
	ldr	r3, [r7, #16]
	cmp	r2, r3
	bgt	.L32
	adds	r7, r7, #36
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
.L34:
	.align	3
.L33:
	.word	-1614907703
	.word	1069362970
	.word	962072674
	.word	1071827124
	.word	-446676599
	.word	1070801616
	.cantunwind
	.fnend
	.size	_Z9grayScaleRN2cv3MatES1_, .-_Z9grayScaleRN2cv3MatES1_
	.align	2
	.global	_Z9sobelCalcRN2cv3MatES1_
	.thumb
	.thumb_func
	.type	_Z9sobelCalcRN2cv3MatES1_, %function
_Z9sobelCalcRN2cv3MatES1_:
	.fnstart
.LFB3493:
	@ args = 0, pretend = 0, frame = 152
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	.save {r7, lr}
	.pad #152
	sub	sp, sp, #152
	.setfp r7, sp, #0
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	movw	r3, #:lower16:__stack_chk_guard
	movt	r3, #:upper16:__stack_chk_guard
	ldr	r3, [r3]
	str	r3, [r7, #148]
	add	r3, r7, #36
	ldr	r1, [r7, #4]
	mov	r0, r3
.LEHB2:
	bl	_ZNK2cv3Mat5cloneEv
.LEHE2:
	add	r3, r7, #92
	ldr	r1, [r7, #4]
	mov	r0, r3
.LEHB3:
	bl	_ZNK2cv3Mat5cloneEv
	movs	r3, #1
	str	r3, [r7, #12]
	b	.L36
.L39:
	movs	r3, #1
	str	r3, [r7, #16]
	b	.L37
.L38:
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #16]
	ldr	r3, [r7, #12]
	subs	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r1, r3, #2
	add	r1, r1, r3
	ldr	r3, [r7, #16]
	subs	r3, r3, #1
	add	r3, r3, r1
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #16]
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r1, r3, #2
	add	r1, r1, r3
	ldr	r3, [r7, #16]
	subs	r3, r3, #1
	add	r3, r3, r1
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	subs	r2, r0, r3
	ldr	r3, [r7, #4]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #12]
	subs	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r0, r3, #2
	add	r0, r0, r3
	ldr	r3, [r7, #16]
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	lsls	r3, r3, #1
	add	r2, r2, r3
	ldr	r3, [r7, #4]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r0, r3, #2
	add	r0, r0, r3
	ldr	r3, [r7, #16]
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	lsls	r3, r3, #1
	negs	r3, r3
	add	r2, r2, r3
	ldr	r3, [r7, #4]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #12]
	subs	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r0, r3, #2
	add	r0, r0, r3
	ldr	r3, [r7, #16]
	adds	r3, r3, #1
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	add	r2, r2, r3
	ldr	r3, [r7, #4]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r0, r3, #2
	add	r0, r0, r3
	ldr	r3, [r7, #16]
	adds	r3, r3, #1
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	subs	r3, r2, r3
	cmp	r3, #0
	it	lt
	rsblt	r3, r3, #0
	strh	r3, [r7, #10]	@ movhi
	ldrh	r3, [r7, #10]
	cmp	r3, #255
	it	cs
	movcs	r3, #255
	strh	r3, [r7, #10]	@ movhi
	ldr	r2, [r7, #52]
	ldr	r3, [r7, #12]
	lsls	r3, r3, #7
	lsls	r1, r3, #2
	add	r1, r1, r3
	ldr	r3, [r7, #16]
	add	r3, r3, r1
	add	r3, r3, r2
	ldrh	r2, [r7, #10]	@ movhi
	uxtb	r2, r2
	strb	r2, [r3]
	ldr	r3, [r7, #16]
	adds	r3, r3, #1
	str	r3, [r7, #16]
.L37:
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #12]
	ldr	r3, [r7, #16]
	cmp	r2, r3
	bgt	.L38
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	str	r3, [r7, #12]
.L36:
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #8]
	ldr	r3, [r7, #12]
	cmp	r2, r3
	bgt	.L39
	movs	r3, #1
	str	r3, [r7, #20]
	b	.L40
.L43:
	movs	r3, #1
	str	r3, [r7, #24]
	b	.L41
.L42:
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #16]
	ldr	r3, [r7, #20]
	subs	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r1, r3, #2
	add	r1, r1, r3
	ldr	r3, [r7, #24]
	subs	r3, r3, #1
	add	r3, r3, r1
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #16]
	ldr	r3, [r7, #20]
	subs	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r1, r3, #2
	add	r1, r1, r3
	ldr	r3, [r7, #24]
	adds	r3, r3, #1
	add	r3, r3, r1
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	subs	r2, r0, r3
	ldr	r3, [r7, #4]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #20]
	lsls	r3, r3, #7
	lsls	r0, r3, #2
	add	r0, r0, r3
	ldr	r3, [r7, #24]
	subs	r3, r3, #1
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	lsls	r3, r3, #1
	add	r2, r2, r3
	ldr	r3, [r7, #4]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #20]
	lsls	r3, r3, #7
	lsls	r0, r3, #2
	add	r0, r0, r3
	ldr	r3, [r7, #24]
	adds	r3, r3, #1
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	lsls	r3, r3, #1
	negs	r3, r3
	add	r2, r2, r3
	ldr	r3, [r7, #4]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #20]
	adds	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r0, r3, #2
	add	r0, r0, r3
	ldr	r3, [r7, #24]
	subs	r3, r3, #1
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	add	r2, r2, r3
	ldr	r3, [r7, #4]
	ldr	r1, [r3, #16]
	ldr	r3, [r7, #20]
	adds	r3, r3, #1
	lsls	r3, r3, #7
	lsls	r0, r3, #2
	add	r0, r0, r3
	ldr	r3, [r7, #24]
	adds	r3, r3, #1
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	subs	r3, r2, r3
	cmp	r3, #0
	it	lt
	rsblt	r3, r3, #0
	strh	r3, [r7, #10]	@ movhi
	ldrh	r3, [r7, #10]
	cmp	r3, #255
	it	cs
	movcs	r3, #255
	strh	r3, [r7, #10]	@ movhi
	ldr	r2, [r7, #108]
	ldr	r3, [r7, #20]
	lsls	r3, r3, #7
	lsls	r1, r3, #2
	add	r1, r1, r3
	ldr	r3, [r7, #24]
	add	r3, r3, r1
	add	r3, r3, r2
	ldrh	r2, [r7, #10]	@ movhi
	uxtb	r2, r2
	strb	r2, [r3]
	ldr	r3, [r7, #24]
	adds	r3, r3, #1
	str	r3, [r7, #24]
.L41:
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #12]
	ldr	r3, [r7, #24]
	cmp	r2, r3
	bgt	.L42
	ldr	r3, [r7, #20]
	adds	r3, r3, #1
	str	r3, [r7, #20]
.L40:
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #8]
	ldr	r3, [r7, #20]
	cmp	r2, r3
	bgt	.L43
	movs	r3, #1
	str	r3, [r7, #28]
	b	.L44
.L47:
	movs	r3, #1
	str	r3, [r7, #32]
	b	.L45
.L46:
	ldr	r2, [r7, #52]
	ldr	r3, [r7, #28]
	lsls	r3, r3, #7
	lsls	r1, r3, #2
	add	r1, r1, r3
	ldr	r3, [r7, #32]
	add	r3, r3, r1
	add	r3, r3, r2
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r2, r3
	ldr	r1, [r7, #108]
	ldr	r3, [r7, #28]
	lsls	r3, r3, #7
	lsls	r0, r3, #2
	add	r0, r0, r3
	ldr	r3, [r7, #32]
	add	r3, r3, r0
	add	r3, r3, r1
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxth	r3, r3
	add	r3, r3, r2
	strh	r3, [r7, #10]	@ movhi
	ldrh	r3, [r7, #10]
	cmp	r3, #255
	it	cs
	movcs	r3, #255
	strh	r3, [r7, #10]	@ movhi
	ldr	r3, [r7]
	ldr	r2, [r3, #16]
	ldr	r3, [r7, #28]
	lsls	r3, r3, #7
	lsls	r1, r3, #2
	add	r1, r1, r3
	ldr	r3, [r7, #32]
	add	r3, r3, r1
	add	r3, r3, r2
	ldrh	r2, [r7, #10]	@ movhi
	uxtb	r2, r2
	strb	r2, [r3]
	ldr	r3, [r7, #32]
	adds	r3, r3, #1
	str	r3, [r7, #32]
.L45:
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #12]
	ldr	r3, [r7, #32]
	cmp	r2, r3
	bgt	.L46
	ldr	r3, [r7, #28]
	adds	r3, r3, #1
	str	r3, [r7, #28]
.L44:
	ldr	r3, [r7, #4]
	ldr	r2, [r3, #8]
	ldr	r3, [r7, #28]
	cmp	r2, r3
	bgt	.L47
	add	r3, r7, #92
	mov	r0, r3
	bl	_ZN2cv3MatD1Ev
.LEHE3:
	add	r3, r7, #36
	mov	r0, r3
.LEHB4:
	bl	_ZN2cv3MatD1Ev
.LEHE4:
	movw	r3, #:lower16:__stack_chk_guard
	movt	r3, #:upper16:__stack_chk_guard
	ldr	r2, [r7, #148]
	ldr	r3, [r3]
	cmp	r2, r3
	beq	.L49
	b	.L51
.L50:
	add	r3, r7, #36
	mov	r0, r3
	bl	_ZN2cv3MatD1Ev
.LEHB5:
	bl	__cxa_end_cleanup
.LEHE5:
.L51:
	bl	__stack_chk_fail
.L49:
	adds	r7, r7, #152
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.personality	__gxx_personality_v0
	.handlerdata
.LLSDA3493:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3493-.LLSDACSB3493
.LLSDACSB3493:
	.uleb128 .LEHB2-.LFB3493
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB3-.LFB3493
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L50-.LFB3493
	.uleb128 0
	.uleb128 .LEHB4-.LFB3493
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB5-.LFB3493
	.uleb128 .LEHE5-.LEHB5
	.uleb128 0
	.uleb128 0
.LLSDACSE3493:
	.text
	.fnend
	.size	_Z9sobelCalcRN2cv3MatES1_, .-_Z9sobelCalcRN2cv3MatES1_
	.align	2
	.thumb
	.thumb_func
	.type	_Z41__static_initialization_and_destruction_0ii, %function
_Z41__static_initialization_and_destruction_0ii:
	.fnstart
.LFB3856:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	ldr	r3, [r7, #4]
	cmp	r3, #1
	bne	.L52
	ldr	r3, [r7]
	movw	r2, #65535
	cmp	r3, r2
	bne	.L52
	movw	r0, #:lower16:_ZStL8__ioinit
	movt	r0, #:upper16:_ZStL8__ioinit
	bl	_ZNSt8ios_base4InitC1Ev
	movw	r2, #:lower16:__dso_handle
	movt	r2, #:upper16:__dso_handle
	movw	r1, #:lower16:_ZNSt8ios_base4InitD1Ev
	movt	r1, #:upper16:_ZNSt8ios_base4InitD1Ev
	movw	r0, #:lower16:_ZStL8__ioinit
	movt	r0, #:upper16:_ZStL8__ioinit
	bl	__aeabi_atexit
.L52:
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.cantunwind
	.fnend
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.align	2
	.thumb
	.thumb_func
	.type	_GLOBAL__sub_I__Z9grayScaleRN2cv3MatES1_, %function
_GLOBAL__sub_I__Z9grayScaleRN2cv3MatES1_:
	.fnstart
.LFB3857:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	movw	r1, #65535
	movs	r0, #1
	bl	_Z41__static_initialization_and_destruction_0ii
	pop	{r7, pc}
	.cantunwind
	.fnend
	.size	_GLOBAL__sub_I__Z9grayScaleRN2cv3MatES1_, .-_GLOBAL__sub_I__Z9grayScaleRN2cv3MatES1_
	.section	.init_array,"aw"
	.align	2
	.word	_GLOBAL__sub_I__Z9grayScaleRN2cv3MatES1_
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu/Linaro 4.9.1-16ubuntu6) 4.9.1"
	.section	.note.GNU-stack,"",%progbits
