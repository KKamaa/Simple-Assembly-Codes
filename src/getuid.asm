%include 'functions.asm'

section .text
global _start

_start:
mov eax,64
int 80h

mov ecx,eax
add ecx,48
mov eax,4
mov edx,1
mov ebx,1
int 80h

mov eax,1
int 80h

