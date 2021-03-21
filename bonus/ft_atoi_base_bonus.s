; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base_bonus.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/20 02:43:22 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/21 02:30:48 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_atoi_base_bonus.s && gcc -o exec main.c ft_atoi_base_bonus.o && ./exec
; int ft_atoi_base(char *str, char *base)

global _ft_atoi_base
extern _ft_strlen

section .text
_ft_atoi_base:
	push	rdi						; push rdi (str) onto the stack
	push	rsi						; push rsi (base) onto the stack
	mov		rdi, rsi				; copy rsi (base) to rdi before calling  __is_valid_base
	call	__is_valid_base
	pop		rsi						; pop the last stack element off and store it to rsi
	pop		rdi						; pop the last stack element off and store it to rdi
	cmp		rax, 0					; if (is_valid_base(base) == 0)
	je		_return					; jump to _return if ZF == 1

.loop:
	push	rdi						; push rdi (str) onto the stack
	push	rsi						; push rsi (base) onto the stack
	call	__is_space
	pop		rsi						; pop the last stack element off and store it to rsi
	pop		rdi						; pop the last stack element off and store it to rdi
	cmp		rax, 1					; if (is_space(str) == 1)
	jne		_check_sign				; jump to _check_sign if ZF == 0
	inc		rdi						; str++
	jmp		.loop

_check_sign:
	mov		r8, 1					; initialize r8 (sign) to 1
	mov		rax, 0					; initialize rax to 0

.loop:
	mov		al, byte [rdi]			; copy value of *str to al (8bit register)
	cmp		al, 43					; if (*str == '+')
	je		.is_sign				; jump to .is_sign if ZF == 1
	cmp		al, 45					; if (*str == '-')
	jne		_calculate				; jump to _calculate if ZF == 0
	imul	r8, -1					; sign *= -1

.is_sign:
	inc		rdi						; str++
	jmp		.loop

_calculate:
	mov		r9, 0					; initialize r9 (total) to 0

	push	rdi						; push rdi (str) onto the stack
	push	rsi						; push rsi (base) onto the stack
	push	r8						; push r8 (sign) onto the stack
	push	r9						; push r9 (total) onto the stack
	mov		rdi, rsi				; copy rsi (base) to rdi (first parameter) before _ft_strlen
	call	_ft_strlen
	pop		r9						; pop the last stack element off and store it to r9
	pop		r8						; pop the last stack element off and store it to r8
	pop		rsi						; pop the last stack element off and store it to rsi
	pop		rdi						; pop the last stack element off and store it to rdi
	mov		r10, rax				; copy rax (length) to r10

.loop:
	push	rdi						; push rdi (str) onto the stack
	push	rsi						; push rsi (base) onto the stack
	push	r8						; push r8 (sign) onto the stack
	push	r9						; push r9 (total) onto the stack
	call	__get_value
	pop		r9						; pop the last stack element off and store it to r9
	pop		r8						; pop the last stack element off and store it to r8
	pop		rsi						; pop the last stack element off and store it to rsi
	pop		rdi						; pop the last stack element off and store it to rdi
	cmp		rax, 0					; check if rax (return value of __get_value) is 0
	jl		.result					; jump to .result if (SF ! OF)
	imul	r9, r10					; total *= length
	add		r9, rax					; total += rax (return value of __get_value)
	inc		rdi						; str++
	jmp		.loop

.result:
	imul	r9, r8					; total *= sign
	mov		rax, r9					; return total

_return:
	ret


__is_valid_base:
	mov		r8, 0					; initialize r8 to 0

	cmp		byte [rdi], 0			; if (*str == '\0')
	je		.invalid				; jump to .invalid if ZF == 1
	cmp		byte [rdi + 1], 0		; if (*(str + 1) == '\0')
	je		.invalid				; jump to .invalid if ZF == 1

.loop:
	mov		r8b, byte [rdi]			; copy *str to r8b
	cmp		r8b, 0					; if (*str == '\0')
	je		.valid					; jump to .valid if ZF == 1
	cmp		r8b, 43					; if (*str == '+')
	je		.invalid				; jump to .invalid if ZF == 1
	cmp		r8b, 45					; if (*str == '-')
	je		.invalid				; jump to .invalid if ZF == 1

	push	rdi						; push rdi (str) onto the stack
	call	__is_space
	pop		rdi						; pop the last stack element off and store it to rdi
	cmp		rax, 1					; if (is_space(*str) == 1)
	je		.invalid				; jump to .invalid if ZF == 1

	lea		rdx, [rdi + 1]			; copy pointer address of [str + 1] to rdx

.loop_s:
	cmp		byte [rdx], 0			; if (*rdx == '\0')
	je		.end_loop_s				; jump to .end_loop_s if ZF == 1
	cmp		al, byte [rdx]			; if (*str == *rdx)
	je		.invalid				; jump to .invalid if ZF == 1
	inc		rdx						; rdx++
	jmp		.loop_s

.end_loop_s:
	inc		rdi						; str++
	jmp		.loop

.invalid:
	mov		rax, 0					; if .invalid return 0
	ret

.valid:
	mov		rax, 1					; if .valid return 1
	ret


__is_space:
	mov		rax, 1					; initialize rax (return value) to 1
	mov		rdx, 0					; initialize rdx to 0
	mov		dl, byte [rdi]			; copy *str to dl (8byte register of rdx)

	cmp		dl, 9					; if (*str == '\t')
	je		.return					; jump to .return if ZF == 1
	cmp		dl, 10					; if (*str == '\n')
	je		.return					; jump to .return if ZF == 1
	cmp		dl, 11					; if (*str == '\v')
	je		.return					; jump to .return if ZF == 1
	cmp		dl, 12					; if (*str == '\f')
	je		.return					; jump to .return if ZF == 1
	cmp		dl, 13					; if (*str == '\r')
	je		.return					; jump to .return if ZF == 1
	cmp		dl, 32					; if (*str == ' ')
	je		.return					; jump to .return if ZF == 1

	mov		rax, 0					; return 0

.return:
	ret


__get_value:
	mov		rax, 0					; initialize counter to 0
	mov		r8, 0					; initialize r8 to 0
	mov		r9, 0					; initialize r9 to 0
	mov		r8b, byte [rdi]			; copy *str to r8b (8byte register of r8)

.loop:
	mov		r9b, byte [rsi + rax]	; copy base[rax] to r9b (8byte register of r9)
	cmp		r9b, 0					; if (base[rax] == '\0')
	je		.error					; jump to .error if ZF == 1
	cmp		r9b, r8b				; if (*str == base[rax])
	je		.return					; jump to .return if ZF == 0
	inc		rax						; rax++
	jmp		.loop

.error:
	mov		rax, -1					; if .error return -1

.return:
	ret								; return value of counter
