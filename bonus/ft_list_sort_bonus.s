; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_sort_bonus.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2021/03/22 03:08:27 by kefujiwa          #+#    #+#              ;
;    Updated: 2021/03/22 04:51:10 by kefujiwa         ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

; nasm -f macho64 ft_list_sort_bonus.s && gcc -o exec main.c ft_list_sort_bonus.o && ./exec
; void ft_list_sort(t_list **begin_list, int (*cmp)());

global _ft_list_sort

section .text
_ft_list_sort:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	sub		rsp, 16						; secure 16 bytes spaces on the stack for this function
	mov		qword [rbp - 8], rdi		; copy rdi (begin_list) on the stack
	mov		qword [rbp - 16], rsi		; copy rsi (cmp) on the stack
	cmp		qword [rbp - 8], 0			; if (begin_list == NULL)
	je		.return						; jump to .return if ZF == 1
	mov		rax, qword [rbp - 8]
	cmp		qword [rax], 0				; if (*begin_list == NULL)
	je		.return						; jump to .return if ZF == 1
	mov		rax, qword [rbp - 8]
	mov		rdi, qword [rax]			; copy *begin_list to rdi (first parameter)
	mov		rsi, qword [rbp - 16]		; copy cmp to rsi (second parameter)
	call	_merge_sort
	mov		rcx, qword [rbp - 8]
	mov		qword [rcx], rax			; *begin_list = merge_sort(*begin_list, cmp)

.return:
	add		rsp, 16						; release 16 bytes spaces on the stack
	pop		rbp
	ret

_merge_sort:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	sub		rsp, 64						; secure 64 bytes spaces on the stack for this function
	mov		qword [rbp - 16], rdi		; copy rdi (list) on the stack
	mov		qword [rbp - 24], rsi		; copy rsi (cmp) on the stack
	cmp		qword [rbp - 16], 0			; if (list == NULL)
	je		.end						; jump to .end if ZF == 1
	mov		rax, qword [rbp - 16]
	cmp		qword [rax + 8], 0
	jne		.init

.end:
	mov		rax, qword [rbp - 16]
	mov		qword [rbp - 8], rax		; return list
	jmp		.return

.init:
	mov		rax, qword [rbp - 16]
	mov		qword [rbp - 32], rax		; a = list
	mov		rax, qword [rbp - 16]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 40], rax		; b = lst->next
	cmp		qword [rbp - 40], 0			; if (b == NULL)
	je 		.loop						; jump to .loop if ZF == 1
	mov		rax, qword [rbp - 40]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 40], rax		; b = b->next

.loop:
	cmp		qword [rbp - 40], 0			; if (b == NULL)
	je		.recursive					; jump to .recursive if ZF == 1
	mov		rax, qword [rbp - 32]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 32], rax		; a = a->next
	mov		rax, qword [rbp - 40]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 40], rax		; b = b->next
	cmp		qword [rbp - 40], 0			; if (b == NULL)
	je		.recursive					; jump to .recursive if ZF == 1
	mov		rax, qword [rbp - 40]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 40], rax		; b = b->next

.recursive:
	mov		rax, qword [rbp - 32]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 48], rax		; x = a->next
	mov		rax, qword [rbp - 32]
	mov		qword [rax + 8], 0			; a->next = NULL
	mov		rdi, qword [rbp - 16]		; copy list to rdi (first parameter) before merge_sort
	mov		rsi, qword [rbp - 24]		; copy cmp to rsi (second parameter) before merge_sort
	call	_merge_sort
	mov		qword [rbp - 56], rax		; copy result of merge_sort on the stack
	mov		rdi, qword [rbp - 48]		; copy x to rdi (first parameter) before merge_sort
	mov		rsi, qword [rbp - 24]		; copy cmp to rsi (second parameter) before merge_sort
	call	_merge_sort
	mov		rdx, qword [rbp - 24]		; copy cmp to rdx (third paramter) before merge
	mov		rdi, qword [rbp - 56]		; copy result of first merge_sort to rdi (first parameter)
	mov		rsi, rax					; copy result of second merge_sort to rsi (second parameter)
	call	_merge
	mov		qword [rbp - 8], rax		; return result of merge

.return:
	mov		rax, qword [rbp - 8]
	add		rsp, 64						; release 64 bytes spaces on the stack
	pop		rbp
	ret

_merge:
	push	rbp							; push rbp (base pointer) onto the stack
	mov		rbp, rsp					; copy rsp (stack pointer) to rbp
	sub		rsp, 64						; secure 64 bytes spaces on the stack for this function
	mov		qword [rbp - 8], rdi		; copy rdi (a) on the stack
	mov		qword [rbp - 16], rsi		; copy rsi (b) on the stack
	mov		qword [rbp - 24], rdx		; copy rdx (cmp) on the stack
	lea		rax, [rbp - 40]				; copy &result to rax
	mov		qword [rbp - 48], rax		; x = &result

.loop:
	xor		eax, eax					; initialize eax to 0
	cmp		qword [rbp - 8], 0			; if (a == NULL)
	je		.next						; jump to loop_if if ZF == 1
	cmp		qword [rbp - 16], 0			; if (b == NULL)
	je		.next						; jump to loop_if if ZF == 1

.compare:
	mov		rax, qword [rbp - 24]		; copy cmp to rax
	mov		rcx, qword [rbp - 8]
	mov		rdi, qword [rcx]			; copy a->data to rdi (first parameter)
	mov		rcx, qword [rbp - 16]
	mov		rsi, qword [rcx]			; copy b->data to rsi (second paramter)
	call	rax							; cmp(a->data, b->data)
	cmp		eax, 0						; cmp(a->data, b->data) <= 0
	jle		.lower						; jump to .lower if (ZF = 1 | SF ! OF)

	mov		rax, qword [rbp - 16]
	mov		rcx, qword [rbp - 48]
	mov		qword [rcx + 8], rax		; x->next = b
	mov		rax, qword [rbp - 48]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 48], rax		; x = x->next
	mov		rax, qword [rbp - 16]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 16], rax		; b = b->next
	jmp		.loop

.lower:
	mov		rax, qword [rbp - 8]
	mov		rcx, qword [rbp - 48]
	mov		qword [rcx + 8], rax		; x->next = a
	mov		rax, qword [rbp - 48]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 48], rax		; x = x->next
	mov		rax, qword [rbp - 8]
	mov		rax, qword [rax + 8]
	mov		qword [rbp - 8], rax		; a = a->next
	jmp		.loop

.next:
	cmp		qword [rbp - 8], 0			; if (a == NULL)
	je		.nextb						; jump to .nextb if ZF == 0
	mov		rax, qword [rbp - 8]		; copy a to rax
	mov		rcx, qword [rbp - 48]		; copy x to rcx
	mov		qword [rcx + 8], rax		; x->next = a
	jmp		.return

.nextb:
	mov		rax, qword [rbp - 16]		; copy b to rax
	mov		rcx, qword [rbp - 48]		; copy x to rcx
	mov		qword [rcx + 8], rax		; x->next = b

.return:
	mov		rax, qword [rbp - 32]		; return (result.next)
	add		rsp, 64						; release 64 bytes spaces on the stack
	pop		rbp
	ret
