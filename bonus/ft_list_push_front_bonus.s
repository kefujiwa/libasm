; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_push_front_bonus.s                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/21 18:54:21 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/21 20:14:28 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_list_push_front_bonus.s && gcc -o exec main.c ft_list_push_front_bonus.o && ./exec
; void ft_list_push_front(t_list **begin_list, void *data);

global _ft_list_push_front
extern ___error
extern _malloc

section .text
_ft_list_push_front:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	sub		rsp, 32						; secure 32 bytes spaces on the stack for this function
	mov		qword [rbp - 8], rdi		; copy rdi (begin_list) on the stack
	mov		qword [rbp - 16], rsi		; copy rsi (data) on the stack
	cmp		qword [rbp - 8], 0			; if (begin_list == NULL)
	je		.return						; jump to .return if ZF == 1
	mov		rdi, qword [rbp - 16]		; copy data to rdi (first parameter) before ft_list_new
	call	_ft_list_new				; new = ft_list_new(data)
	mov		qword [rbp - 24], rax
	cmp		rax, 0						; if (new == NULL)
	je		.return						; jump to .return if ZF == 1
	mov		rax, qword [rbp - 8]
	mov		rax, qword [rax]			; copy *begin_list to rax
	mov		rcx, qword [rbp - 24]
	mov		qword [rcx + 8], rax		; new->next = *begin_list
	mov		rax, qword [rbp - 24]		; copy new to rax
	mov		rcx, qword [rbp - 8]		; copy begin_list to rcx
	mov		qword [rcx], rax			; *begin_list = new

.return:
	add		rsp, 32						; release 32 bytes spaces on the stack
	pop		rbp
	ret

_ft_list_new:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	sub		rsp, 32						; secure 32 bytes spaces on the stack for this function
	mov		qword [rbp - 16], rdi		; copy rsi (data) on the stack
	mov		edi, 16						; copy sizeof(t_list) to edi (first parameter)
	call	_malloc						; new = malloc(sizeof(t_list))
	mov		qword [rbp - 24], rax
	cmp		qword [rbp - 24], 0			; if (new == NULL)
	jne		.assign						; jump to .assign if ZF == 0
	mov		qword [rbp - 8], 0			; return NULL if ZF == 1
	jmp		.return

.assign:
	mov		rax, qword [rbp - 16]		; copy data to rax
	mov		rcx, qword [rbp - 24]		; copy new to rcx
	mov		qword [rcx], rax			; new->data = data
	mov		qword [rcx + 8], 0			; new->next = NULL
	mov		qword [rbp - 8], rcx		; return new

.return:
	mov		rax, qword [rbp - 8]
	add		rsp, 32						; release 32 bytes spaces on the stack
	pop		rbp
	ret
