OPTION PROLOGUE:NONE, EPILOGUE:NONE
.MODEL FLAT

; Constants from ffi.h / internal.h
FFI_TRAMPOLINE_SIZE    equ 12
X86_RET_TYPE_MASK      equ 15
X86_RET_POP_SHIFT      equ 4
closure_FS             equ 44
closure_CF             equ 0

X86_RET_FLOAT          equ 0
X86_RET_DOUBLE         equ 1
X86_RET_LDOUBLE        equ 2
X86_RET_SINT8          equ 3
X86_RET_SINT16         equ 4
X86_RET_UINT8          equ 5
X86_RET_UINT16         equ 6
X86_RET_INT64          equ 7
X86_RET_INT32          equ 8
X86_RET_VOID           equ 9
X86_RET_STRUCTPOP      equ 10
X86_RET_STRUCTARG      equ 11
X86_RET_STRUCT_1B      equ 12
X86_RET_STRUCT_2B      equ 13
X86_RET_UNUSED14       equ 14
X86_RET_UNUSED15       equ 15

R_EAX                  equ 0
R_EDX                  equ 1
R_ECX                  equ 2

X86_TRAMP_MAP_SIZE     equ 4096
X86_TRAMP_SIZE         equ 32
raw_closure_S_FS       equ 44
raw_closure_T_FS       equ 40

EXTERN ffi_closure_inner : PROC

PUBLIC ffi_call_i386
PUBLIC ffi_go_closure_EAX
PUBLIC ffi_go_closure_ECX
PUBLIC ffi_closure_i386
PUBLIC ffi_go_closure_STDCALL
PUBLIC ffi_closure_STDCALL
PUBLIC ffi_closure_REGISTER
PUBLIC ffi_closure_raw_SYSV
PUBLIC ffi_closure_raw_THISCALL
PUBLIC trampoline_code_table

; =========================================================================
; ffi_call_i386(struct call_frame *frame, char *argp) __fastcall
; ecx = frame, edx = argp
; =========================================================================
ffi_call_i386 PROC
    mov     eax, [esp]
    mov     [ecx+0], ebp
    mov     [ecx+4], eax
    mov     ebp, ecx
    mov     esp, edx
    mov     eax, [ebp+20+R_EAX*4]
    mov     edx, [ebp+20+R_EDX*4]
    mov     ecx, [ebp+20+R_ECX*4]
    call    [ebp+8]
    mov     ecx, [ebp+12]
    mov     [ebp+8], ebx
    and     ecx, X86_RET_TYPE_MASK
    lea     ebx, [store_table + ecx*8]
    mov     ecx, [ebp+16]
    jmp     ebx

ALIGN 8
store_table:
ALIGN 8
    fstp    dword ptr [ecx]
    jmp     e1
ALIGN 8
    fstp    qword ptr [ecx]
    jmp     e1
ALIGN 8
    fstp    tbyte ptr [ecx]
    jmp     e1
ALIGN 8
    movsx   eax, al
    mov     [ecx], eax
    jmp     e1
ALIGN 8
    movsx   eax, ax
    mov     [ecx], eax
    jmp     e1
ALIGN 8
    movzx   eax, al
    mov     [ecx], eax
    jmp     e1
ALIGN 8
    movzx   eax, ax
    mov     [ecx], eax
    jmp     e1
ALIGN 8
    mov     [ecx+4], edx
    mov     [ecx], eax
    jmp     e1
ALIGN 8
    mov     [ecx], eax
    jmp     e1
ALIGN 8
e1:
    mov     ebx, [ebp+8]
    mov     esp, ebp
    pop     ebp
    ret

ALIGN 8
    jmp     e1
ALIGN 8
    jmp     e1
ALIGN 8
    mov     [ecx], al
    jmp     e1
ALIGN 8
    mov     [ecx], ax
    jmp     e1

ALIGN 8
    ud2
ALIGN 8
    ud2
ffi_call_i386 ENDP

; =========================================================================
; ffi_go_closure_EAX
; =========================================================================
ffi_go_closure_EAX PROC
    sub     esp, closure_FS
    mov     [esp+16+R_EAX*4], eax
    mov     [esp+16+R_EDX*4], edx
    mov     [esp+16+R_ECX*4], ecx
    mov     edx, [eax+4]
    mov     ecx, [eax+8]
    mov     [esp+28], edx
    mov     [esp+32], ecx
    mov     [esp+36], eax
    jmp     do_closure_i386
ffi_go_closure_EAX ENDP

; =========================================================================
; ffi_go_closure_ECX
; =========================================================================
ffi_go_closure_ECX PROC
    sub     esp, closure_FS
    mov     [esp+16+R_EAX*4], eax
    mov     [esp+16+R_EDX*4], edx
    mov     [esp+16+R_ECX*4], ecx
    mov     edx, [ecx+4]
    mov     eax, [ecx+8]
    mov     [esp+28], edx
    mov     [esp+32], eax
    mov     [esp+36], ecx
    jmp     do_closure_i386
ffi_go_closure_ECX ENDP

