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
	push	r8				; store data of r8 in stack
	push	r9				; store data of r9 in stack

	mov		r8, rsi			; store data of rsi (buf) in r8 before fstat
	mov		r9, rdx			; store data of rdx (nbyte) in r9 before fstat
	mov		rsi, 0x0		; setting NULL pointer to the second parameter before fstat
	mov		rax, 0x20000BD	; 0x2000000 (MacOS ?) + 0xBD (fstat syscall)
	syscall					; fstat(rdi, rsi)
	cmp		rax, 9			; check if fstat returned 9 (errno 9:EBADF)
	je		_error_fd		; jump to _error_fd if ZF == 1

	mov		rsi, r8			; restore buf in rsi
	cmp		rsi, 0x0		; check if rsi (buf) is NULL pointer
	je		_error_addr		; jump to _error_addr if ZF == 1

	mov		rdx, r9			; restore nbyte in rdx
	mov		rax, 0x2000004	; 0x2000000 (MacOS ?) + 0x4 (write syscall)
	syscall					; write(rdi, rsi, rdx)
	cmp		rax, 22			; check if write returned 22 (errno 22:EINVAL)
	je		_error_args		; jump to _success if ZF == 0

_return:
	pop		r8				; restore data of r8
	pop		r9				; restore data of r9
	ret

_error_fd:
	call	___error		; store ptr of variable errno to rax
	mov		byte [rax], 9	; assign 9:EBADF to errno
	mov		rax, -1			; return value -1
	jmp		_return

_error_addr:
	call	___error		; store ptr of variable errno to rax
	mov		byte [rax], 14	; assign 14:EFAULT to errno
	mov		rax, -1			; return value -1
	jmp		_return

_error_args:
	cmp		rdx, 22			; check if third parameter is 22
	je		_return			; jump to _return if ZF == 1
	call	___error		; store ptr of variable errno to rax
	mov		byte [rax], 22	; assign 22:EINVAL to errno
	mov		rax, -1			; return value -1
	jmp		_return
