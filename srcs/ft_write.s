; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_write.s                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/17 23:12:09 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/18 18:16:49 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_write.s && gcc -o exec main.c ft_write.o && ./exec
; ssize_t ft_write(int fildes, const void *buf, size_t nbyte)

global _ft_write
extern ___error

section .text
_ft_write:
	mov		rax, 0x2000004	; 0x2000000 (MacOS ?) + 0x4 (write syscall)
	syscall					; write(rdi, rsi, rdx)
	jc		error			; jump to _success if CF == 1
	ret

error:
	mov		rdx, rax		; copy rax (return value of syscall) to rdx
	call	___error		; store ptr of variable errno to rax
	mov		byte [rax], dl	; assign return value of syscall to errno
	mov		rax, -1			; set -1 as return value
	ret
