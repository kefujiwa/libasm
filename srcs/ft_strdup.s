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
	call	_ft_strlen			; calculate length of s1 and store it to rax
	inc		rax					; increment rax for null character

	push	rdi					; store data of rdi (s1) to stack
	mov		rdi, rax			; copy rax (len + 1) to rdi (first parameter)
	call	_malloc				; do memory allocation and return the ptr to rax
	pop		rdi					; restore rdi (s1)
	cmp		rax, 0x0			; check if the ptr is NULL pointer
	je		_failure			; jump to _failure if ZF == 1

	push	rsi					; store data of rsi to stack
	mov		rsi, rdi			; copy rdi (s1) to rsi (second parameter)
	mov		rdi, rax			; copy rax (ptr) to rdi (first parameter)
	call	_ft_strcpy			; copy string s1 to ptr
	pop		rsi					; restore rsi
	ret

_failure:
	call	___error			; store ptr of variable errno to rax
	mov		byte [rax], 12		; assign 12:ENOMEM to errno
	ret