; =========================================================================
; ffi_closure_i386
; =========================================================================
ffi_closure_i386 PROC
    sub     esp, closure_FS
    mov     [esp+16+R_EAX*4], eax
    mov     [esp+16+R_EDX*4], edx
    mov     [esp+16+R_ECX*4], ecx
    mov     edx, [eax+FFI_TRAMPOLINE_SIZE]
    mov     ecx, [eax+FFI_TRAMPOLINE_SIZE+4]
    mov     eax, [eax+FFI_TRAMPOLINE_SIZE+8]
    mov     [esp+28], edx
    mov     [esp+32], ecx
    mov     [esp+36], eax

do_closure_i386:
    mov     ecx, esp
    lea     edx, [esp+closure_FS+4]
    call    ffi_closure_inner
    and     eax, X86_RET_TYPE_MASK
    mov     eax, [esp+0]
    lea     edx, [load_table2 + eax*8]
    jmp     edx

ALIGN 8
load_table2:
ALIGN 8
    fld     dword ptr [esp+0]
    jmp     e2
ALIGN 8
    fld     qword ptr [esp+0]
    jmp     e2
ALIGN 8
    fld     tbyte ptr [esp+0]
    jmp     e2
ALIGN 8
    movsx   eax, al
    jmp     e2
ALIGN 8
    movsx   eax, ax
    jmp     e2
ALIGN 8
    movzx   eax, al
    jmp     e2
ALIGN 8
    movzx   eax, ax
    jmp     e2
ALIGN 8
    mov     edx, [esp+4]
    jmp     e2
ALIGN 8
    jmp     e2
ALIGN 8
e2:
    add     esp, closure_FS
    ret

ALIGN 8
    add     esp, closure_FS
    ret     4
ALIGN 8
    jmp     e2
ALIGN 8
    movzx   eax, al
    jmp     e2
ALIGN 8
    movzx   eax, ax
    jmp     e2

ALIGN 8
    ud2
ALIGN 8
    ud2
ffi_closure_i386 ENDP

; =========================================================================
; ffi_go_closure_STDCALL
; =========================================================================
ffi_go_closure_STDCALL PROC
    sub     esp, closure_FS
    mov     [esp+16+R_EAX*4], eax
    mov     [esp+16+R_EDX*4], edx
    mov     [esp+16+R_ECX*4], ecx
    mov     edx, [ecx+4]
    mov     eax, [ecx+8]
    mov     [esp+28], edx
    mov     [esp+32], eax
    mov     [esp+36], ecx
    jmp     do_closure_STDCALL
ffi_go_closure_STDCALL ENDP

; =========================================================================
; ffi_closure_REGISTER
; =========================================================================
ffi_closure_REGISTER PROC
    sub     esp, closure_FS-4
    mov     [esp+16+R_EAX*4], eax
    mov     [esp+16+R_EDX*4], edx
    mov     [esp+16+R_ECX*4], ecx
    mov     eax, [esp+closure_FS-4]
    jmp     do_closure_REGISTER
ffi_closure_REGISTER ENDP

; =========================================================================
; ffi_closure_STDCALL
; =========================================================================
ffi_closure_STDCALL PROC
    sub     esp, closure_FS
    mov     [esp+16+R_EAX*4], eax
    mov     [esp+16+R_EDX*4], edx
    mov     [esp+16+R_ECX*4], ecx

do_closure_REGISTER:
    mov     edx, [eax+FFI_TRAMPOLINE_SIZE]
    mov     ecx, [eax+FFI_TRAMPOLINE_SIZE+4]
    mov     eax, [eax+FFI_TRAMPOLINE_SIZE+8]
    mov     [esp+28], edx
    mov     [esp+32], ecx
    mov     [esp+36], eax

do_closure_STDCALL:
    mov     ecx, esp
    lea     edx, [esp+closure_FS+4]
    call    ffi_closure_inner

    mov     ecx, eax
    shr     ecx, X86_RET_POP_SHIFT
    lea     ecx, [esp+closure_FS+ecx]
    mov     edx, [esp+closure_FS]
    mov     [ecx], edx

    and     eax, X86_RET_TYPE_MASK
    mov     eax, [esp+0]
    lea     edx, [load_table3 + eax*8]
    jmp     edx

ALIGN 8
load_table3:
ALIGN 8
    fld     dword ptr [esp+0]
    mov     esp, ecx
    ret
ALIGN 8
    fld     qword ptr [esp+0]
    mov     esp, ecx
    ret
ALIGN 8
    fld     tbyte ptr [esp+0]
    mov     esp, ecx
    ret
ALIGN 8
    movsx   eax, al
    mov     esp, ecx
    ret
ALIGN 8
    movsx   eax, ax
    mov     esp, ecx
    ret
ALIGN 8
    movzx   eax, al
    mov     esp, ecx
    ret
ALIGN 8
    movzx   eax, ax
    mov     esp, ecx
    ret
ALIGN 8
    mov     edx, [esp+4]
    mov     esp, ecx
    ret
ALIGN 8
    mov     esp, ecx
    ret
ALIGN 8
    mov     esp, ecx
    ret
