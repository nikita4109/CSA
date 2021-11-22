struc Documentary
	.duration resq 1
endstruc

section .data
	documentary_string db "documentary", 0
section .bss
section .text
	extern malloc
	extern free

; int duration @ rbx
ctrDocumentary:
; int duration @ rbp - 8

	push rbp
	mov rbp, rsp

	push rbx

	mov rdi, Documentary_size
	call malloc

	mov rbx, QWORD [rbp - 8]
	mov QWORD [rax + Documentary.duration], rbx

	leave
	ret


; documentary *documentary @ rbx
dtrDocumentary:
	push rbp
	mov rbp, rsp

; Nothing to free.

	leave
	ret


; FILE *file @ rbx
; documentary *documentary @ rcx
writeDocumentary:
; FILE *file @ rbp - 8
; documentary *documentary @ rbp - 16

	push rbp
	mov rbp, rsp

	sub rsp, 16

	mov QWORD [rbp - 8], rbx
	mov QWORD [rbp - 16], rcx

	mov rcx, documentary_string
	call fwriteString

	mov rbx, QWORD [rbp - 8]
	call fwriteSpace

	mov rbx, QWORD [rbp - 8]
	mov rcx, QWORD [rbp - 16]
	mov rcx, QWORD [rcx + Documentary.duration]
	call fwriteInt

	mov rbx, QWORD [rbp - 8]
	call fwriteSpace

	leave
	ret


; FILE *file @ rbx
; film *film @ rcx
readDocumentary:
; FILE *file @ rbp - 8
; film *film @ rbp - 16

	push rbp
	mov rbp, rsp

	push rbx
	push rcx

	mov QWORD [rcx + Film.type], documentary_string

	call freadInt

	mov rbx, rax
	call ctrDocumentary

	mov rbx, QWORD [rbp - 16]
	mov QWORD [rbx + Film.film], rax

	leave
	ret



randomDocumentary:
	push rbp
	mov rbp, rsp

	mov rbx, 400
	call randomInt
	mov rbx, rax
	call ctrDocumentary

	leave
	ret
