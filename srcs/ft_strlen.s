; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/18 23:34:15 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/18 23:49:17 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_strlen.s && gcc -o exec main.c ft_strlen.o && ./exec
; size_t ft_strlen(const char *s)

global _ft_strlen

section .text
_ft_strlen:
	push	rbp						; push rbp (base pointer) onto the stack
	mov		rbp, rsp				; copy rsp (stack pointer) to rbp
	mov		qword [rbp - 8], rdi	; copy rdi (s) onto the stack
	mov		qword [rbp - 16], 0		; copy 0 (counter) onto the stack

loop:
	mov		rax, qword [rbp - 8]	; copy s to rax
	mov		rcx, qword [rbp - 16]	; copy counter to rcx
	cmp		byte [rax + rcx], 0		; if (s[i] == 0)
	je		return					; jump to _return if ZF == 1

	mov		rax, qword [rbp - 16]	; copy counter to rax
	inc		rax
	mov		qword [rbp - 16], rax	; copy counter onto the stack
	jmp		loop

return:
	mov		rax, qword [rbp - 16]	; return counter
	pop		rbp
	ret
