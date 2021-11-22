%include "drama.asm"
%include "cartoon.asm"
%include "documentary.asm"

struc Film
	.film resq 1
	.type resq 1
	.year resq 1
	.title resq 1
endstruc

section .data
section .bss
section .text
	extern malloc
	extern free
	extern strcmp

; int year @ rbx
; char *title @ rcx
ctrFilm:
; int year @ rbp - 8
; char *title @ rbp - 16

	push rbp
	mov rbp, rsp

	sub rsp, 24

	mov QWORD [rbp - 8], rbx
	mov QWORD [rbp - 16], rcx

	mov rdi, Film_size
	call malloc

	mov rbx, QWORD [rbp - 8]
	mov [rax + Film.year], rbx

	mov rbx, QWORD [rbp - 16]
	mov [rax + Film.title], rbx

	leave
	ret


; film *film @ rbx
dtrFilm:
; film *film @ rbp - 8
; char *type @ rbp - 16

	push rbp
	mov rbp, rsp

	push rbx
	mov rcx, QWORD [rbx + Film.type]
	push rcx

	mov rdi, [rbx + Film.title]
	call free

	mov rsi, QWORD [rbp - 16]
	mov rdi, drama_string
	call strcmp
	test rax, rax
	je .drama

	mov rsi, QWORD [rbp - 16]
	mov rdi, cartoon_string
	call strcmp
	test rax, rax
	je .cartoon

	mov rsi, QWORD [rbp - 16]
	mov rdi, documentary_string
	call strcmp
	test rax, rax
	je .documentary

.drama:
	mov rbx, QWORD [rbp - 8]
	mov rbx, QWORD [rbx + Film.film]
	call dtrDrama

	jmp .exit
.cartoon:
	mov rbx, QWORD [rbp - 8]
	mov rbx, QWORD [rbx + Film.film]
	call dtrCartoon

	jmp .exit
.documentary:
	mov rbx, QWORD [rbp - 8]
	mov rbx, QWORD [rbx + Film.film]
	call dtrDocumentary

	jmp .exit

.exit:
	mov rax, QWORD [rbp - 8]
	mov rdi, QWORD [rax + Film.film]
	call free

	mov rdi, QWORD [rbp - 8]
	call free

	leave
	ret


; FILE *file @ rbx
; film *film @ rcx
writeFilm:
; FILE *file @ rbp - 8
; film *film @ rbp - 16
; char *type @ rbp - 24

	push rbp
	mov rbp, rsp

	sub rsp, 24

	mov QWORD [rbp - 8], rbx
	mov QWORD [rbp - 16], rcx
	mov rdx, QWORD [rcx + Film.type]
	mov QWORD [rbp - 24], rdx

	mov rcx, QWORD [rcx + Film.year]
	mov rbx, QWORD [rbp - 8]
	call fwriteInt

	mov rbx, QWORD [rbp - 8]
	call fwriteSpace

	mov rax, QWORD [rbp - 16]
	mov rcx, QWORD [rax + Film.title]
	mov rbx, QWORD [rbp - 8]
	call fwriteString

	mov rbx, QWORD [rbp - 8]
	call fwriteSpace

	mov rsi, QWORD [rbp - 24]
	mov rdi, drama_string
	call strcmp
	test rax, rax
	je .drama

	mov rsi, QWORD [rbp - 24]
	mov rdi, cartoon_string
	call strcmp
	test rax, rax
	je .cartoon

	mov rsi, QWORD [rbp - 24]
	mov rdi, documentary_string
	call strcmp
	test rax, rax
	je .documentary

.drama:
	mov rbx, QWORD [rbp - 8]
	mov rcx, QWORD [rbp - 16]
	mov rcx, QWORD [rcx + Film.film]
	call writeDrama

	jmp .exit
.cartoon:
	mov rbx, QWORD [rbp - 8]
	mov rcx, QWORD [rbp - 16]
	mov rcx, QWORD [rcx + Film.film]
	call writeCartoon

	jmp .exit
