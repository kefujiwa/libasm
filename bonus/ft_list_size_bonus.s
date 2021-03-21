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
; int ft_list_size(t_list *lst);

global _ft_list_size

section .text
_ft_list_size:
	mov		rax, 0				; initialize counter to 0

_loop:
	cmp		rdi, 0				; if (lst == NULL)
	je		_return				; jump to _return if ZF == 1
	mov		rdi, [rdi + 8]		; lst = lst->next : sizeof(void*) is 8 in my platform
	inc		rax					; rax++
	jmp		_loop

_return:
	ret
