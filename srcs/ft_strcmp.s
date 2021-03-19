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

global _ft_strcmp

section .text
_ft_strcmp:
	mov		rax, 0x0				; initialize rax to 0
	push	rcx						; store data of rcx in stack
	mov		rcx, -1					; initialize counter to 0

_loop:
	inc		rcx						; increment counter
	mov		al, byte [rdi + rcx]	; copy value of [rdi + rcx] to al (8bit register)
	cmp		al, byte [rsi + rcx]	; check if [rdi + rcx] == [rsi + rcx]
	jne		_not_equal				; jump to _not_equal if ZF == 0
	cmp		al, 0x0					; when _is_equal, check if [rdi + rcx] is null character
	jne		_loop					; jump to _loop if ZF == 0

_return:
	pop		rcx						; restore data of rcx
	ret

_not_equal:
	sub		al, byte [rsi + rcx]	; subtract [rdi + rcx] from [rsi + rcx] and store it to al
	movsx	rax, al					; extend 8 bit register al to 64 bit register rax (sign-extension)
	jmp		_return