.documentary:
	mov rbx, QWORD [rbp - 8]
	mov rcx, QWORD [rbp - 16]
	mov rcx, QWORD [rcx + Film.film]
	call writeDocumentary

	jmp .exit

.exit:
	leave
	ret


; FILE *file @ rbx
readFilm:
; FILE *file @ rbp - 8
; int year @ rbp - 16
; char *title @ rbp - 24
; film *film @ rbp - 32
; char *type @ rbp - 40

	push rbp
	mov rbp, rsp

	sub rsp, 40

	mov QWORD [rbp - 8], rbx

	call freadInt
	mov QWORD [rbp - 16], rax

	mov rbx, QWORD [rbp - 8]
	call freadString
	mov QWORD [rbp - 24], rax

	mov rbx, QWORD [rbp - 16]
	mov rcx, QWORD [rbp - 24]
	call ctrFilm

	mov QWORD [rbp - 32], rax

	mov rbx, QWORD [rbp - 8]
	call freadString
	mov QWORD [rbp - 40], rax

	mov rsi, QWORD [rbp - 40]
	mov rdi, drama_string
	call strcmp
	test rax, rax
	je .drama

	mov rsi, QWORD [rbp - 40]
	mov rdi, cartoon_string
	call strcmp
	test rax, rax
	je .cartoon

	mov rsi, QWORD [rbp - 40]
	mov rdi, documentary_string
	call strcmp
	test rax, rax
	je .documentary

.drama:
	mov rbx, QWORD [rbp - 8]
	mov rcx, QWORD [rbp - 32]
	call readDrama

	jmp .exit
.cartoon:
	mov rbx, QWORD [rbp - 8]
	mov rcx, QWORD [rbp - 32]
	call readCartoon

	jmp .exit
.documentary:
	mov rbx, QWORD [rbp - 8]
	mov rcx, QWORD [rbp - 32]
	call readDocumentary

	jmp .exit

.exit:
	mov rdi, QWORD [rbp - 40]
	call free

	mov rax, QWORD [rbp - 32]

	leave
	ret



; film *film @ rbx
calculate:
; film *film @ rbp - 8

	push rbp
	mov rbp, rsp

	push rbx

	mov rdi, QWORD [rbx + Film.title]
	call strlen

	mov rbx, rax
	mov rax, QWORD [rbp - 8]
	mov rax, QWORD [rax + Film.year]

	mov rdx, 0
	idiv rbx

	leave
	ret


strlen:
	push rbp
	mov rbp, rsp

	xor rcx, rcx

.strlen_next:

	cmp BYTE [rdi], 0
	jz .strlen_null

	inc rcx
	inc rdi
	jmp .strlen_next

.strlen_null:

	mov rax, rcx

	leave
	ret


randomFilm:
; film *film @ rbp - 8
; int year @ rbp - 16
; char *title @ rbp - 24

	push rbp
	mov rbp, rsp

	sub rsp, 24

	mov rbx, 200
	call randomInt
	add rax, 1900
	mov QWORD [rbp - 16], rax

	call randomString
	mov rcx, rax
	mov rbx, QWORD [rbp - 16]
	call ctrFilm

	mov QWORD [rbp - 8], rax

	mov rbx, 3
	call randomInt

	cmp rax, 0
	je .drama
	cmp rax, 1
	je .cartoon
	jmp .documentary

.drama:
	mov rax, QWORD [rbp - 8]
	mov QWORD [rax + Film.type], drama_string
	call randomDrama

	jmp .exit
.cartoon:
	mov rax, QWORD [rbp - 8]
	mov QWORD [rax + Film.type], cartoon_string
	call randomCartoon

	jmp .exit
.documentary:
	mov rax, QWORD [rbp - 8]
	mov QWORD [rax + Film.type], documentary_string
	call randomDocumentary

	jmp .exit

.exit:
	mov rbx, QWORD [rbp - 8]
	mov QWORD [rbx + Film.film], rax

	mov rax, QWORD [rbp - 8]
	leave
	ret
