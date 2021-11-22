%include "film.asm"

struc Container
	.length resq 1
	.films resq 1
endstruc

section .data
	fmt db "%s", 0
	string1 db "This is container!", 10, 0
section .bss
	intVar resq 1
section .text
	extern fprintf
	extern fscanf
	extern malloc
	extern free
	extern calloc

; int length @ rbx
ctrContainer:
; int length @ rbp - 8
; container *container @ rbp - 16

	push rbp
	mov rbp, rsp

	sub rsp, 16

	mov QWORD [rbp - 8], rbx

	mov rdi, Container_size
	call malloc
	mov QWORD [rbp - 16], rax

	mov rbx, QWORD [rbp - 8]
	mov [rax + Container.length], rbx

	mov rsi, 8
	mov rdi, QWORD [rbp - 8]
	call calloc

	mov rbx, QWORD [rbp - 16]
	mov QWORD [rbx + Container.films], rax

	mov rax, QWORD [rbp - 16]

	leave
	ret


; container *container @ rbx
dtrContainer:
; container *container @ [rbp - 8]
; int i @ [rbp - 16]

	push rbp
	mov rbp, rsp

	sub rsp, 16

	mov QWORD [rbp - 8], rbx
	mov QWORD [rbp - 16], 0

.loop:
	mov rax, QWORD [rbp - 8]
	mov rax, QWORD [rax + Container.length]
	cmp QWORD [rbp - 16], rax
	jl .body
	jmp .exit
.body:
	mov rax, QWORD [rbp - 8]
	mov rax, QWORD [rax + Container.films]
	mov rcx, QWORD [rbp - 16]

	lea rax, [rax + rcx * 8]
	mov rbx, QWORD [rax]
	call dtrFilm

	add QWORD [rbp - 16], 1
	jmp .loop

.exit:
	mov rax, QWORD [rbp - 8]
	mov rax, QWORD [rax + Container.films]

	mov rdi, rax
	call free

	mov rdi, QWORD [rbp - 8]
	call free

	leave
	ret


; FILE *file @ rbx
; container *container @ rcx
writeContainer:
; FILE *file @ [rbp - 8]
; int i @ [rbp - 16]
; container *container @ [rbp - 24]

	push rbp
	mov rbp, rsp

	sub rsp, 24

	mov QWORD [rbp - 8], rbx
	mov QWORD [rbp - 24], rcx
	mov QWORD [rbp - 16], 0

	mov rcx, QWORD [rcx + Container.length]
	call fwriteInt

	mov rbx, QWORD [rbp - 8]
	call fwriteNL

.loop:
	mov rax, QWORD [rbp - 16]
	mov rbx, QWORD [rbp - 24]
	cmp rax, QWORD [rbx + Container.length]
	jge .exit

	mov rbx, QWORD [rbp - 24]
	mov rbx, QWORD [rbx + Container.films]

	mov rcx, QWORD [rbp - 16]
	lea rbx, [rbx + 8 * rcx]

	mov rcx, QWORD [rbx]
	mov rbx, QWORD [rbp - 8]
	call writeFilm

	mov rbx, QWORD [rbp - 8]
	call fwriteNL

	add QWORD [rbp - 16], 1
	jmp .loop

.exit:
	leave
	ret


; FILE *file @ rbx
readContainer:
; FILE *file @ [rbp - 8]
; int length @ [rbp - 16]
; int i @ [rbp - 24]
; container *container @ [rbp - 32]

	push rbp
	mov rbp, rsp

	sub rsp, 32

	mov QWORD [rbp - 8], rbx
	mov QWORD [rbp - 24], 0

	call freadInt
	mov QWORD [rbp - 16], rax

	mov rbx, rax
	call ctrContainer
	mov QWORD [rbp - 32], rax

