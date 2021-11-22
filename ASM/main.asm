%include "container.asm"

section .data
	file_input db "-f", 0

	new_line_string db 10, 0
	space_string db " ", 0
	err_string db "Incorrect format!", 10, 0
	file_exist_string db "File does not exist!", 10, 0
	ok_string db "Ok!", 10, 0

	new_line db 10, 0
	fmtS db "%s", 0
	fmtD db "%d", 0

	modeW db "w", 0
	modeR db "r", 0

	file_name db "input", 0
section .bss
section .text
	global main
	extern printf
	extern strcmp
	extern atoi
	extern fscanf
	extern fprintf
	extern fopen
	extern fgetc
	extern realloc
	extern fclose
	extern rand
	extern exit
	extern clock

; int argc @ rdi
; char **argv @ rsi
main:
; int argc @ rbp - 8
; char **argv @ rbp - 16
; container *container @ rbp - 24
; int start_time @ rbp - 32

	push rbp
	mov rbp, rsp
	sub rsp, 32

	mov [rbp - 8], rdi
	mov [rbp - 16], rsi

	call clock
	mov QWORD [rbp - 32], rax

	mov rdi, [rbp - 8]
	mov rsi, [rbp - 16]

	cmp rdi, 5
	je .correctFormat

	call errMessage
	jmp .exit

.correctFormat:
	mov rax, [rbp - 16]
	add rax, 8

	mov rsi, [rax]
	mov rdi, file_input
	call strcmp

	test rax, rax
	jne  .random

.file:
	mov rax, [rbp - 16]
	add rax, 16

	mov rbx, [rax] ; filename
	call readFromFile
	jmp .body

.random:
	mov rdi, [rbp - 16]
	add rdi, 16
	mov rdi, [rdi]
	call atoi

	mov rbx, rax
	call createFromRandom

.body:
	mov QWORD [rbp - 24], rax ; container *container @ rax

	mov rax, QWORD [rbp - 16]
	add rax, 24

	mov rbx, QWORD [rax] ; output1
	mov rcx, QWORD [rbp - 24]
	call writeToFile


	mov rbx, QWORD [rbp - 24]
	call shellSort

	mov rax, QWORD [rbp - 16]
	add rax, 32

	mov rbx, QWORD [rax]
	mov rcx, QWORD [rbp - 24]
	call writeToFile

	mov rbx, QWORD [rbp - 24]
	call dtrContainer

	call clock
	sub rax, QWORD [rbp - 32]

	mov rbx, rax
	call writeInt

	mov rbx, new_line
	call writeString
.exit:
	leave
	ret


; char *filename @ rbx
readFromFile:
; FILE *file @ rbp - 8
; container *container @ rbp - 16

	push rbp
	mov rbp, rsp

	sub rsp, 16

	mov rsi, modeR
	mov rdi, rbx
	call fopen

	cmp rax, 0
	jne .fileExist


	mov rbx, file_exist_string
	call writeString

	mov rdi, 1
	call exit

.fileExist:
	mov QWORD [rbp - 8], rax

	mov rbx, rax
	call readContainer
	mov QWORD [rbp - 16], rax

	mov rdi, QWORD [rbp - 8]
	call fclose

	mov rax, QWORD [rbp - 16]

	leave
	ret


; char *filename @ rbx
; container *container @ rcx
writeToFile:
; FILE *file @ rbp - 8
; container *container @ rbp - 16

	push rbp
	mov rbp, rsp

	sub rsp, 16

	mov QWORD [rbp - 16], rcx

	mov rsi, modeW
	mov rdi, rbx
	call fopen

	mov QWORD [rbp - 8], rax

	mov rbx, rax
	mov rcx, QWORD [rbp - 16]
	call writeContainer

	mov rdi, QWORD [rbp - 8]
	call fclose

	leave
	ret

; int size @ rbx
createFromRandom:
	push rbp
	mov rbp, rsp

	call randomContainer

	leave
	ret

; int max @ rbx
randomInt:
; int max @ rbp - 8

	push rbp
	mov rbp, rsp

	push rbx

	call rand

	cdq
	idiv DWORD [rbp - 8]
	mov eax, edx

	leave
	ret

randomString:
; int size @ rbp - 8
; char *string @ rbp - 16
; int i @ rbp - 24

	push rbp
	mov rbp, rsp

	sub rsp, 24

	mov rbx, 10
	call randomInt
	add rax, 1

	mov QWORD [rbp - 8], rax

	add rax, 1
	mov rdi, rax
	call malloc

	mov QWORD [rbp - 16], rax
	add rax, QWORD [rbp - 8]

	mov BYTE [rax], 0

	mov QWORD [rbp - 24], 0

