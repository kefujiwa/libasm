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
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	sub		rsp, 48						; secure 48 bytes spaces on the stack for this function
	mov		qword [rbp - 16], rdi		; copy rdi (str) on the stack
	mov		qword [rbp - 24], rsi		; copy rsi (base) on the stack
	mov		dword [rbp - 28], 0			; total = 0
	mov		dword [rbp - 32], 1			; sign = 1

	mov		rdi, qword [rbp - 24]		; copy base to rdi (first parameter) before is_valid_base
	call	_is_valid_base
	cmp		eax, 0						; if (is_valid_base == 0)
	je		.return						; jump to .return if ZF == 1

.loop:
	mov		rax, qword [rbp - 16]
	movsx	edi, byte [rax]				; copy *str to edi (first parameter), extend 8bit to 32bit register (sign-extension)
	call	_is_space
	cmp		eax, 0						; if (is_space == 0)
	je		.check_sign					; jump to .check_sign if ZF == 1

	mov		rax, qword [rbp - 16]
	inc		rax							; str++
	mov		qword [rbp - 16], rax
	jmp		.loop

.check_sign:
	mov		rax, qword [rbp - 16]
	movsx	ecx, byte [rax]				; copy *str to ecx, extend 8bit to 32bit register (sign-extension)
	cmp		ecx, 45						; if (*str == '-')
	mov		dl, 1
	je		.if_minus					; jump to .if_minus if ZF == 1
	mov		rax, qword [rbp - 16]		; copy str to rax
	movsx	ecx, byte [rax]				; copy *str to ecx, extend 8bit to 32bit register (sign-extension)
	cmp		ecx, 43						; if (*str == '+')
	sete	dl							; set 1 to dl if ZF == 1, otherwise set 0

.if_minus:
	cmp		dl, 1						; if dl == 1
	jne		.calculate					; jump to .calculate if ZF == 0
	mov		rax, qword [rbp - 16]		; copy str to rax
	movsx	ecx, byte [rax]				; copy *str to ecx, extend 8bit to 32bit register (sign-extension)
	cmp		ecx, 45						; if (*str == '-')
	jne		.next						; jump to .next if ZF == 0
	imul	eax, dword [rbp - 32], -1	; sign *= -1
	mov		dword [rbp - 32], eax

.next:
	mov		rax, qword [rbp - 16]
	inc		rax							; str++
	mov		qword [rbp - 16], rax
	jmp		.check_sign

.calculate:
	mov		rax, qword [rbp - 16]
	mov		cl, byte [rax]				; copy *str to cl
	mov		rsi, qword [rbp - 24]		; copy base to rsi (second parameter) before get_value
	movsx	edi, cl						; copy *str to edi (first parameter) before get_value
	call	_get_value					; val = get_value(*str, base)
	mov		dword [rbp - 36], eax		; copy val on the stack
	cmp		eax, 0						; if (val < 0)
	jl		.result						; jump to .result if (SF ! OF)
	mov		rdi, qword [rbp - 24]		; copy base to rdi (first parameter) before ft_strlen
	call	_ft_strlen
	movsx	rcx, dword [rbp - 28]		; copy total to rcx, extend 32bit to 64bit register (sign-extension)
	imul	rcx, rax					; total *= ft_strlen(base)
	movsx	rax, dword [rbp - 36]
	add		rcx, rax					; total += val
	mov		dword [rbp - 28], ecx		; copy total (32bit) on the stack
	mov		rax, qword [rbp - 16]
	inc		rax							; str++
	mov		qword [rbp - 16], rax
	jmp		.calculate

.result:
	mov		eax, dword [rbp - 28]		; copy total to eax
	imul	eax, dword [rbp - 32]		; return (total * sign)

.return:
	add		rsp, 48						; release 48 bytes spaces on the stack
	pop		rbp
	ret

_is_valid_base:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	sub		rsp, 32						; secure 48 bytes spaces on the stack for this function
	mov		qword [rbp - 16], rdi		; copy rdi (base) on the stack
	cmp		qword [rbp - 16], 0			; if (base == NULL)
	je		.invalid					; jump to .invalid if ZF == 1
	mov		rax, qword [rbp - 16]
	cmp		byte [rax], 0				; if (*base == 0)
	je		.invalid					; jump to .invalid if ZF == 1
	mov		rax, qword [rbp - 16]
	cmp		byte [rax + 1], 0			; if (*(base + 1) == 0)
	je		.invalid					; jump to .invalid if ZF == 1