.loop:
	mov rax, QWORD [rbp - 24]
	cmp rax, QWORD [rbp - 16]
	jge .exit

	mov rbx, QWORD [rbp - 8]
	call readFilm ; film *film @ rax

	mov rbx, QWORD [rbp - 32]
	mov rbx, QWORD [rbx + Container.films]

	mov rcx, QWORD [rbp - 24]
	lea rbx, [rbx + 8 * rcx]

	mov QWORD [rbx], rax
	add QWORD [rbp - 24], 1
	jmp .loop

.exit:
	mov rax, QWORD [rbp - 32]

	leave
	ret


; container *container @ rbx
shellSort:
; container *container @ rbp - 8
; int s @ rbp - 16
; int i @ rbp - 24
; int j @ rbp - 32
; film **film_i @ rbp - 40
; film **film_j @ rbp - 48
; int temp @ rbp - 56

	push rbp
	mov rbp, rsp

	sub rsp, 56
	mov QWORD [rbp - 8], rbx

	mov rax, [rbx + Container.length]
	mov QWORD [rbp - 16], rax

.loops:
	mov rdx, 0
	mov rax, QWORD [rbp - 16]
	mov rcx, 2
	idiv rcx

	mov QWORD [rbp - 16], rax
	cmp rax, 0 ; s > 0

	jle .exit

	mov QWORD [rbp - 24], -1 ; i = -1

.loopi:
	add QWORD [rbp - 24], 1 ; i += 1

	mov rax, QWORD [rbp - 8]
	mov rax, QWORD [rax + Container.length]
	cmp QWORD [rbp - 24], rax
	jge .loops

	mov rax, QWORD [rbp - 24]
	mov QWORD [rbp - 32], rax ; j = i

.loopj:
	mov rax, QWORD [rbp - 16]
	add QWORD [rbp - 32], rax ; j += s

	mov rax, QWORD [rbp - 8]
	mov rax, QWORD [rax + Container.length]
	cmp QWORD [rbp - 32], rax
	jge .loopi

	mov rbx, QWORD [rbp - 8]
	mov rbx, QWORD [rbx + Container.films]
	mov rcx, QWORD [rbp - 24]

	lea rcx, [rcx * 8 + rbx]
	mov QWORD [rbp - 40], rcx

	mov rcx, QWORD [rbp - 32]
	lea rcx, [rcx * 8 + rbx]
	mov QWORD [rbp - 48], rcx

	mov rax, QWORD [rbp - 40]
	mov rbx, QWORD [rax]
	call calculate
	mov QWORD [rbp - 56], rax ; temp

	mov rax, QWORD [rbp - 48]
	mov rbx, QWORD [rax]
	call calculate

	cmp QWORD [rbp - 56], rax
	jle .continue
.if:
	mov rsi, QWORD [rbp - 40]
	mov rdi, QWORD [rbp - 48]
	call swap

.continue:
	jmp .loopj

.exit:
	leave
	ret

; void *arg1 @ rsi
; void *arg2 @ rdi
swap:
	push rbp
	mov rbp, rsp

	mov rbx, QWORD [rsi]
	mov rcx, QWORD [rdi]
	mov QWORD [rsi], rcx
	mov QWORD [rdi], rbx

	leave
	ret


; int length @ rbx
randomContainer:
; container *container @ rbp - 8
; int i @ rbp - 16
; int length @ rbp - 24

	push rbp
	mov rbp, rsp

	sub rsp, 24

	mov QWORD [rbp - 16], 0
	mov QWORD [rbp - 24], rbx

	call ctrContainer
	mov QWORD [rbp - 8], rax

.loop:
	call randomFilm
	mov rbx, QWORD [rbp - 8]
	mov rbx, QWORD [rbx + Container.films]
	mov rcx, QWORD [rbp - 16]
	lea rbx, [rcx * 8 + rbx]
	mov QWORD [rbx], rax

	add QWORD [rbp - 16], 1
	mov rax, QWORD [rbp - 24]
	cmp QWORD [rbp - 16], rax
	jl .loop


	mov rax, QWORD [rbp - 8]
	leave
	ret
