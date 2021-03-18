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

global _ft_strlen

section .text
_ft_strlen:
	mov		rax, -1					; initialize counter to -1

_loop:
	inc		rax						; increment counter
	cmp		byte [rdi + rax], 0x0	; check if value of ptr [rdi + rax] is null character
	jne		_loop
	ret
