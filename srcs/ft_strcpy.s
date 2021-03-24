; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/19 20:13:39 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/19 20:37:50 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_strcpy.s && gcc -o exec main.c ft_strcpy.o && ./exec
; char *ft_strcpy(char *dst, const char *src)

global _ft_strcpy

section .text
_ft_strcpy:
	push	rbp						; push rbp (base pointer) onto the stack
	mov		rbp, rsp				; copy rsp (stack pointer) to rbp
	mov		qword [rbp - 8], rdi	; copy rdi (dst) onto the stack
	mov		qword [rbp - 16], rsi	; copy rsi (src) onto the stack
	mov		qword [rbp - 24], rdi	; copy rdi (dst) onto the stack to save head of the ptr

loop:
	mov		rax, qword [rbp - 16]	; copy src to rax
	cmp		byte [rax], 0			; if (*src == 0)
	je		return					; jump to _return if ZF == 1

	mov		rcx, rax				; copy src to rcx
	inc		rcx						; rcx++ (src++)
	mov		qword [rbp - 16], rcx	; copy src onto the stack
	mov		dl, byte [rax]			; copy [rax] (*src) to dl
	mov		rax, qword [rbp - 8]	; copy dst to rax
	mov		rcx, rax				; copy dst to rcx
	inc		rcx						; rcx++ (dst++)
	mov		qword [rbp - 8], rcx	; copy dst onto the stack
	mov		byte [rax], dl			; copy *src to *dst
	jmp		loop

return:
	mov		rax, qword [rbp - 8]	; copy dst to rax
	mov		byte [rax], 0			; *dst = '\0'
	mov		rax, qword [rbp - 24]	; return head of the ptr dst
	pop		rbp
	ret
