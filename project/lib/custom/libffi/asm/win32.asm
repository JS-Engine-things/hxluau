	.686P
	.MODEL	FLAT
	OPTION	PROLOGUE:NONE
	OPTION	EPILOGUE:NONE

FFI_TRAMPOLINE_SIZE	equ	16

X86_RET_TYPE_MASK	equ	15
X86_RET_POP_SHIFT	equ	4

R_EAX			equ	0
R_EDX			equ	1
R_ECX			equ	2

; HAVE_FASTCALL: closure_FS = 40 + 4, closure_CF = 0
closure_FS		equ	(40 + 4)
closure_CF		equ	0

raw_closure_S_FS	equ	(16 + 16 + 12)	; 44
raw_closure_T_FS	equ	(16 + 16 + 8)	; 40

	EXTRN	@ffi_closure_inner@8:PROC

	PUBLIC	@ffi_call_i386@8
	PUBLIC	ffi_go_closure_EAX
	PUBLIC	ffi_go_closure_ECX
	PUBLIC	ffi_closure_i386
	PUBLIC	ffi_go_closure_STDCALL
	PUBLIC	ffi_closure_REGISTER
	PUBLIC	ffi_closure_STDCALL
	PUBLIC	ffi_closure_raw_SYSV
	PUBLIC	ffi_closure_raw_THISCALL

FFI_CLOSURE_SAVE_REGS MACRO
	mov	[esp + closure_CF + 16 + R_EAX*4], eax
	mov	[esp + closure_CF + 16 + R_EDX*4], edx
	mov	[esp + closure_CF + 16 + R_ECX*4], ecx
ENDM

FFI_CLOSURE_COPY_TRAMP_DATA MACRO
	mov	edx, [eax + FFI_TRAMPOLINE_SIZE]	; copy cif
	mov	ecx, [eax + FFI_TRAMPOLINE_SIZE + 4]	; copy fun
	mov	eax, [eax + FFI_TRAMPOLINE_SIZE + 8]	; copy user_data
	mov	[esp + closure_CF + 28], edx
	mov	[esp + closure_CF + 32], ecx
	mov	[esp + closure_CF + 36], eax
ENDM

FFI_CLOSURE_PREP_CALL MACRO
	mov	ecx, esp			; load closure_data
	lea	edx, [esp + closure_FS + 4]	; load incoming stack
ENDM

FFI_CLOSURE_CALL_INNER MACRO
	call	@ffi_closure_inner@8
ENDM

FFI_CLOSURE_MASK_AND_JUMP MACRO TBL
	and	eax, X86_RET_TYPE_MASK
	lea	edx, [TBL + eax*8]
	mov	eax, [esp + closure_CF]		; optimistic load
	jmp	edx
ENDM

	.CODE
	ALIGN	16
@ffi_call_i386@8 PROC
	mov	eax, [esp]			; move the return address
	mov	[ecx], ebp			; store ebp into local frame
	mov	[ecx + 4], eax			; store retaddr into local frame
	mov	ebp, ecx			; new frame based off ebp

	mov	esp, edx			; set outgoing argument stack
	mov	eax, [ebp + 20 + R_EAX*4]	; set register arguments
	mov	edx, [ebp + 20 + R_EDX*4]
	mov	ecx, [ebp + 20 + R_ECX*4]

	call	DWORD PTR [ebp + 8]

	mov	ecx, [ebp + 12]			; load return type code
	mov	[ebp + 8], ebx			; preserve ebx

	and	ecx, X86_RET_TYPE_MASK
	lea	ebx, [store_table + ecx*8]
	mov	ecx, [ebp + 16]			; load result address
	jmp	ebx

	ALIGN	8
store_table:
	; 0: X86_RET_FLOAT
	fstp	DWORD PTR [ecx]
	jmp	SHORT e1
	ALIGN	8
	; 1: X86_RET_DOUBLE
	fstp	QWORD PTR [ecx]
	jmp	SHORT e1
	ALIGN	8
	; 2: X86_RET_LDOUBLE
	fstp	QWORD PTR [ecx]
	jmp	SHORT e1
	ALIGN	8
	; 3: X86_RET_SINT8
	movsx	eax, al
	mov	[ecx], eax
	jmp	SHORT e1
	ALIGN	8
	; 4: X86_RET_SINT16
	movsx	eax, ax
	mov	[ecx], eax
	jmp	SHORT e1
	ALIGN	8
	; 5: X86_RET_UINT8
	movzx	eax, al
	mov	[ecx], eax
	jmp	SHORT e1
	ALIGN	8
	; 6: X86_RET_UINT16
	movzx	eax, ax
	mov	[ecx], eax
	jmp	SHORT e1
	ALIGN	8
	; 7: X86_RET_INT64
	mov	[ecx + 4], edx
	; fallthru
	ALIGN	8
	; 8: X86_RET_INT32
	mov	[ecx], eax
	; fallthru
	ALIGN	8
	; 9: X86_RET_VOID
