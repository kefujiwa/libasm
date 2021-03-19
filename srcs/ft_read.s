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
	push	r8				; store data of r8 in stack
	push	r9				; store data of r9 in stack

	mov		r8, rsi			; store data of second parameter in r8 before fstat
	mov		r9, rdx			; store data of third parameter in r9 before fstat
	mov		rsi, 0x0		; setting NULL pointer to the second parameter before fstat
	mov		rax, 0x20000BD	; 0x2000000 (MacOS ?) + 0xBD (fstat syscall)
	syscall					; fstat(rdi, rsi)
	cmp		rax, 9			; check if fstat returned 9 (errno 9:EBADF)
	je		_error_fd		; jump to _error_fd if ZF == 1

	mov		rsi, r8			; restore second parameter in rsi
	cmp		rsi, 0x0		; check if the second parameter is NULL pointer
	je		_error_addr		; jump to _error_addr if ZF == 1

	mov		rdx, r9			; restore third parameter in rdx
	cmp		rdx, 0			; check if the third parameter is negative
	js		_error_args		; jump to _error_args if SF == 1

	mov		rax, 0x2000003	; 0x2000000 (MacOS ?) + 0x3 (read syscall)
	syscall					; write(rdi, rsi, rdx)

_return:
	pop		r8				; restore data of r8
	pop		r9				; restore data of r9
	ret


_error_fd:
	call	___error		; return ptr of variable errno
	mov		byte [rax], 9	; assign 9:EBADF to errno
	mov		rax, -1			; return value -1
	jmp		_return

_error_addr:
	call	___error		; return ptr of variable errno
	mov		byte [rax], 14	; assign 14:EFAULT to errno
	mov		rax, -1			; return value -1
	jmp		_return

_error_args:
	call	___error		; return ptr of variable errno
	mov		byte [rax], 22	; assign 22:EINVAL
	mov		rax, -1			; return value -1
	jmp		_return
