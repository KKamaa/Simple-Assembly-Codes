section .bss
res resb 1

section .text
global _start

_start:
mov eax,56
mov ebx,52
div ebx

add eax,'0'
mov [res],eax

mov ecx,res
mov eax,4
mov ebx,1
mov edx,1
int 80h

mov eax,1
int 80h
