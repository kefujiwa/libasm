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
	cmp		rdi, 0				; if (begin_list == NULL)
	je		_return				; jump to _return if ZF == 1

	push	rdi					; push rdi (begin_list) onto the stack
	push	rsi					; push rsi (data) onto the stack
	mov		rdi, 16				; copy size of (t_list) to rdi (first parameter)
	call	_malloc				; new = malloc(sizeof(t_list))
	pop		rsi					; pop the last stack element off and store it to rsi
	pop		rdi					; pop the last stack element off and store it to rdi
	cmp		rax, 0				; if (new == NULL)
	je		_error				; jump to _error if ZF == 1

	mov		[rax], rsi			; copy value of rsi (data) to new->data
	mov		r10, [rdi]			; copy value of *begin_list to r10
	mov		[rax + 8], r10		; copy r10 to new->next
	mov		[rdi], rax			; *begin_list = new

_return:
	ret

_error:
	call	___error			; store ptr of variable errno to rax
	mov		[rax], byte 12		; assign error number:12 (ENOMEM) to variable errno
	ret
