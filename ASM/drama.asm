struc Drama
	.director resq 1
endstruc

section .data
	drama_string db "drama", 0
section .bss
section .text
	extern malloc
	extern free

; char *director @ rbx
ctrDrama:
; char *director @ rbp - 8

	push rbp
	mov rbp, rsp

	push rbx

	mov rdi, Drama_size
	call malloc

	mov rbx, QWORD [rbp - 8]
	mov QWORD [rax + Drama.director], rbx

	leave
	ret


; drama *drama @ rbx
dtrDrama:
	push rbp
	mov rbp, rsp

	mov rdi, QWORD [rbx + Drama.director]
	call free

	leave
	ret


; FILE *file @ rbx
; drama *drama @ rcx
writeDrama:
; FILE *file @ rbp - 8
; drama *drama @ rbp - 16

	push rbp
	mov rbp, rsp

	sub rsp, 16

	mov QWORD [rbp - 8], rbx
	mov QWORD [rbp - 16], rcx

	mov rcx, drama_string
	call fwriteString

	mov rbx, QWORD [rbp - 8]
	call fwriteSpace

	mov rbx, QWORD [rbp - 8]
	mov rcx, QWORD [rbp - 16]
	mov rcx, QWORD [rcx + Drama.director]
	call fwriteString

	mov rbx, QWORD [rbp - 8]
	call fwriteSpace

	leave
	ret


; FILE *file @ rbx
; film *film @ rcx
readDrama:
; FILE *file @ rbp - 8
; film *film @ rbp - 16

	push rbp
	mov rbp, rsp

	push rbx
	push rcx

	mov QWORD [rcx + Film.type], drama_string

	call freadString

	mov rbx, rax
	call ctrDrama

	mov rbx, QWORD [rbp - 16]
	mov QWORD [rbx + Film.film], rax

	leave
	ret


randomDrama:
	push rbp
	mov rbp, rsp

	call randomString
	mov rbx, rax
	call ctrDrama

	leave
	ret
