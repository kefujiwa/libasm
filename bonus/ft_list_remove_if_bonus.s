; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_remove_if_bonus.s                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/21 20:48:52 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/22 00:20:37 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_list_remove_if_bonus.s && gcc -o exec main.c ft_list_remove_if_bonus.o && ./exec
; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

global _ft_list_remove_if

section .text
_ft_list_remove_if:
	cmp		rdi, 0				; if (begin_list == NULL)
	je		_return				; jump to _return if ZF == 1
	cmp		rsi, 0				; if (data_ref == NULL)
	je		_return				; jump to _return if ZF == 1
	cmp		rdx, 0				; if (cmp == NULL)
	je		_return				; jump to _return if ZF == 1
	cmp		rcx, 0				; if (free_fct == NULL)
	je		_return				; jump to _return if ZF == 1

	mov		r8, [rdi]			; copy *begin_list to r8 (list)
	mov		r9, 0				; r9 (next) = NULL
	mov		r10, 0				; r10 (prev) = NULL

_loop:
	cmp		r8, 0				; if (list == NULL)
	je		_return				; jump to _return if ZF == 1
	mov		r9, [r8 + 8]		; next = list->next
	cmp		qword [r8], 0		; if (list->data == NULL)
	je		_continue			; jump to _return if ZF == 1

	push	rdi					; push rdi (begin_list) onto the stack
	push	rsi					; push rsi (data_ref) onto the stack					
	push	rdx					; push rdx (cmp) onto the stack
	push	rcx					; push rcx (free_fct) onto the stack
	push	r8					; push r8 (list) onto the stack
	push	r9					; push r9 (next) onto the stack
	push	r10					; push r10 (prev) onto the stack
	mov		rdi, [r8]			; copy list->data to rdi (first parameter) before cmp
	call	rdx					; cmp(list->data, data_ref)
	pop		r10					; pop the last stack element off and store it to r10
	pop		r9					; pop the last stack element off and store it to r9
	pop		r8					; pop the last stack element off and store it to r8
	pop		rcx					; pop the last stack element off and store it to rcx
	pop		rdx					; pop the last stack element off and store it to rdx
	pop		rsi					; pop the last stack element off and store it to rsi
	pop		rdi					; pop the last stack element off and store it to rdi
	cmp		rax, 0				; check if rax (return value of cmp) is 0
	jne		_continue			; jump to _continue if ZF == 0
	
	push	rdi					; push rdi (begin_list) onto the stack
	push	rsi					; push rsi (data_ref) onto the stack					
	push	rdx					; push rdx (cmp) onto the stack
	push	rcx					; push rcx (free_fct) onto the stack
	push	r8					; push r8 (list) onto the stack
	push	r9					; push r9 (next) onto the stack
	push	r10					; push r10 (prev) onto the stack
	mov		rdi, [r8]			; copy list->data to rdi (first parameter) before free
	call	rcx					; free(list->data);
	pop		r10					; pop the last stack element off and store it to r10
	pop		r9					; pop the last stack element off and store it to r9
	pop		r8					; pop the last stack element off and store it to r8
	pop		rcx					; pop the last stack element off and store it to rcx
	pop		rdx					; pop the last stack element off and store it to rdx
	pop		rsi					; pop the last stack element off and store it to rsi
	pop		rdi					; pop the last stack element off and store it to rdi

	push	rdi					; push rdi (begin_list) onto the stack
	push	rsi					; push rsi (data_ref) onto the stack					
	push	rdx					; push rdx (cmp) onto the stack
	push	rcx					; push rcx (free_fct) onto the stack
	push	r8					; push r8 (list) onto the stack
	push	r9					; push r9 (next) onto the stack
	push	r10					; push r10 (prev) onto the stack
	mov		rdi, r8				; copy list to rdi (first parameter) before free
	call	rcx					; free(list)
	pop		r10					; pop the last stack element off and store it to r10
	pop		r9					; pop the last stack element off and store it to r9
	pop		r8					; pop the last stack element off and store it to r8
	pop		rcx					; pop the last stack element off and store it to rcx
	pop		rdx					; pop the last stack element off and store it to rdx
	pop		rsi					; pop the last stack element off and store it to rsi
	pop		rdi					; pop the last stack element off and store it to rdi
	mov		r8, 0				; list = NULL

	cmp		r10, 0				; if (prev == NULL)
	je		_mov_begin			; jump to _mov_begin if ZF == 1
	mov		[r10 + 8], r9		; prev->next = next
	jmp		_continue

_mov_begin:
	mov		[rdi], r9			; *begin->list = next

_continue:
	cmp		r8, 0				; if (list == NULL)
	je		_next				; jump to _next if ZF == 1
	mov		r10, r8				; prev = list

_next:
	mov		r8, r9				; list = next
	jmp		_loop

_return:
	ret
