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
	mov		rcx, -1					; initialize counter to 0

_loop:
	inc		rcx						; increment counter
	mov		al, byte [rsi + rcx]	; copy value of src[cnt] to al (8bit register)
	mov		byte [rdi + rcx], al	; copy al to dst[cnt]
	cmp		al, 0					; check if al is null character
	jne		_loop					; jump to _loop if ZF == 0
	mov		rax, rdi				; return dst
	ret