ALIGN 8
    mov     esp, ecx
    ret
ALIGN 8
    mov     esp, ecx
    ret
ALIGN 8
    movzx   eax, al
    mov     esp, ecx
    ret
ALIGN 8
    movzx   eax, ax
    mov     esp, ecx
    ret

ALIGN 8
    ud2
ALIGN 8
    ud2
ffi_closure_STDCALL ENDP

; =========================================================================
; ffi_closure_raw_SYSV
; =========================================================================
ffi_closure_raw_SYSV PROC
    sub     esp, raw_closure_S_FS
    mov     [esp+raw_closure_S_FS-4], ebx

    mov     edx, [eax+FFI_TRAMPOLINE_SIZE+8]
    mov     [esp+12], edx
    lea     edx, [esp+raw_closure_S_FS+4]
    mov     [esp+8], edx
    lea     edx, [esp+16]
    mov     [esp+4], edx
    mov     ebx, [eax+FFI_TRAMPOLINE_SIZE]
    mov     [esp], ebx
    call    [eax+FFI_TRAMPOLINE_SIZE+4]

    mov     eax, [ebx+20]
    and     eax, X86_RET_TYPE_MASK
    lea     ecx, [load_table4 + eax*8]
    mov     ebx, [esp+raw_closure_S_FS-4]
    mov     eax, [esp+16]
    jmp     ecx

ALIGN 8
load_table4:
ALIGN 8
    fld     dword ptr [esp+16]
    jmp     e4
ALIGN 8
    fld     qword ptr [esp+16]
    jmp     e4
ALIGN 8
    fld     tbyte ptr [esp+16]
    jmp     e4
ALIGN 8
    movsx   eax, al
    jmp     e4
ALIGN 8
    movsx   eax, ax
    jmp     e4
ALIGN 8
    movzx   eax, al
    jmp     e4
ALIGN 8
    movzx   eax, ax
    jmp     e4
ALIGN 8
    mov     edx, [esp+20]
    jmp     e4
ALIGN 8
    jmp     e4
ALIGN 8
e4:
    add     esp, raw_closure_S_FS
    ret

ALIGN 8
    add     esp, raw_closure_S_FS
    ret     4
ALIGN 8
    jmp     e4
ALIGN 8
    movzx   eax, al
    jmp     e4
ALIGN 8
    movzx   eax, ax
    jmp     e4

ALIGN 8
    ud2
ALIGN 8
    ud2
ffi_closure_raw_SYSV ENDP

; =========================================================================
; ffi_closure_raw_THISCALL
; =========================================================================
ffi_closure_raw_THISCALL PROC
    pop     edx
    push    ecx
    push    edx
    sub     esp, raw_closure_T_FS
    mov     [esp+raw_closure_T_FS-4], ebx

    mov     edx, [eax+FFI_TRAMPOLINE_SIZE+8]
    mov     [esp+12], edx
    lea     edx, [esp+raw_closure_T_FS+4]
    mov     [esp+8], edx
    lea     edx, [esp+16]
    mov     [esp+4], edx
    mov     ebx, [eax+FFI_TRAMPOLINE_SIZE]
    mov     [esp], ebx
    call    [eax+FFI_TRAMPOLINE_SIZE+4]

    mov     eax, [ebx+20]
    and     eax, X86_RET_TYPE_MASK
    lea     ecx, [load_table5 + eax*8]
    mov     ebx, [esp+raw_closure_T_FS-4]
    mov     eax, [esp+16]
    jmp     ecx

ALIGN 8
load_table5:
ALIGN 8
    fld     dword ptr [esp+16]
    jmp     e5
ALIGN 8
    fld     qword ptr [esp+16]
    jmp     e5
ALIGN 8
    fld     tbyte ptr [esp+16]
    jmp     e5
ALIGN 8
    movsx   eax, al
    jmp     e5
ALIGN 8
    movsx   eax, ax
    jmp     e5
ALIGN 8
    movzx   eax, al
    jmp     e5
ALIGN 8
    movzx   eax, ax
    jmp     e5
ALIGN 8
    mov     edx, [esp+20]
    jmp     e5
ALIGN 8
    jmp     e5
ALIGN 8
e5:
    add     esp, raw_closure_T_FS
    ret     4

ALIGN 8
    add     esp, raw_closure_T_FS
    ret     8
ALIGN 8
    jmp     e5
ALIGN 8
    movzx   eax, al
    jmp     e5
ALIGN 8
    movzx   eax, ax
    jmp     e5

ALIGN 8
    ud2
ALIGN 8
    ud2
ffi_closure_raw_THISCALL ENDP

; =========================================================================
; Trampoline code table
; =========================================================================
trampoline_code_table PROC
    REPT X86_TRAMP_MAP_SIZE / X86_TRAMP_SIZE
    sub     esp, 8
    mov     [esp], eax
    call    $+5
    pop     eax
    mov     eax, [eax+4081]
    mov     [esp+4], eax
    call    $+5
    pop     eax
    mov     eax, [eax+4070]
    jmp     eax
    ALIGN 4
    ENDM
trampoline_code_table ENDP

END