.loop:
	mov rbx, 26
	call randomInt
	add rax, 97

	mov rbx, QWORD [rbp - 16]
	add rbx, QWORD [rbp - 24]

	mov BYTE [rbx], al

	add QWORD [rbp - 24], 1
	mov rax, QWORD [rbp - 8]
	cmp QWORD [rbp - 24], rax
	jl .loop

	mov rax, QWORD [rbp - 16]

	leave
	ret

errMessage:
	push rbp
	mov rbp, rsp

	mov rbx, err_string
	call writeString

	mov rsp, rbp
	pop rbp
	ret

writeInt:
	push rbp
	mov rbp, rsp

	mov rdi, fmtD
	mov rsi, rbx
	mov rax, 0
	call printf

	leave
	ret

writeString:
	push rbp
	mov rbp, rsp

	mov rdi, rbx
	mov rsi, fmtS
	mov rax, 0
	call printf

	leave
	ret

; FILE *file @ rbx
; char *string @ rcx
fwriteString:
	push rbp
	mov rbp, rsp

	mov rdx, rcx
	mov rsi, fmtS
	mov rdi, rbx
	mov rax, 0
	call fprintf

	leave
	ret

; FILE *file @ rbx
freadString:
; FILE *file @ rbp - 8
; int size @ rbp - 16
; int len @ rbp - 24
; int skipSpaces @ rbp - 32
; int c @ rbp - 40
; char *str @ rbp - 48

	push rbp
	mov rbp, rsp

	sub rsp, 48

	mov QWORD [rbp - 8], rbx
	mov QWORD [rbp - 16], 1
	mov QWORD [rbp - 24], 0
	mov QWORD [rbp - 32], 1

	mov rdi, 1
	call malloc

	mov QWORD [rbp - 48], rax

.loop:
	mov rdi, QWORD [rbp - 8]
	call fgetc

	mov QWORD [rbp - 40], rax
	cmp DWORD [rbp - 40], 0xFFFFFFFF
	je .exit

	cmp QWORD [rbp - 40], 32
	je .ifSkipSpaces

	cmp QWORD [rbp - 40], 10
	jne .body

.ifSkipSpaces:
	cmp QWORD [rbp - 32], 0
	je .exit
	jmp .loop

.body:
	mov QWORD [rbp - 32], 0

	mov rax, QWORD [rbp - 48]
	add rax, QWORD [rbp - 24]

	mov rbx, QWORD [rbp - 40]
	mov BYTE [rax], bl

	mov rax, QWORD [rbp - 24]
	add rax, 1

	mov QWORD [rbp - 24], rax
	cmp rax, QWORD [rbp - 16]
	jne .loop

	add QWORD [rbp - 16], 16
	mov rsi, QWORD [rbp - 16]
	mov rdi, QWORD [rbp - 48]
	call realloc
	mov QWORD [rbp - 48], rax

	jne .loop

.exit:

	mov rax, QWORD [rbp - 48]
	add rax, QWORD [rbp - 24]
	mov BYTE [rax], 0
	add QWORD [rbp - 24], 1

	mov rsi, QWORD [rbp - 16]
	mov rdi, QWORD [rbp - 48]
	call realloc

	leave
	ret


; FILE *file @ rbx
; int arg @ rcx
fwriteInt:
	push rbp
	mov rbp, rsp

	mov rdi, rbx
	mov rsi, fmtD
	mov rdx, rcx
	mov rax, 0
	call fprintf

	leave
	ret

; FILE *file @ rbx
freadInt:
; char *str @ rbp - 8
; int result @ rbp - 16

	push rbp
	mov rbp, rsp

	sub rsp, 16

	call freadString
	mov QWORD [rbp - 8], rax

	mov rdi, rax
	call atoi
	mov QWORD [rbp - 16], rax

	mov rdi, QWORD [rbp - 8]
	call free

	mov rax, QWORD [rbp - 16]

	leave
	ret

; FILE *file @ rbx
fwriteNL:
	push rbp
	mov rbp, rsp

	mov rcx, new_line_string
	call fwriteString

	leave
	ret

; FILE *file @ rbx
fwriteSpace:
	push rbp
	mov rbp, rsp

	mov rcx, space_string
	call fwriteString

	leave
	ret
