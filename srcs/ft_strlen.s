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
	mov		rax, 0					; initialize counter to 0

_loop:
	cmp		byte [rdi + rax], 0x0	; check if value of ptr [rdi + rax] is null character
	je		_return					; jump to _return if ZF == 1
	inc		rax						; increment counter
	jne		_loop					; jump to _loop if ZF == 0

_return:
	ret
