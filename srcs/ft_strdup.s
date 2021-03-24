; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strdup.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/19 21:54:52 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/19 22:21:17 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_strdup.s && gcc -o exec main.c ft_strdup.o && ./exec
; char *ft_strdup(const char *s1)

global _ft_strdup
extern _malloc
extern _ft_strcpy
extern _ft_strlen

section .text
_ft_strdup:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	sub		rsp, 32						; secure 32 bytes spaces on the stack for this function
	mov		qword [rbp - 16], rdi		; copy rdi (s1) on the stack

	call	_ft_strlen
	inc		rax							; len++
	mov		qword [rbp - 32], rax		; copy rax (len) on the stack
	
	mov		rdi, rax					; copy rax (len) to rdi (first paramater)
	call	_malloc
	mov		qword [rbp - 24], rax		; copy rax (dst) on the stack
	cmp		qword [rbp - 24], 0			; if (ptr == NULL)
	jne		next						; jump to _next if ZF == 0
	mov		qword [rbp - 8], 0			; copy 0 on the stack for return value
	jmp		return

next:
	mov		rdi, qword [rbp - 24]		; copy dst to rdi (first parameter)
	mov		rsi, qword [rbp - 16]		; copy s1 to rsi (second parameter)
	call	_ft_strcpy
	mov		rcx, qword [rbp - 24]		; copy dst to rcx
	mov		qword [rbp - 8], rcx		; copy dst on the stack for return value

return:
	mov		rax, qword [rbp - 8]
	add		rsp, 32						; release 32 bytes spaces on the stack
	pop		rbp
	ret
