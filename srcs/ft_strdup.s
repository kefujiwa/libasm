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
extern ___error
extern _malloc
extern _ft_strcpy
extern _ft_strlen

section .text
_ft_strdup:
	push	rdi					; push rdi (s1) onto the stack
	call	_ft_strlen			; calculate length of s1 and store it to rax
	pop		rdi					; pop the last stack element off and store it to rdi
	inc		rax					; increment rax (length)

	push	rdi					; push rdi (s1) onto the stack
	mov		rdi, rax			; copy rax (length + 1) to rdi (first parameter) before _malloc
	call	_malloc
	pop		rdi					; pop the last stack element off and store it to rdi
	cmp		rax, 0				; check if the ptr is NULL pointer
	je		_error				; jump to _error if ZF == 1

	mov		rsi, rdi			; copy rdi (s1) to rsi (second parameter) before _ft_strcpy
	mov		rdi, rax			; copy rax (ptr) to rdi (first parameter) before _ft_strcpy
	call	_ft_strcpy
	ret

_error:
	call	___error			; store ptr of variable errno to rax
	mov		byte [rax], 12		; assign 12:ENOMEM to errno
	ret
