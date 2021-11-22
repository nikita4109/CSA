struc Cartoon
	.animation resq 1
endstruc

section .data
	cartoon_string db "cartoon", 0
	animation_string db "animation", 0
	stopmotion_string db "stopmotion", 0
	claymation_string db "claymation", 0
section .bss
section .text
	extern malloc
	extern free
	extern strcpy

; char *animation @ rbx
ctrCartoon:
; char *animation @ rbp - 8

	push rbp
	mov rbp, rsp

	push rbx

	mov rdi, Cartoon_size
	call malloc

	mov rbx, QWORD [rbp - 8]
	mov QWORD [rax + Cartoon.animation], rbx

	leave
	ret


; cartoon *cartoon @ rbx
dtrCartoon:
	push rbp
	mov rbp, rsp

	mov rdi, QWORD [rbx + Cartoon.animation]
	call free

	leave
	ret


; FILE *file @ rbx
; cartoon *cartoon @ rcx
writeCartoon:
; FILE *file @ rbp - 8
; cartoon *cartoon @ rbp - 16

	push rbp
	mov rbp, rsp

	sub rsp, 16

	mov QWORD [rbp - 8], rbx
	mov QWORD [rbp - 16], rcx

	mov rcx, cartoon_string
	call fwriteString

	mov rbx, QWORD [rbp - 8]
	call fwriteSpace

	mov rbx, QWORD [rbp - 8]
	mov rcx, QWORD [rbp - 16]
	mov rcx, QWORD [rcx + Cartoon.animation]
	call fwriteString

	mov rbx, QWORD [rbp - 8]
	call fwriteSpace

	leave
	ret


; FILE *file @ rbx
; film *film @ rcx
readCartoon:
; FILE *file @ rbp - 8
; film *film @ rbp - 16

	push rbp
	mov rbp, rsp

	push rbx
	push rcx

	mov QWORD [rcx + Film.type], cartoon_string

	call freadString

	mov rbx, rax
	call ctrCartoon

	mov rbx, QWORD [rbp - 16]
	mov QWORD [rbx + Film.film], rax

	leave
	ret


randomCartoon:
; char *animation @ rbp - 8

	push rbp
	mov rbp, rsp

	sub rsp, 8

	mov rbx, 3
	call randomInt

	cmp rax, 0
	je .animation
	cmp rax, 1
	je .claymation

	jmp .stopmotion

.animation:
	mov rdi, 10
	call malloc
	mov QWORD [rbp - 8], rax

	mov rsi, animation_string
	mov rdi, rax
	call strcpy
	jmp .exit
.claymation:
	mov rdi, 11
	call malloc
	mov QWORD [rbp - 8], rax

	mov rsi, claymation_string
	mov rdi, rax
	call strcpy
	jmp .exit
.stopmotion:
	mov rdi, 11
	call malloc
	mov QWORD [rbp - 8], rax

	mov rsi, stopmotion_string
	mov rdi, rax
	call strcpy
.exit:
	mov rbx, QWORD [rbp - 8]
	call ctrCartoon
	leave
	ret
