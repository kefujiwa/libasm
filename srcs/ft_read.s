; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_read.s                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/18 22:02:47 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/18 22:22:45 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_read.s && gcc -o exec main.c ft_read.s && ./exec
; ssize_t ft_read(int fildes, void *buf, size_t nbyte);

global _ft_read
extern ___error

section .text
_ft_read:
	mov		rax, 0x2000003	; 0x2000000 (MacOS ?) + 0x3 (read syscall)
	syscall					; read(rdi, rsi, rdx)
	jc		error			; jump to ___error if CF == 1
	ret

error:
	mov		rdx, rax		; copy rax (return value of syscall) to rcx
	call	___error		; store ptr of variable errno to rax
	mov		byte [rax], dl	; assign return value of syscall to errno
	mov		rax, -1			; set -1 as return value
	ret
