section .data
cmd DT '//usr/bin/wget'
section .text
global _start
 
_start:
xor     rdx, rdx
mov     rbx, cmd;remember its 64bit == 8 bytes so a qword
;shr     rbx, 0x8 ;logicall shift numbers by 8 basically the arguments of execv() are
                 ; put as NULL,NULL....i think :(..shit!
mov qword r10,"www.google.com"
mov r9,0h
mov r8,0h                 

push    rbx   ;save to stack
mov     rdi, rsp ;get current stack pointer=ebx
push    rax ;save rax reg to stack
push    rdi ;save rdi reg to stack
mov     rsi, rsp ;mov current stack point to rsi=rdi=ebx
mov     al, 59 ;call execv()
syscall 

mov rax,60 ;exit but no need for this
syscall
