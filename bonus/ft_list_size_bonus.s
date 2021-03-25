; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_size_bonus.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/21 16:57:01 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/21 18:01:01 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_list_size_bonus.s && gcc -o exec main.c ft_list_size_bonus.o && ./exec
; int ft_list_size(t_list *begin_list);

global _ft_list_size

section .text
_ft_list_size:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	mov		qword [rbp - 8], rdi	; copy rdi (begin_list) on the stack
	mov		dword [rbp - 12], 0		; cnt = 0

loop:
	cmp		qword [rbp - 8], 0		; if (begin_list == NULL)
	je		return						; jump to return if ZF == 1

	mov		eax, dword [rbp - 12]
	inc		eax							; cnt++
	mov		dword [rbp - 12], eax

	mov		rcx, qword [rbp - 8]
	mov		rcx, qword [rcx + 8]
	mov		qword [rbp - 8], rcx	; begin_list = begin_list->next
	jmp		loop

return:
	mov		eax, dword [rbp - 12]	; return cnt
	pop		rbp
	ret