e1:
	mov	ebx, [ebp + 8]
	mov	esp, ebp
	pop	ebp
	ret
	ALIGN	8
	; 10: X86_RET_STRUCTPOP
	jmp	SHORT e1
	ALIGN	8
	; 11: X86_RET_STRUCTARG
	jmp	SHORT e1
	ALIGN	8
	; 12: X86_RET_STRUCT_1B
	mov	[ecx], al
	jmp	SHORT e1
	ALIGN	8
	; 13: X86_RET_STRUCT_2B
	mov	[ecx], ax
	jmp	SHORT e1
	ALIGN	8
	; 14: X86_RET_UNUSED14
	ud2
	ALIGN	8
	; 15: X86_RET_UNUSED15
	ud2
@ffi_call_i386@8 ENDP

	ALIGN	16
ffi_go_closure_EAX PROC C
	sub	esp, closure_FS
	FFI_CLOSURE_SAVE_REGS
	mov	edx, [eax + 4]			; copy cif
	mov	ecx, [eax + 8]			; copy fun
	mov	[esp + closure_CF + 28], edx
	mov	[esp + closure_CF + 32], ecx
	mov	[esp + closure_CF + 36], eax	; closure is user_data
	jmp	do_closure_i386
ffi_go_closure_EAX ENDP

	ALIGN	16
ffi_go_closure_ECX PROC C
	sub	esp, closure_FS
	FFI_CLOSURE_SAVE_REGS
	mov	edx, [ecx + 4]			; copy cif
	mov	eax, [ecx + 8]			; copy fun
	mov	[esp + closure_CF + 28], edx
	mov	[esp + closure_CF + 32], eax
	mov	[esp + closure_CF + 36], ecx	; closure is user_data
	jmp	do_closure_i386
ffi_go_closure_ECX ENDP

	ALIGN	16
ffi_closure_i386 PROC C
	sub	esp, closure_FS
	FFI_CLOSURE_SAVE_REGS
	FFI_CLOSURE_COPY_TRAMP_DATA

do_closure_i386::
	FFI_CLOSURE_PREP_CALL
	FFI_CLOSURE_CALL_INNER
	FFI_CLOSURE_MASK_AND_JUMP load_table2

	ALIGN	8
load_table2:
	; 0: X86_RET_FLOAT
	fld	DWORD PTR [esp + closure_CF]
	jmp	SHORT e2
	ALIGN	8
	; 1: X86_RET_DOUBLE
	fld	QWORD PTR [esp + closure_CF]
	jmp	SHORT e2
	ALIGN	8
	; 2: X86_RET_LDOUBLE
	fld	QWORD PTR [esp + closure_CF]
	jmp	SHORT e2
	ALIGN	8
	; 3: X86_RET_SINT8
	movsx	eax, al
	jmp	SHORT e2
	ALIGN	8
	; 4: X86_RET_SINT16
	movsx	eax, ax
	jmp	SHORT e2
	ALIGN	8
	; 5: X86_RET_UINT8
	movzx	eax, al
	jmp	SHORT e2
	ALIGN	8
	; 6: X86_RET_UINT16
	movzx	eax, ax
	jmp	SHORT e2
	ALIGN	8
	; 7: X86_RET_INT64
	mov	edx, [esp + closure_CF + 4]
	jmp	SHORT e2
	ALIGN	8
	; 8: X86_RET_INT32
	nop
	; fallthru
	ALIGN	8
	; 9: X86_RET_VOID
e2:
	add	esp, closure_FS
	ret
	ALIGN	8
	; 10: X86_RET_STRUCTPOP
	add	esp, closure_FS
	ret	4
	ALIGN	8
	; 11: X86_RET_STRUCTARG
	jmp	SHORT e2
	ALIGN	8
	; 12: X86_RET_STRUCT_1B
	movzx	eax, al
	jmp	SHORT e2
	ALIGN	8
	; 13: X86_RET_STRUCT_2B
	movzx	eax, ax
	jmp	SHORT e2
	ALIGN	8
	; 14: X86_RET_UNUSED14
	ud2
	ALIGN	8
	; 15: X86_RET_UNUSED15
	ud2
ffi_closure_i386 ENDP

	ALIGN	16
ffi_go_closure_STDCALL PROC C
	sub	esp, closure_FS
	FFI_CLOSURE_SAVE_REGS
	mov	edx, [ecx + 4]			; copy cif
	mov	eax, [ecx + 8]			; copy fun
	mov	[esp + closure_CF + 28], edx
	mov	[esp + closure_CF + 32], eax
	mov	[esp + closure_CF + 36], ecx	; closure is user_data
	jmp	do_closure_STDCALL
