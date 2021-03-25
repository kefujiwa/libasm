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
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	sub		rsp, 64						; secure 32 bytes spaces on the stack for this function
	mov		qword [rbp - 8], rdi		; copy rdi (begin_list) on the stack
	mov		qword [rbp - 16], rsi		; copy rsi (data_ref) on the stack
	mov		qword [rbp - 24], rdx		; copy rdx (cmp) on the stack
	mov		qword [rbp - 32], rcx		; copy rcx (free_fct) on the stack
	mov		rax, qword [rbp - 8]
	mov		rax, qword [rax]			; copy *begin_list to rax
	mov		qword [rbp - 40], rax		; list = *begin_list
	mov		qword [rbp - 48], 0			; next = NULL
	mov		qword [rbp - 56], 0			; prev = NULL
	cmp		qword [rbp - 8], 0			; if (begin_next == NULL)
	je		return						; jump to return if ZF == 1
	cmp		qword [rbp - 16], 0			; if (data_ref == NULL)
	je		return						; jump to return if ZF == 1
	cmp		qword [rbp - 24], 0			; if (cmp == NULL)
	je		return						; jump to return if ZF == 1
	cmp		qword [rbp - 32], 0			; if (free_fct = NULL)
	je		return						; jump to return if ZF == 1
	
loop:
	cmp		qword [rbp - 40], 0			; if (list == NULL)
	je		return						; jump to return if ZF == 1
	mov		rax, qword [rbp - 40]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 48], rax		; next = list->next
	mov		rax, qword [rbp - 40]
	cmp		qword [rax], 0				; if (list->data == NULL)
	je		if_removed					; jump to if_removed if ZF == 1
	mov		rax, qword [rbp - 24]		; copy cmp to rax
	mov		rcx, qword [rbp - 40]		; copy list to rcx
	mov		rdi, qword [rcx]			; copy list->data to rdi (first_parameter)
	mov		rsi, qword [rbp - 16]		; copy data_ref to rsi (second_parameter)
	call	rax							; cmp(list->data, data-ref)
	cmp		eax, 0						; if cmp() != 0
	jne		if_removed					; jump to if_removed if ZF == 0
	mov		rax, qword [rbp - 32]		; copy free_fct to rax
	mov		rcx, qword [rbp - 40]		; copy list to rcx
	mov		rdi, qword [rcx]			; copy list->data to rdi (first parameter)
	call	rax							; free_fct(list->data)
	mov		rax, qword [rbp - 32]		; copy free_fct to rax
	mov		rdi, qword [rbp - 40]		; copy list to rdi (first parameter)
	call	rax							; free_fct(list)
	mov		qword [rbp - 40], 0			; list = NULL
	cmp		qword [rbp - 56], 0			; if (prev)
	je		if_head						; jump to if_head if ZF == 1
	mov		rax, qword [rbp - 48]
	mov		rcx, qword [rbp - 56]
	mov		qword [rcx + 8], rax		; prev->next = next
	jmp		if_removed

if_head:
	mov		rax, qword [rbp - 48]
	mov		rcx, qword [rbp - 8]
	mov		qword [rcx], rax			; *begin_list = next

if_removed:
	cmp		qword [rbp - 40], 0			; if (list == NULL)
	je		next						; jump to next if ZF == 1
	mov		rax, qword [rbp - 40]
	mov		qword [rbp - 56], rax		; prev = list (if list is not removed)

next:
	mov		rax, qword [rbp - 48]
	mov		qword [rbp - 40], rax		; list = next
	jmp		loop

return:
	add		rsp, 64						; release 64 bytes spaces on the stack
	pop		rbp
	ret
