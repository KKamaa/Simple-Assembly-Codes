sys_execve equ 59
sys_exit equ 60

section .data
    cmd db "/usr/bin/wget ", 0
    url db "http://www.mycatnames.com/wp-content/uploads/2015/09/Great-Ideas-for-cute-cat-names-2.jpg",0
    env db 0h

global _start

section .text
    _start:
        mov rdi, cmd ;wget
        mov rsi,url
        ;lea rsi, [rel args] ;pointer array argv starting from arg0
        mov rdx, env ; env= 0

        mov rax, sys_execve ; execve
        syscall
        mov rax, rdi        ; #1 Return value
        mov rax, sys_exit   ; exit
        syscall