ffi_go_closure_STDCALL ENDP

	ALIGN	16
ffi_closure_REGISTER PROC C
	sub	esp, closure_FS - 4
	FFI_CLOSURE_SAVE_REGS
	mov	eax, [esp + closure_FS - 4]	; load closure
	jmp	do_closure_REGISTER
ffi_closure_REGISTER ENDP

	ALIGN	16
ffi_closure_STDCALL PROC C
	sub	esp, closure_FS
	FFI_CLOSURE_SAVE_REGS

do_closure_REGISTER::
	FFI_CLOSURE_COPY_TRAMP_DATA

do_closure_STDCALL::
	FFI_CLOSURE_PREP_CALL
	FFI_CLOSURE_CALL_INNER

	mov	ecx, eax
	shr	ecx, X86_RET_POP_SHIFT		; isolate pop count
	lea	ecx, [esp + closure_FS + ecx]	; compute popped esp
	mov	edx, [esp + closure_FS]		; move return address
	mov	[ecx], edx

	FFI_CLOSURE_MASK_AND_JUMP load_table3

	ALIGN	8
load_table3:
	; 0: X86_RET_FLOAT
	fld	DWORD PTR [esp + closure_CF]
	mov	esp, ecx
	ret
	ALIGN	8
	; 1: X86_RET_DOUBLE
	fld	QWORD PTR [esp + closure_CF]
	mov	esp, ecx
	ret
	ALIGN	8
	; 2: X86_RET_LDOUBLE
	fld	QWORD PTR [esp + closure_CF]
	mov	esp, ecx
	ret
	ALIGN	8
	; 3: X86_RET_SINT8
	movsx	eax, al
	mov	esp, ecx
	ret
	ALIGN	8
	; 4: X86_RET_SINT16
	movsx	eax, ax
	mov	esp, ecx
	ret
	ALIGN	8
	; 5: X86_RET_UINT8
	movzx	eax, al
	mov	esp, ecx
	ret
	ALIGN	8
	; 6: X86_RET_UINT16
	movzx	eax, ax
	mov	esp, ecx
	ret
	ALIGN	8
	; 7: X86_RET_INT64
	mov	edx, [esp + closure_CF + 4]
	mov	esp, ecx
	ret
	ALIGN	8
	; 8: X86_RET_INT32
	mov	esp, ecx
	ret
	ALIGN	8
	; 9: X86_RET_VOID
	mov	esp, ecx
	ret
	ALIGN	8
	; 10: X86_RET_STRUCTPOP
	mov	esp, ecx
	ret
	ALIGN	8
	; 11: X86_RET_STRUCTARG
	mov	esp, ecx
	ret
	ALIGN	8
	; 12: X86_RET_STRUCT_1B
	movzx	eax, al
	mov	esp, ecx
	ret
	ALIGN	8
	; 13: X86_RET_STRUCT_2B
	movzx	eax, ax
	mov	esp, ecx
	ret
	ALIGN	8
	; 14: X86_RET_UNUSED14
	ud2
	ALIGN	8
	; 15: X86_RET_UNUSED15
	ud2
ffi_closure_STDCALL ENDP

	ALIGN	16
ffi_closure_raw_SYSV PROC C
	sub	esp, raw_closure_S_FS
	mov	[esp + raw_closure_S_FS - 4], ebx

	mov	edx, [eax + FFI_TRAMPOLINE_SIZE + 8]	; load cl->user_data
	mov	[esp + 12], edx
	lea	edx, [esp + raw_closure_S_FS + 4]	; load raw_args
	mov	[esp + 8], edx
	lea	edx, [esp + 16]				; load &res
	mov	[esp + 4], edx
	mov	ebx, [eax + FFI_TRAMPOLINE_SIZE]	; load cl->cif
	mov	[esp], ebx
	call	DWORD PTR [eax + FFI_TRAMPOLINE_SIZE + 4]	; call cl->fun

	mov	eax, [ebx + 20]				; load cif->flags
	and	eax, X86_RET_TYPE_MASK
	lea	ecx, [load_table4 + eax*8]
	mov	ebx, [esp + raw_closure_S_FS - 4]
	mov	eax, [esp + 16]				; optimistic load
	jmp	ecx

	ALIGN	8
