; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/19 00:10:55 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/19 10:23:07 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_strcmp.s && gcc -o exec main.c ft_strcmp.o && ./exec
; int ft_strcmp(const char *s1, const char *s2)

global _ft_strcmp

section .text
_ft_strcmp:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	mov		qword [rbp - 8], rdi		; copy rdi (s1) onto the stack
	mov		qword [rbp - 16], rsi		; copy rsi (s2) onto the stack

loop:
	xor		eax, eax					; initialize eax to 0
	mov		rcx, qword [rbp - 8]
	movsx	edx, byte [rcx]				; copy *s1 to edx, extend 8bit to 32bit register (sign-extension)
	cmp		edx, 0						; if (*s1 == 0)
	mov		byte [rbp - 17], al			; copy 0 to rbp - 17
	je		loop_if						; jump to _loop_if if ZF == 1

	xor		eax, eax					; initialize eax to 0
	mov		rcx, qword [rbp - 16]
	movsx	edx, byte [rcx]				; copy *s2 to edx, extend 8bit to 32bit register (sign-extension)
	cmp		edx, 0						; if (*s2 == 0)
	mov		byte [rbp - 17], al			; copy 0 to rbp - 17
	je		loop_if						; jump to _loop_if if ZF == 1

	mov		rax, qword [rbp - 8]
	movsx	ecx, byte [rax]				; copy *s1 to ecx, extend 8bit to 32bit register (sign-extension)
	mov		rax, qword [rbp - 16]
	movsx	edx, byte [rax]				; copy *s2 to edx, extend 8bit to 32 bit regiter (sign-extension)
	cmp		ecx, edx					; if (*s1 == *s2)
	sete	sil							; set 1 to sil if ZF == 1, otherwise set 0
	mov		byte [rbp - 17], sil

loop_if:
	mov		al, byte [rbp - 17]
	test	al, 1						; al &= 1
	jnz		next						; jump to _next if ZF == 0
	jmp		result

next:
	mov		rax, qword [rbp - 8]
	inc		rax							; s1++
	mov		qword [rbp - 8], rax
	mov		rax, qword [rbp - 16]
	inc		rax							; s2++
	mov		qword [rbp - 16], rax
	jmp		loop

result:
	mov		rax, qword [rbp - 8]
	movzx	ecx, byte [rax]				; copy *s1 to ecx, extend 8bit to 32bit register (zero-extension)
	mov		rax, qword [rbp - 16]
	movzx	edx, byte [rax]				; copy *s2 to edx, extend 8bit to 32bit register (zero-extension)
	sub		ecx, edx					; (unsigned int)*s1 - (unsinged int)*s2
	mov		eax, ecx
	pop		rbp
	ret
