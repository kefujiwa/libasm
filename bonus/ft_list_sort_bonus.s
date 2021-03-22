; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_sort_bonus.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/22 03:08:27 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/22 04:51:10 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_list_sort_bonus.s && gcc -o exec main.c ft_list_sort_bonus.o && ./exec
; void ft_list_sort(t_list **begin_list, int (*cmp)());

global _ft_list_sort

section .text
_ft_list_sort:
	cmp		rdi, 0				; if (begin_list == NULL)
	je		_return				; jump to _return if ZF == 1
	cmp		qword [rdi], 0		; if (*begin_list == NULL)
	je		_return				; jump to _return if ZF == 1
	cmp		rsi, 0				; if (cmp == NULL)
	je		_return				; jump to _return if ZF == 1

	mov		r8, 0				; initialize r8 (flag) to 0
	mov		r9, [rdi]			; copy *begin_list to r9 (head)
	mov		rdi, [rdi]			; copy *begin_list to rdi (list)

_loop:
	mov		r10, [rdi + 8]		; copy list->next to r10
	cmp		r10, 0				; if (list->next == NULL)
	je		_loop_if			; jumpt to _loop_if if ZF == 1

	push	rdi					; push rdi (list) onto the stack
	push	rsi					; push rsi (cmp) onto the stack
	push	r8					; push r8 (flag) onto the stack
	push	r9					; push r9 (head) onto the stack
	push	r10					; push r10 (list->next) onto the stack
	mov		rdx, rsi			; copy rsi (cmp) to rdx
	mov		rsi, [r10]			; copy list->next->data to rsi (second parameter)
	mov		rdi, [rdi]			; copy list->data to rdi (first parameter)
	call	rdx					; call cmp
	pop		r10					; pop the last stack element off and store it to r10
	pop		r9					; pop the last stack element off and store it to r9
	pop		r8					; pop the last stack element off and store it to r8
	pop		rsi					; pop the last stack element off and store it to rsi
	pop		rdi					; pop the last stack element off and store it to rdi

	cmp		eax, 0				; if (cmp(data, next->data) > 0); use eax (32bit register) because type int is 4byte
	jg		_swap				; jumpt to _swap if ZF == 0 && SF == OF

_loop_pre:
	mov		rdi, r10			; list = list->next
	jmp		_loop

_swap:
	mov		r8, 1				; flag == 1
	mov		rdx, [r10]			; copy list->next->data to rdx
	mov		rcx, [rdi]			; copy list->data to rcx
	mov		[rdi], rdx			; copy rdx to list->data
	mov		[r10], rcx			; copy rcx to list->next->data
	jmp		_loop_pre

_loop_if:
	cmp		r8, 0				; if (flag == 0)
	je		_return				; jump to _return if ZF == 1
	mov		r8, 0				; initialize flag to 0
	mov		rdi, r9				; list = *begin_list
	jmp		_loop

_return:
	ret