load_table4:
	; 0: X86_RET_FLOAT
	fld	DWORD PTR [esp + 16]
	jmp	SHORT e4
	ALIGN	8
	; 1: X86_RET_DOUBLE
	fld	QWORD PTR [esp + 16]
	jmp	SHORT e4
	ALIGN	8
	; 2: X86_RET_LDOUBLE
	fld	QWORD PTR [esp + 16]
	jmp	SHORT e4
	ALIGN	8
	; 3: X86_RET_SINT8
	movsx	eax, al
	jmp	SHORT e4
	ALIGN	8
	; 4: X86_RET_SINT16
	movsx	eax, ax
	jmp	SHORT e4
	ALIGN	8
	; 5: X86_RET_UINT8
	movzx	eax, al
	jmp	SHORT e4
	ALIGN	8
	; 6: X86_RET_UINT16
	movzx	eax, ax
	jmp	SHORT e4
	ALIGN	8
	; 7: X86_RET_INT64
	mov	edx, [esp + 16 + 4]
	jmp	SHORT e4
	ALIGN	8
	; 8: X86_RET_INT32
	nop
	; fallthru
	ALIGN	8
	; 9: X86_RET_VOID
e4:
	add	esp, raw_closure_S_FS
	ret
	ALIGN	8
	; 10: X86_RET_STRUCTPOP
	add	esp, raw_closure_S_FS
	ret	4
	ALIGN	8
	; 11: X86_RET_STRUCTARG
	jmp	SHORT e4
	ALIGN	8
	; 12: X86_RET_STRUCT_1B
	movzx	eax, al
	jmp	SHORT e4
	ALIGN	8
	; 13: X86_RET_STRUCT_2B
	movzx	eax, ax
	jmp	SHORT e4
	ALIGN	8
	; 14: X86_RET_UNUSED14
	ud2
	ALIGN	8
	; 15: X86_RET_UNUSED15
	ud2
ffi_closure_raw_SYSV ENDP

	ALIGN	16
ffi_closure_raw_THISCALL PROC C
	pop	edx
	push	ecx
	push	edx
	sub	esp, raw_closure_T_FS
	mov	[esp + raw_closure_T_FS - 4], ebx

	mov	edx, [eax + FFI_TRAMPOLINE_SIZE + 8]	; load cl->user_data
	mov	[esp + 12], edx
	lea	edx, [esp + raw_closure_T_FS + 4]	; load raw_args
	mov	[esp + 8], edx
	lea	edx, [esp + 16]				; load &res
	mov	[esp + 4], edx
	mov	ebx, [eax + FFI_TRAMPOLINE_SIZE]	; load cl->cif
	mov	[esp], ebx
	call	DWORD PTR [eax + FFI_TRAMPOLINE_SIZE + 4]	; call cl->fun

	mov	eax, [ebx + 20]				; load cif->flags
	and	eax, X86_RET_TYPE_MASK
	lea	ecx, [load_table5 + eax*8]
	mov	ebx, [esp + raw_closure_T_FS - 4]
	mov	eax, [esp + 16]				; optimistic load
	jmp	ecx

	ALIGN	8
load_table5:
	; 0: X86_RET_FLOAT
	fld	DWORD PTR [esp + 16]
	jmp	SHORT e5
	ALIGN	8
	; 1: X86_RET_DOUBLE
	fld	QWORD PTR [esp + 16]
	jmp	SHORT e5
	ALIGN	8
	; 2: X86_RET_LDOUBLE
	fld	QWORD PTR [esp + 16]
	jmp	SHORT e5
	ALIGN	8
	; 3: X86_RET_SINT8
	movsx	eax, al
	jmp	SHORT e5
	ALIGN	8
	; 4: X86_RET_SINT16
	movsx	eax, ax
	jmp	SHORT e5
	ALIGN	8
	; 5: X86_RET_UINT8
	movzx	eax, al
	jmp	SHORT e5
	ALIGN	8
	; 6: X86_RET_UINT16
	movzx	eax, ax
	jmp	SHORT e5
	ALIGN	8
	; 7: X86_RET_INT64
	mov	edx, [esp + 16 + 4]
	jmp	SHORT e5
	ALIGN	8
	; 8: X86_RET_INT32
	nop
	; fallthru
	ALIGN	8
	; 9: X86_RET_VOID
e5:
	add	esp, raw_closure_T_FS
	ret	4
	ALIGN	8
	; 10: X86_RET_STRUCTPOP
	add	esp, raw_closure_T_FS
	ret	8
	ALIGN	8
	; 11: X86_RET_STRUCTARG
	jmp	SHORT e5
	ALIGN	8
	; 12: X86_RET_STRUCT_1B
	movzx	eax, al
	jmp	SHORT e5
	ALIGN	8
	; 13: X86_RET_STRUCT_2B
	movzx	eax, ax
	jmp	SHORT e5
	ALIGN	8
	; 14: X86_RET_UNUSED14
	ud2
	ALIGN	8
	; 15: X86_RET_UNUSED15
	ud2
ffi_closure_raw_THISCALL ENDP

	END