.check_base:
	mov		rax, qword [rbp - 16]
	cmp		byte [rax], 0				; if (*base == 0)
	je		.valid						; jump to .valid if ZF == 1

	mov		rax, qword [rbp - 16]
	movsx	ecx, byte [rax]
	cmp		ecx, 45						; if (*base == '-')
	je		.invalid					; jump to .invalid if ZF == 1

	mov		rax, qword [rbp - 16]
	movsx	ecx, byte [rax]
	cmp		ecx, 43						; if (*base == '+')
	je		.invalid					; jump to .invalid if ZF == 1

	mov		rax, qword [rbp - 16]
	movsx	edi, byte [rax]
	call	_is_space
	cmp		eax, 0						; if (is_space(*base) == 0)
	je		.check_duplicate			; jump to .check_duplicate if ZF == 1

.invalid:
	mov		dword [rbp - 4], 0			; return 0
	jmp		.return

.check_duplicate:
	mov		rax, qword [rbp - 16]
	inc		rax
	mov		qword [rbp - 24], rax		; tmp = base + 1

.loop:
	mov		rax, qword [rbp - 24]
	cmp		byte [rax], 0				; if (*tmp == 0)
	je		.next						; jump to .next if ZF == 1
	mov		rax, qword [rbp - 16]
	movsx	ecx, byte [rax]
	mov		rax, qword [rbp - 24]
	movsx	edx, byte [rax]
	cmp		ecx, edx					; if (*base == *tmp)
	je		.invalid					; jump to .invalid if ZF == 1
	mov		rax, qword [rbp - 24]
	inc		rax							; tmp++
	mov		qword [rbp - 24], rax
	jmp		.loop

.next:
	mov		rax, qword [rbp - 16]
	inc		rax							; base++
	mov		qword [rbp - 16], rax
	jmp		.check_base

.valid:
	mov		dword [rbp - 4], 1			; return 1

.return:
	mov		eax, dword [rbp - 4]
	add		rsp, 32						; release 32 bytes spaces on the stack
	pop		rbp
	ret

_is_space:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	mov		byte [rbp - 1], dil			; copy dil (char c) on the stack
	mov		cl, 1
	mov		byte [rbp - 2], cl			; initialize return value to 1
	movsx	eax, byte [rbp - 1]
	cmp		eax, 9						; if (c == '\t')
	je		.return						; jump to .return if ZF == 1
	movsx	eax, byte [rbp - 1]
	cmp		eax, 10						; if (c == '\n')
	je		.return						; jump to .return if ZF == 1
	movsx	eax, byte [rbp - 1]
	cmp		eax, 11						; if (c == '\v')
	je		.return						; jump to .return if ZF == 1
	movsx	eax, byte [rbp - 1]
	cmp		eax, 12						; if (c == '\f')
	je		.return						; jump to .return if ZF == 1
	movsx	eax, byte [rbp - 1]
	cmp		eax, 13						; if (c == '\r')
	je		.return						; jump to .return if ZF == 1
	movsx	eax, byte [rbp - 1]
	cmp		eax, 32						; if (c == ' ')
	sete	cl							; set 1 to cl if ZF == 1, otherwise set 0
	mov		byte [rbp - 2], cl

.return:
	mov		al, byte [rbp - 2]
	movzx	eax, al						; extend 8bit to 32bit register (zero-extension)
	pop		rbp
	ret

_get_value:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	mov		byte [rbp - 5], dil			; copy dil (char c) on the stack
	mov		qword [rbp - 16], rsi		; copy rsi (base) on the stack
	mov		qword [rbp - 24], rsi		; copy rsi (base) on the stack to save head ptr of base

.loop:
	mov		rax, qword [rbp - 16]
	cmp		byte [rax], 0				; if (*base == 0)
	je		.failure					; jump to .failure if ZF == 1
	mov		rax, qword [rbp - 16]
	movsx	ecx, byte [rax]
	movsx	edx, byte [rbp - 5]
	cmp		ecx, edx					; if (*base == c)
	jne		.next						; jump to .next if ZF == 0
	mov		rax, qword [rbp - 16]
	mov		rcx, qword [rbp - 24]
	sub		rax, rcx
	mov		dword [rbp - 4], eax		; return (base - head)
	jmp		.return

.next:
	mov		rax, qword [rbp - 16]
	inc		rax							; base++
	mov		qword [rbp - 16], rax
	jmp		.loop

.failure:
	mov		dword [rbp - 4], -1			; return -1

.return:
	mov		eax, dword [rbp - 4]
	pop		rbp
	ret
