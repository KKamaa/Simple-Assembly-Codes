section .data
msg db "hello world!"
msg2 db "Bob is stupid"
len equ $-msg
len2 equ $-msg2

section .text
global _start

_start:

mov ecx,msg2
call printf

mov eax,4
mov ebx,1
mov edx,len2
int 80h

mov eax,1
int 80h

printf:
push ecx
mov ecx,msg
mov edx,len
mov eax,4
mov ebx,1
int 0x80
pop ecx
ret
